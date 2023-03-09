import UIKit

class InformationViewController: UIViewController {
    
    let backButton = UIButton()
    let fontSizes = [UIFont.systemFontSize+7, UIFont.systemFontSize + 10, UIFont.systemFontSize + 15]
    var currentFontSizeIndex = 0
    var all_obj_vibration_mode = true
    var selected_obj_vibration_mode = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the background color of the view to light gray
        view.backgroundColor = UIColor.lightGray
    
        backButton.setTitle("Back", for: .normal)
            backButton.setTitleColor(.white, for: .normal)
            backButton.backgroundColor = .black
            backButton.layer.cornerRadius = 10
            backButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
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
        informationRow.textLabel?.font = UIFont.systemFont(ofSize: 17)
        informationRow.selectionStyle = .none
        informationRow.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        informationRow.layer.cornerRadius = 10
        informationRow.clipsToBounds = true
        informationRow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(informationPressed)))
        view.addSubview(informationRow)
        
        informationRow.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            informationRow.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 20),
            informationRow.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            informationRow.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            informationRow.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func addVibration1Row() {
        let vibration1Row = createRow(title: "Vibration1")
        view.addSubview(vibration1Row)
        
        vibration1Row.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            vibration1Row.topAnchor.constraint(equalTo: view.subviews[view.subviews.count - 2].bottomAnchor, constant: 5),
            vibration1Row.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            vibration1Row.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            vibration1Row.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func addVibration2Row() {
        let vibration2Row = createRow(title: "Vibration2")
        view.addSubview(vibration2Row)
        
        vibration2Row.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            vibration2Row.topAnchor.constraint(equalTo: view.subviews[view.subviews.count - 2].bottomAnchor, constant: 5),
            vibration2Row.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            vibration2Row.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            vibration2Row.heightAnchor.constraint(equalToConstant: 44)
        ])
    }


    
    // Helper method to create a row with a given title
    private func createRow(title: String) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.backgroundColor = UIColor.white
        cell.textLabel?.text = title
        cell.textLabel?.font = UIFont.systemFont(ofSize: 17)
        cell.selectionStyle = .none
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        
        
        let switchView = UISwitch()
        if title == "Vibration1" {
            switchView.tag = 0
        } else if title == "Vibration2" {
            switchView.tag = 1
        }
        
        switchView.addTarget(self, action: #selector(switchToggled(_:)), for: .valueChanged)
        cell.contentView.addSubview(switchView)
        switchView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            switchView.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
            switchView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -15)
        ])
        
        return cell
    }

    @objc private func switchToggled(_ sender: UISwitch) {
        if sender.tag == 0 {
            all_obj_vibration_mode.toggle()
            print("Vibration1 switch toggled: \(all_obj_vibration_mode)")
        } else if sender.tag == 1 {
            selected_obj_vibration_mode.toggle()
            print("Vibration2 switch toggled: \(selected_obj_vibration_mode)")
        }
    }

    
    // Action method to handle the "Information" row being pressed
    @objc private func informationPressed() {
        print("Information pressed")
    }
    
    // Action method to handle the "Vibration1" switch being toggled
    @objc private func vibration1SwitchChanged(_ sender: UISwitch) {
        print("Vibration1 switch changed: \(sender.isOn)")
    }
    
    // Action method to handle the "Vibration2" switch being toggled
    @objc private func vibration2SwitchChanged(_ sender: UISwitch) {
        print("Vibration2 switch changed: \(sender.isOn)")
    }
    
    @objc func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }

    @objc func fontSizeButtonTapped() {
        currentFontSizeIndex = (currentFontSizeIndex + 1) % fontSizes.count

        // Update font size for the back and confirm buttons
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: fontSizes[currentFontSizeIndex])

        // Save font size index in user defaults
        UserDefaults.standard.set(currentFontSizeIndex, forKey: "currentFontSizeIndex")
    }
}
