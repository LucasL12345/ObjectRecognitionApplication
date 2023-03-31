import UIKit

class InformationViewController: UIViewController {

    lazy var fontManager = FontManager.shared
    
    lazy var currentFontSize: CGFloat = {
        return fontManager.getFontSize()
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setTitle("Back", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.systemFont(ofSize: currentFontSize)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "App Information"
        label.font = UIFont.boldSystemFont(ofSize: currentFontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var paragraphLabel: UILabel = {
        let label = UILabel()
        label.text = "This app is designed to help visually impaired people locate items. There are four pages in the app, centered around the main view page. On this page, there are three main buttons. A large button at the bottom with two modes - finding all objects and finding selected objects. Finding all objects mode will read out any objects the app can detect through the device's camera, and finding selected objects mode will only read out any objects found that are selected in the Choose Items page. The next button is located on the top right of the screen. This will take you to the Choose Items page. In this page, there is a list of objects that you can select, and then press either the Confirm button at the bottom or the Back button at the top left to go back to the main page. Finally, the third button on the main page is at the top left of the screen. This will take you to the Settings page. From this page you can turn the vibration on or off for both the finding object modes, turn dark mode on or off, and go to the app information page (this page). Every page except the main page, has large back buttons located in the top left, and a text resizing option located in the top right."
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: currentFontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var fontSizeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Aa", for: .normal)
        button.backgroundColor = .white
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 10
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        button.addTarget(self, action: #selector(fontSizeButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: currentFontSize)
        titleLabel.font = UIFont.boldSystemFont(ofSize: currentFontSize + 5)
        paragraphLabel.font = UIFont.systemFont(ofSize: currentFontSize)
        
        if let index = UserDefaults.standard.object(forKey: "currentFontSizeIndex") as? Int {
            fontManager.currentFontSizeIndex = index
        }
        
        scrollView.addSubview(backButton)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(paragraphLabel)
        self.view.addSubview(scrollView)
        self.view.addSubview(fontSizeButton)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            backButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            backButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 150),
            backButton.heightAnchor.constraint(equalToConstant: 80),

            titleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 20),

            paragraphLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            paragraphLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            paragraphLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            paragraphLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            paragraphLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            
            fontSizeButton.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: (self.view.bounds.width / 8) * 0.85),
            fontSizeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: (self.view.bounds.width / 8) * -0.85),
            fontSizeButton.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            fontSizeButton.widthAnchor.constraint(equalToConstant: 100),
            fontSizeButton.heightAnchor.constraint(equalToConstant: 60),
        ])
        
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: paragraphLabel.frame.origin.y + paragraphLabel.frame.size.height + 20)
    }


    @objc func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }

    
    @objc func fontSizeButtonTapped() {
        let newFontSize = fontManager.increaseFontSize()
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: newFontSize)
        titleLabel.font = UIFont.boldSystemFont(ofSize: newFontSize + 5)
        paragraphLabel.font = UIFont.systemFont(ofSize: newFontSize)
    }

}
