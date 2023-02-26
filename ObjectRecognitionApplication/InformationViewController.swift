import UIKit

class InformationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        let scrollView: UIScrollView = {
            let scrollView = UIScrollView()
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            return scrollView
        }()

        let backButton = UIButton()
        backButton.setTitle("Back", for: .normal)
        backButton.setTitleColor(.white, for: .normal)
        backButton.backgroundColor = .black
        backButton.layer.cornerRadius = 10
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(backButton)

        let titleLabel = UILabel()
        titleLabel.text = "App Information"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(titleLabel)

        let paragraphLabel = UILabel()
        paragraphLabel.text = "This app is designed to help visually impaired people locate objects that they may have lost. There are three main buttons. At the top left, there is an app information button (this page), in the top right is a 'choose items' button in which you can select all the objects that you may want to find. Lastly, there is a large button at the bottom of the page which when pressed will change what object the app looks for from the ones selected in the 'choose items' page. This button also has a simplified 'find all items' setting by default which will read out any items the app finds regarless of whether or not it's in your chosen items."
        paragraphLabel.textAlignment = .center
        paragraphLabel.numberOfLines = 0
        paragraphLabel.font = UIFont.systemFont(ofSize: 20)
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

        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: paragraphLabel.frame.origin.y + paragraphLabel.frame.size.height + 20)
    }

    @objc func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}
