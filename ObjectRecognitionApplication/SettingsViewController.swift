import UIKit

class SettingsViewController: UIViewController {
    
    lazy var fontManager = FontManager.shared

    lazy var currentFontSize: CGFloat = {
        return fontManager.getFontSize()
    }()

    let backButton = UIButton()
    var all_obj_vibration_mode = true
    var selected_obj_vibration_mode = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        all_obj_vibration_mode = UserDefaults.standard.bool(forKey: "all_obj_vibration_mode")
        selected_obj_vibration_mode = UserDefaults.standard.bool(forKey: "selected_obj_vibration_mode")
        
        if let vibration1Row = view.subviews.first(where: { $0 is UITableViewCell && ($0 as! UITableViewCell).textLabel?.text == "All objects vibration" }) as? UITableViewCell,
           let vibration1Switch = vibration1Row.contentView.subviews.first(where: { $0 is UISwitch }) as? UISwitch {
            vibration1Switch.isOn = all_obj_vibration_mode
        }

        if let vibration2Row = view.subviews.first(where: { $0 is UITableViewCell && ($0 as! UITableViewCell).textLabel?.text == "Selected objects vibration" }) as? UITableViewCell,
           let vibration2Switch = vibration2Row.contentView.subviews.first(where: { $0 is UISwitch }) as? UISwitch {
            vibration2Switch.isOn = selected_obj_vibration_mode
        }
    
