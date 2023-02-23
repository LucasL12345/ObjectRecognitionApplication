import UIKit
import AVFoundation

class OptionsViewController: UIViewController {

    let fontSizes = [UIFont.systemFontSize+7, UIFont.systemFontSize + 10, UIFont.systemFontSize + 15]
    var currentFontSizeIndex = 0
    var buttons: [UIButton] = []
    var items = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p"]
    var buttonColors: [UIColor] = []
    var selected_items = ["test"]
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Select items to locate"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let synthesizer = AVSpeechSynthesizer()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.setTitle("Back", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    let confirmButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 10
        button.setTitle("Confirm", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            backButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 150),
            backButton.heightAnchor.constraint(equalToConstant: 80),
        ])
        

        let fontSizeButton = UIButton()
        fontSizeButton.setTitle("Aa", for: .normal)
        fontSizeButton.backgroundColor = .systemBlue
        fontSizeButton.layer.borderWidth = 1.0
        fontSizeButton.layer.borderColor = UIColor.black.cgColor
        fontSizeButton.layer.cornerRadius = 10
        fontSizeButton.setTitleColor(.white, for: .normal)
        fontSizeButton.titleLabel?.font = UIFont.systemFont(ofSize: fontSizes[currentFontSizeIndex])
        fontSizeButton.addTarget(self, action: #selector(fontSizeButtonTapped), for: .touchUpInside)

        fontSizeButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(fontSizeButton)
        NSLayoutConstraint.activate([
            fontSizeButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            fontSizeButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
            fontSizeButton.widthAnchor.constraint(equalToConstant: 100),
            fontSizeButton.heightAnchor.constraint(equalToConstant: 60),
        ])

        navigationItem.titleView = titleLabel
        navigationItem.titleView?.contentMode = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 20),
            titleLabel.widthAnchor.constraint(equalToConstant: view.bounds.width - 40),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let buttonTitles = items
        
        // load button colors from user defaults
        if let savedButtonColors = UserDefaults.standard.array(forKey: "buttonColors") as? [Data] {
            for savedButtonColor in savedButtonColors {
                if let color = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedButtonColor) as? UIColor {
                    buttonColors.append(color)
                }
            }
        }
        
        for i in 0..<buttonTitles.count {
            let button = UIButton()
            button.setTitle(buttonTitles[i], for: .normal)
            button.backgroundColor = .white
            button.setTitleColor(.black, for: .normal)
            button.layer.cornerRadius = 10
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.borderWidth = 1
            button.layer.masksToBounds = true
            button.tag = i
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            buttons.append(button)
            scrollView.addSubview(button)
            
            // set button color from array
            if i < buttonColors.count {
                button.backgroundColor = buttonColors[i]
            } else {
                buttonColors.append(button.backgroundColor ?? .white)
            }
        }
        
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(confirmButton)

        NSLayoutConstraint.activate([
            confirmButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            confirmButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            confirmButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            confirmButton.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let buttonWidth = (view.bounds.width - 30) / 2 // subtracting 30 instead of 20 to account for the gap between the buttons
        let buttonHeight: CGFloat = 60
        let topMargin: CGFloat = 10.0
        let numberOfColumns = 2
        
        for i in 0..<buttons.count {
            let row = i / numberOfColumns // integer division to determine row number
            let col = i % numberOfColumns // modulus to determine column number
            let button = buttons[i]
            let x = CGFloat(col) * (buttonWidth + 10) + 10 // adding 10 for gap between buttons
            let y = topMargin + CGFloat(row) * (buttonHeight + 10)
            button.frame = CGRect(x: x, y: y, width: buttonWidth, height: buttonHeight)
        }
        
        scrollView.contentSize = CGSize(width: scrollView.bounds.width, height: topMargin + CGFloat((buttons.count + 1) / 2) * (buttonHeight + 10) + 150)

    }

    
    @objc func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @objc func fontSizeButtonTapped() {
        currentFontSizeIndex = (currentFontSizeIndex + 1) % fontSizes.count
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: fontSizes[currentFontSizeIndex] + 5)
        
        for button in buttons {
            button.titleLabel?.font = UIFont.systemFont(ofSize: fontSizes[currentFontSizeIndex])
        }
        
        // Update font size for the back and confirm buttons
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: fontSizes[currentFontSizeIndex])
        confirmButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSizes[currentFontSizeIndex]+5)
    }

    
    @IBAction func buttonTapped(_ button: UIButton) {
        button.backgroundColor = button.backgroundColor == .white ? .systemBlue : .white
        buttonColors[button.tag] = button.backgroundColor ?? .white
        
        // save button colors to user defaults
        let savedButtonColors = buttonColors.map { try? NSKeyedArchiver.archivedData(withRootObject: $0, requiringSecureCoding: false) }
        UserDefaults.standard.set(savedButtonColors, forKey: "buttonColors")
    }


    
    @objc func confirmButtonTapped() {
        self.dismiss(animated: true, completion: nil)
        let utterance = AVSpeechUtterance(string: "You have selected: \(selected_items.joined(separator: ", "))")
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        synthesizer.speak(utterance)
    }
        
}
