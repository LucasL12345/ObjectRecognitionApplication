import UIKit

class InformationViewController: UIViewController {

    let fontSizes = [UIFont.systemFontSize + 10, UIFont.systemFontSize + 15, UIFont.systemFontSize + 20]
    var currentFontSizeIndex = 0 {
        didSet {
            // Update font size for the title label, paragraph label, and back button
            titleLabel.font = UIFont.boldSystemFont(ofSize: fontSizes[currentFontSizeIndex] + 5)
            paragraphLabel.font = UIFont.systemFont(ofSize: fontSizes[currentFontSizeIndex])
            backButton.titleLabel?.font = UIFont.systemFont(ofSize: fontSizes[currentFontSizeIndex] + 5)

            // Save font size index in user defaults
            UserDefaults.standard.set(currentFontSizeIndex, forKey: "currentFontSizeIndex")
        }
    }
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    
    
    let backButton = UIButton()
    
    let titleLabel = UILabel()
    
    let paragraphLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        if let index = UserDefaults.standard.object(forKey: "currentFontSizeIndex") as? Int {
            currentFontSizeIndex = index
        }

        backButton.setTitle("Back", for: .normal)
            backButton.setTitleColor(.white, for: .normal)
            backButton.backgroundColor = .black
            backButton.layer.cornerRadius = 10
            backButton.titleLabel?.font = UIFont.systemFont(ofSize: fontSizes[currentFontSizeIndex])
            backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
            backButton.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(backButton)

            titleLabel.text = "App Information"
            titleLabel.font = UIFont.boldSystemFont(ofSize: fontSizes[currentFontSizeIndex])
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(titleLabel)

            paragraphLabel.text = "This app is designed to help visually impaired people locate objects that they may have lost as well as help them to identify dangerous objects around them using the devices camera. There are three main buttons. Firstly, a large button at the bottom with two modes - find all objects and find selected objects. Find all objects mode will read out any objects the app can detect through the devices camera, and find selected objects will only notify the user of objects selected in the Choose Items page. To get to this page you can press the button at the top right of the screen. In this page, there is a list of objects that you can select, with a Confirm button at the bottom or a back button at the top left to go back to the main page. Finally, on the main page there is an Information page (this page) describing the app's layout. There is also a text resize button at the top right of both the information page and the Choose items page as well as back buttons at the top left of both these pages."
            paragraphLabel.textAlignment = .center
            paragraphLabel.numberOfLines = 0
            paragraphLabel.font = UIFont.systemFont(ofSize: fontSizes[currentFontSizeIndex])
            paragraphLabel.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(paragraphLabel)


        self.view.addSubview(scrollView)

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
        ])
        
        let fontSizeButton = UIButton()
        fontSizeButton.setTitle("Aa", for: .normal)
        fontSizeButton.backgroundColor = .white
        fontSizeButton.layer.borderWidth = 1.0
        fontSizeButton.layer.borderColor = UIColor.black.cgColor
        fontSizeButton.layer.cornerRadius = 10
        fontSizeButton.setTitleColor(.black, for: .normal)
        fontSizeButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        fontSizeButton.addTarget(self, action: #selector(fontSizeButtonTapped), for: .touchUpInside)

        fontSizeButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(fontSizeButton)
        NSLayoutConstraint.activate([
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
        currentFontSizeIndex = (currentFontSizeIndex + 1) % fontSizes.count

        titleLabel.font = UIFont.boldSystemFont(ofSize: fontSizes[currentFontSizeIndex])
        
        paragraphLabel.font = UIFont.systemFont(ofSize: fontSizes[currentFontSizeIndex])

        // Update font size for the back and confirm buttons
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: fontSizes[currentFontSizeIndex])

        // Save font size index in user defaults
        UserDefaults.standard.set(currentFontSizeIndex, forKey: "currentFontSizeIndex")
    }
}