        backButton.setTitle("Back", for: .normal)
            backButton.setTitleColor(.white, for: .normal)
            backButton.backgroundColor = .black
            backButton.layer.cornerRadius = 10
            backButton.titleLabel?.font = UIFont.systemFont(ofSize: currentFontSize)
            backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
            backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)

        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 150),
            backButton.heightAnchor.constraint(equalToConstant: 80),
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
        
        
        // Add the three rows as subviews to the main view
        addInformationRow()
        addVibration1Row()
        addVibration2Row()
    }
    
    private func addInformationRow() {
        let informationRow = UITableViewCell(style: .default, reuseIdentifier: nil)
        informationRow.backgroundColor = UIColor.white
        informationRow.textLabel?.text = "Information"
        informationRow.textLabel?.font = UIFont.systemFont(ofSize: currentFontSize)
        informationRow.selectionStyle = .none
        informationRow.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        informationRow.layer.cornerRadius = 10
        informationRow.clipsToBounds = true
        informationRow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showInformation)))
        informationRow.layer.borderWidth = 1.0
        informationRow.layer.borderColor = UIColor.gray.cgColor
        view.addSubview(informationRow)

        informationRow.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            informationRow.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 20),
            informationRow.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            informationRow.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            informationRow.heightAnchor.constraint(equalToConstant: 50) // Change the height here
        ])
        
        let currentFontSize = FontManager.shared.getFontSize()


        if #available(iOS 13.0, *) {
            let arrowImageView = UIImageView(image: UIImage(systemName: "chevron.right"))
            arrowImageView.tintColor = .black
            arrowImageView.contentMode = .scaleAspectFit
            arrowImageView.translatesAutoresizingMaskIntoConstraints = false
            informationRow.addSubview(arrowImageView)

            NSLayoutConstraint.activate([
                arrowImageView.centerYAnchor.constraint(equalTo: informationRow.centerYAnchor),
                arrowImageView.trailingAnchor.constraint(equalTo: informationRow.trailingAnchor, constant: -15),
                arrowImageView.widthAnchor.constraint(equalToConstant: 20),
                arrowImageView.heightAnchor.constraint(equalToConstant: 20)
            ])
        }
    }



    private func addVibration1Row() {
        let vibration1Row = createRow(title: "All objects vibration")
        vibration1Row.heightAnchor.constraint(equalToConstant: 50).isActive = true // Change the height here
        view.addSubview(vibration1Row)
        
        vibration1Row.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            vibration1Row.topAnchor.constraint(equalTo: view.subviews[view.subviews.count - 2].bottomAnchor, constant: 5),
            vibration1Row.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            vibration1Row.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }

    private func addVibration2Row() {
        let vibration2Row = createRow(title: "Selected objects vibration")
        vibration2Row.heightAnchor.constraint(equalToConstant: 50).isActive = true // Change the height here
        view.addSubview(vibration2Row)
        
        vibration2Row.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            vibration2Row.topAnchor.constraint(equalTo: view.subviews[view.subviews.count - 2].bottomAnchor, constant: 5),
            vibration2Row.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            vibration2Row.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }


    // Helper method to create a row with a given title
    private func createRow(title: String) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.backgroundColor = UIColor.white
        cell.textLabel?.text = title
        cell.textLabel?.font = UIFont.systemFont(ofSize: currentFontSize)
        cell.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        cell.selectionStyle = .none
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.gray.cgColor
        
        let switchView = UISwitch()
        switchView.addTarget(self, action: #selector(switchToggled(_:)), for: .valueChanged)
        cell.contentView.addSubview(switchView)
        switchView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            switchView.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
            switchView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -15),
            switchView.widthAnchor.constraint(equalToConstant: 51),
            switchView.heightAnchor.constraint(equalToConstant: 31),
        ])

        if let textLabel = cell.textLabel {
            textLabel.numberOfLines = 0 // allow text to wrap to multiple lines
            textLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                textLabel.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 15),
                textLabel.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 10),
                textLabel.trailingAnchor.constraint(equalTo: switchView.leadingAnchor, constant: -10)
            ])
            
            let bottomConstraint = textLabel.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -10)
            bottomConstraint.priority = .defaultHigh
            bottomConstraint.isActive = true
        }

        return cell
    }




    @objc private func vibration1RowTapped(_ sender: UITapGestureRecognizer) {
        if let cell = sender.view as? UITableViewCell,
           let switchView = cell.contentView.subviews.first(where: { $0 is UISwitch }) as? UISwitch {
            switchView.setOn(!switchView.isOn, animated: true)
            all_obj_vibration_mode = switchView.isOn
        }
    }

    @objc private func vibration2RowTapped(_ sender: UITapGestureRecognizer) {
        if let cell = sender.view as? UITableViewCell,
           let switchView = cell.contentView.subviews.first(where: { $0 is UISwitch }) as? UISwitch {
            switchView.setOn(!switchView.isOn, animated: true)
            selected_obj_vibration_mode = switchView.isOn
        }
    }


    @objc private func switchToggled(_ sender: UISwitch) {
        if sender.tag == 0 {
            all_obj_vibration_mode.toggle()
            UserDefaults.standard.set(all_obj_vibration_mode, forKey: "all_obj_vibration_mode")
        } else if sender.tag == 1 {
            selected_obj_vibration_mode.toggle()
            UserDefaults.standard.set(selected_obj_vibration_mode, forKey: "selected_obj_vibration_mode")
        }
    }
    
    
    // Action method to handle the "Vibration1" switch being toggled
    @objc private func vibration1SwitchChanged(_ sender: UISwitch) {
        print("All objects vibration switch changed: \(sender.isOn)")
    }
    
    
    // Action method to handle the "Vibration2" switch being toggled
    @objc private func vibration2SwitchChanged(_ sender: UISwitch) {
        print("Selected objects vibration switch changed: \(sender.isOn)")
    }
    
    
    @objc func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }

    
    @objc func fontSizeButtonTapped() {
        let newFontSize = fontManager.increaseFontSize()
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: newFontSize)
        
        for subview in view.subviews {
            if let cell = subview as? UITableViewCell, let textLabel = cell.textLabel {
                textLabel.font = UIFont.systemFont(ofSize: newFontSize)
            }
        }
    }

    
    @objc func showInformation() {
        let informationVC = InformationViewController()
        present(informationVC, animated: true, completion: nil)
    }
}
