import UIKit

class OptionsViewController: UIViewController {

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
    }
        
    
    @objc func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
//        let VC = ViewController()
//        present(VC, animated: true, completion: nil)
        
    }
        
}
