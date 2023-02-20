import UIKit

class InformationViewController: UIViewController {
    
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
            backButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30),
            backButton.widthAnchor.constraint(equalToConstant: 150),
            backButton.heightAnchor.constraint(equalToConstant: 80),
        ])
        
        let titleLabel = UILabel()
        titleLabel.text = "App Information"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 32)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(titleLabel)
        
        let paragraphLabel = UILabel()
        paragraphLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed fringilla orci ac leo aliquet congue. Nulla non blandit justo. Nullam non mauris pellentesque, placerat nulla vel, semper libero. Nunc et tempor dolor."
        
        paragraphLabel.textAlignment = .center
        paragraphLabel.numberOfLines = 0
        paragraphLabel.font = UIFont.systemFont(ofSize: 22)
        paragraphLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(paragraphLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 30),
            paragraphLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            paragraphLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            paragraphLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            paragraphLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
        ])
    }
    
    @objc func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
//        let VC = ViewController()
//        present(VC, animated: true, completion: nil)
        
    }

}
