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
            backButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 150),
            backButton.heightAnchor.constraint(equalToConstant: 80),
        ])
        
        let titleLabel = UILabel()
        titleLabel.text = "App Information"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(titleLabel)
        
        let paragraphLabel = UILabel()
        paragraphLabel.text = "This app is designed to help visually impaired people locate objects that they may have lost. There are three main buttons. At the top left, there is an app information button (this page), in the top right is a 'choose items' button in which you can select all the objects that you may want to find. Lastly, there is a large button at the bottom of the page which when pressed will change what object the app looks for from the ones selected in the 'choose items' page. This button also has a simplified 'find all items' setting by default which will read out any items the app finds regarless of whether or not it's in your chosen items."
        
        paragraphLabel.textAlignment = .center
        paragraphLabel.numberOfLines = 0
        paragraphLabel.font = UIFont.systemFont(ofSize: 20)
        paragraphLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(paragraphLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 20),
            paragraphLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            paragraphLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
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
