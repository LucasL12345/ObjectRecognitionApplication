import UIKit

class OptionsViewController: UIViewController {

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
        backButton.backgroundColor = .darkGray
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
        
        
        let buttonGrid = GridStack(rows: 3, columns: 2)
        var buttonIndex = 0
        for row in 0..<3 {
            for column in 0..<2 {
                let button = UIButton(type: .system)
                let item = items[buttonIndex]
                button.setTitle(item, for: .normal)
                button.backgroundColor = .systemBlue
                button.layer.borderWidth = 1.0
                button.layer.borderColor = UIColor.black.cgColor
                button.layer.cornerRadius = 10
                button.setTitleColor(.white, for: .normal)
                button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
                button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
                button.translatesAutoresizingMaskIntoConstraints = false
                buttonGrid.arrangedSubviews[row].subviews[column].addSubview(button)
                buttonIndex += 1
            }
        }

        buttonGrid.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(buttonGrid)
        NSLayoutConstraint.activate([
            buttonGrid.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            buttonGrid.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            buttonGrid.widthAnchor.constraint(equalToConstant: 100),
            buttonGrid.heightAnchor.constraint(equalToConstant: 100),
        ])

        

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
        
        NSLayoutConstraint.activate([
            confirmButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            confirmButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            confirmButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            confirmButton.topAnchor.constraint(equalTo: buttonGrid.bottomAnchor ?? titleLabel.bottomAnchor, constant: 20),
            confirmButton.heightAnchor.constraint(equalToConstant: 60)
        ])
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


class GridStack: UIStackView {
    init(rows: Int, columns: Int) {
        super.init(frame: .zero)
        axis = .vertical
        alignment = .fill
        distribution = .fillEqually
        self.translatesAutoresizingMaskIntoConstraints = false
        for _ in 0..<rows {
            let row = UIStackView()
            row.axis = .horizontal
            row.alignment = .fill
            row.distribution = .fillEqually
            addArrangedSubview(row)
            for _ in 0..<columns {
                let view = UIView()
                row.addArrangedSubview(view)
            }
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
