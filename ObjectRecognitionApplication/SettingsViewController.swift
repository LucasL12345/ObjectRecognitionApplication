import UIKit

class SettingsViewController: UIViewController {
    
    var visionObjectVC: VisionObjectRecognitionViewController!
    
    lazy var fontManager = FontManager.shared

    lazy var currentFontSize: CGFloat = {
        return fontManager.getFontSize()
    }()
    
    let lightBackgroundColor = UIColor.white
    let darkBackgroundColor = UIColor.black
    let lightTextColor = UIColor.black
    let darkTextColor = UIColor.white

    let backButton = UIButton()
    var all_obj_vibration_mode = UserDefaults.standard.bool(forKey: "all_obj_vibration_mode")
    var selected_obj_vibration_mode = UserDefaults.standard.bool(forKey: "selected_obj_vibration_mode")
    var dark_mode = UserDefaults.standard.bool(forKey: "dark_mode")
    var app_has_launched_before = UserDefaults.standard.bool(forKey: "app_has_launched_before")

    
    // Add this method to initialize the variables
    private func initializeVariables() {
        // If the app has never launched before, set dark_mode to true
        if !app_has_launched_before {
            dark_mode = true
            UserDefaults.standard.set(true, forKey: "all_obj_vibration_mode")
            UserDefaults.standard.set(true, forKey: "selected_obj_vibration_mode")
            UserDefaults.standard.set(true, forKey: "app_has_launched_before")
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeVariables()
        toggleDarkMode(dark_mode)

        all_obj_vibration_mode = UserDefaults.standard.bool(forKey: "all_obj_vibration_mode")
        selected_obj_vibration_mode = UserDefaults.standard.bool(forKey: "selected_obj_vibration_mode")
        dark_mode = UserDefaults.standard.bool(forKey: "dark_mode")
        
        if let allObjectVibrationRow = view.subviews.first(where: { $0 is UITableViewCell && ($0 as! UITableViewCell).textLabel?.text == "All objects vibration" }) as? UITableViewCell,
           let allObjectVibrationSwitch = allObjectVibrationRow.contentView.subviews.first(where: { $0 is UISwitch }) as? UISwitch {
            allObjectVibrationSwitch.isOn = all_obj_vibration_mode
        }

        if let selectedObjectVibrationRow = view.subviews.first(where: { $0 is UITableViewCell && ($0 as! UITableViewCell).textLabel?.text == "Selected objects vibration" }) as? UITableViewCell,
           let selectedObjectVibrationSwitch = selectedObjectVibrationRow.contentView.subviews.first(where: { $0 is UISwitch }) as? UISwitch {
            selectedObjectVibrationSwitch.isOn = selected_obj_vibration_mode
        }

        if let darkModeRow = view.subviews.first(where: { $0 is UITableViewCell && ($0 as! UITableViewCell).textLabel?.text == "Dark mode" }) as? UITableViewCell,
           let darkModeSwitch = darkModeRow.contentView.subviews.first(where: { $0 is UISwitch }) as? UISwitch {
            darkModeSwitch.isOn = dark_mode
        }

    
        backButton.setTitle("Back", for: .normal)
        if dark_mode {
            backButton.backgroundColor = lightBackgroundColor
            backButton.setTitleColor(darkBackgroundColor, for: .normal)
        } else {
            backButton.backgroundColor = darkBackgroundColor
            backButton.setTitleColor(lightBackgroundColor, for: .normal)
        }
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
        fontSizeButton.layer.borderWidth = 1.0
        if dark_mode {
            fontSizeButton.backgroundColor = darkBackgroundColor
            fontSizeButton.setTitleColor(lightBackgroundColor, for: .normal)
            fontSizeButton.layer.borderColor = lightBackgroundColor.cgColor
        } else {
            fontSizeButton.backgroundColor = lightBackgroundColor
            fontSizeButton.setTitleColor(darkBackgroundColor, for: .normal)
            fontSizeButton.layer.borderColor = darkBackgroundColor.cgColor
        }
        fontSizeButton.layer.cornerRadius = 10
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
        addAllObjectVibrationRow()
        addSelectedObjectVibrationRow()
        addDarkMode()
    }
    
    
    private func addInformationRow() {
        let informationRow = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        informationRow.backgroundColor = dark_mode ? darkBackgroundColor : lightBackgroundColor
        informationRow.textLabel?.text = "Information"
        informationRow.textLabel?.textColor = dark_mode ? darkTextColor : lightTextColor
        informationRow.layer.borderWidth = 1.0
        informationRow.layer.borderColor = dark_mode ? lightBackgroundColor.cgColor : UIColor.gray.cgColor
        informationRow.textLabel?.font = UIFont.systemFont(ofSize: currentFontSize)
        informationRow.selectionStyle = .none
        informationRow.separatorInset = UIEdgeInsets(top: 0, left: 7, bottom: 0, right: 15)
        informationRow.layer.cornerRadius = 10
        informationRow.clipsToBounds = true
        informationRow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showInformation)))
        view.addSubview(informationRow)

        informationRow.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            informationRow.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 20),
            informationRow.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            informationRow.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            informationRow.heightAnchor.constraint(equalToConstant: 50) // Change the height here
        ])
        
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


    private func addAllObjectVibrationRow() {
        let allObjectVibrationRow = createRow(title: "All objects vibration")
        allObjectVibrationRow.heightAnchor.constraint(equalToConstant: 50).isActive = true // Change the height here
        view.addSubview(allObjectVibrationRow)
        
        allObjectVibrationRow.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            allObjectVibrationRow.topAnchor.constraint(equalTo: view.subviews[view.subviews.count - 2].bottomAnchor, constant: 5),
            allObjectVibrationRow.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            allObjectVibrationRow.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(allObjectVibrationRowTapped(_:)))
        allObjectVibrationRow.addGestureRecognizer(tapGestureRecognizer)
    }

    private func addSelectedObjectVibrationRow() {
        let selectedObjectVibrationRow = createRow(title: "Selected objects vibration")
        selectedObjectVibrationRow.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view.addSubview(selectedObjectVibrationRow)
        
        selectedObjectVibrationRow.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            selectedObjectVibrationRow.topAnchor.constraint(equalTo: view.subviews[view.subviews.count - 2].bottomAnchor, constant: 5),
            selectedObjectVibrationRow.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            selectedObjectVibrationRow.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectedObjectVibrationRowTapped(_:)))
        selectedObjectVibrationRow.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func addDarkMode() {
        let darkMode = createRow(title: "Dark mode")
        darkMode.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view.addSubview(darkMode)
        
        darkMode.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            darkMode.topAnchor.constraint(equalTo: view.subviews[view.subviews.count - 2].bottomAnchor, constant: 5),
            darkMode.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            darkMode.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        
        if let darkModeRow = view.subviews.first(where: { $0 is UITableViewCell && ($0 as! UITableViewCell).textLabel?.text == "Dark mode" }) as? UITableViewCell,
           let darkModeSwitch = darkModeRow.contentView.subviews.first(where: { $0 is UISwitch }) as? UISwitch {
            darkModeSwitch.isOn = dark_mode
        }

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(darkModeTapped(_:)))
        darkMode.addGestureRecognizer(tapGestureRecognizer)
    }

    
    @objc private func allObjectVibrationRowTapped(_ sender: UITapGestureRecognizer) {
        if let cell = sender.view as? UITableViewCell,
           let switchView = cell.contentView.subviews.first(where: { $0 is UISwitch }) as? UISwitch {
            switchView.setOn(!switchView.isOn, animated: true)
            all_obj_vibration_mode = switchView.isOn
        }
        
    }

    
    @objc private func selectedObjectVibrationRowTapped(_ sender: UITapGestureRecognizer) {
        if let cell = sender.view as? UITableViewCell,
           let switchView = cell.contentView.subviews.first(where: { $0 is UISwitch }) as? UISwitch {
            switchView.setOn(!switchView.isOn, animated: true)
            selected_obj_vibration_mode = switchView.isOn
        }
    }
    
    
    @objc private func darkModeTapped(_ sender: UITapGestureRecognizer) {
        if let cell = sender.view as? UITableViewCell,
           let switchView = cell.contentView.subviews.first(where: { $0 is UISwitch }) as? UISwitch {
            switchView.setOn(!switchView.isOn, animated: true)
            dark_mode = switchView.isOn
            UserDefaults.standard.set(dark_mode, forKey: "dark_mode")
            toggleDarkMode(dark_mode)
        }
    }


    @objc private func switchToggled(_ sender: UISwitch) {
        if sender.tag == 0 {
            all_obj_vibration_mode.toggle()
            UserDefaults.standard.set(all_obj_vibration_mode, forKey: "all_obj_vibration_mode")
        } else if sender.tag == 1 {
            selected_obj_vibration_mode.toggle()
            UserDefaults.standard.set(selected_obj_vibration_mode, forKey: "selected_obj_vibration_mode")
        } else if sender.tag == 2 {
            dark_mode.toggle()
            UserDefaults.standard.set(dark_mode, forKey: "dark_mode")
            toggleDarkMode(dark_mode)
        }
        
        guard let presentingVC = presentingViewController as? VisionObjectRecognitionViewController else {
            fatalError("Unable to get presenting view controller")
        }
        visionObjectVC = presentingVC
        visionObjectVC.updateAllObjectVibrationMode(all_obj_vibration_mode)
    }


    // Helper method to create a row with a given title
    private func createRow(title: String) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.backgroundColor = dark_mode ? darkBackgroundColor : lightBackgroundColor
        cell.textLabel?.text = title
        cell.textLabel?.textColor = dark_mode ? darkTextColor : lightTextColor
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = dark_mode ? lightBackgroundColor.cgColor : UIColor.gray.cgColor
        cell.textLabel?.font = UIFont.systemFont(ofSize: currentFontSize)
        cell.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        cell.selectionStyle = .none
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(switchToggled(_:)))
        cell.addGestureRecognizer(tapGestureRecognizer)

        let switchView = UISwitch()
        switchView.tag = (title == "All objects vibration") ? 0 : (title == "Selected objects vibration") ? 1 : 2
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

        if title == "All objects vibration" {
            switchView.isOn = all_obj_vibration_mode
        } else {
            switchView.isOn = selected_obj_vibration_mode
        }

        return cell
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
    
    
    private func toggleDarkMode(_ isOn: Bool) {
        if isOn {
            view.backgroundColor = darkBackgroundColor
            
            // set other elements for dark mode
        } else {
            view.backgroundColor = lightBackgroundColor
            
            // set other elements for light mode
        }
    }

}
