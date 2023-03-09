import UIKit

class SettingsViewController: UIViewController {
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    
    let backButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        backButton.setTitle("Back", for: .normal)
            backButton.setTitleColor(.white, for: .normal)
            backButton.backgroundColor = .black
            backButton.layer.cornerRadius = 10
            backButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
            backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
            backButton.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(backButton)

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
        ])
    }

    @objc func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

