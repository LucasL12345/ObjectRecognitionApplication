import UIKit

class OptionsViewController: UIViewController {

    var buttons: [UIButton] = []
    var items = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p"]
    var buttonColors: [UIColor] = []
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let backButton = UIButton()
        backButton.setTitle("Back", for: .normal)
        backButton.setTitleColor(.white, for: .normal)
        backButton.backgroundColor = .black
        backButton.layer.cornerRadius = 10
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            backButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 150),
            backButton.heightAnchor.constraint(equalToConstant: 80),
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
        
        let confirmButton = UIButton(type: .system)
        confirmButton.backgroundColor = .systemBlue
        confirmButton.layer.borderWidth = 1.0
        confirmButton.layer.borderColor = UIColor.black.cgColor
        confirmButton.layer.cornerRadius = 10
        confirmButton.setTitle("Confirm", for: .normal)
        confirmButton.setTitleColor(.white, for: .normal)
        confirmButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        confirmButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(confirmButton)

        let buttonCount = CGFloat(buttons.count)
        let confirmButtonTopAnchor = buttonCount > 0 ? buttons[0].bottomAnchor : titleLabel.bottomAnchor




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



    
    @IBAction func buttonTapped(_ button: UIButton) {
        button.backgroundColor = button.backgroundColor == .white ? .systemBlue : .white
        buttonColors[button.tag] = button.backgroundColor ?? .white
        
        // save button colors to user defaults
        let savedButtonColors = buttonColors.map { try? NSKeyedArchiver.archivedData(withRootObject: $0, requiringSecureCoding: false) }
        UserDefaults.standard.set(savedButtonColors, forKey: "buttonColors")
    }

    
    @objc func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
//        let VC = ViewController()
//        present(VC, animated: true, completion: nil)
        
    }
        
}
