import UIKit

class OptionsViewController: UIViewController {

    var buttons: [[UIButton]] = []
    var items = ["a", "b", "c", "d", "e", "f", "g", "h"]
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Select items to locate"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
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
        
        let buttonTitles = items
        
        for i in 0..<buttonTitles.count {
            let button1 = UIButton()
            let button2 = UIButton()
            button1.setTitle(buttonTitles[i], for: .normal)
            button2.setTitle(buttonTitles[i], for: .normal)
            button1.backgroundColor = .white
            button2.backgroundColor = .white
            button1.setTitleColor(.black, for: .normal)
            button2.setTitleColor(.black, for: .normal)
            button1.layer.cornerRadius = 10
            button2.layer.cornerRadius = 10
            button1.layer.borderColor = UIColor.black.cgColor
            button2.layer.borderColor = UIColor.black.cgColor
            button1.layer.borderWidth = 1
            button2.layer.borderWidth = 1
            button1.layer.masksToBounds = true
            button2.layer.masksToBounds = true
            button1.tag = i
            button2.tag = i
            button1.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            button2.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            buttons.append([button1, button2])
            view.addSubview(button1)
            view.addSubview(button2)
        }
        
    }
        
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let buttonWidth = (view.bounds.width - 20) / 2
        let buttonHeight: CGFloat = 70
        let topMargin = titleLabel.frame.origin.y + titleLabel.frame.size.height + 10.0
        
        for i in 0..<buttons.count {
            let buttonPair = buttons[i]
            let button1 = buttonPair[0]
            let button2 = buttonPair[1]
            let isEven = i % 2 == 0
            
            button1.frame = CGRect(x: isEven ? 10 : view.bounds.width / 2 + 5, y: topMargin + CGFloat(i / 2) * (buttonHeight + 5), width: buttonWidth, height: buttonHeight)
            button2.frame = CGRect(x: isEven ? view.bounds.width / 2 + 5 : 10, y: topMargin + CGFloat(i / 2) * (buttonHeight + 5), width: buttonWidth, height: buttonHeight)
        }
    }



    
    @IBAction func buttonTapped(_ button: UIButton) {
        print("tapped")
    }
    
    @objc func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
//        let VC = ViewController()
//        present(VC, animated: true, completion: nil)
        
    }
        
}
