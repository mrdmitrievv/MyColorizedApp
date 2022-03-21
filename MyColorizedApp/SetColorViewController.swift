import UIKit

protocol ColorViewControllerDelegate {
    func saveColor(_ color: UIColor)
}

class SetColorViewController: UIViewController {
    
    // MARK: IB Outlets
    @IBOutlet var colorizedView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    // MARK: Public properties
    var delegate: ColorViewControllerDelegate!
    var colorizedViewColor: UIColor!
    
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorizedView.layer.cornerRadius = 15
        
        redSlider.tintColor = .red
        greenSlider.tintColor = .green
        
        colorizedView.backgroundColor = colorizedViewColor
        
        setSliders()
        
        setValue(for: redLabel, greenLabel, blueLabel)
        setValue(for: redTextField, greenTextField, blueTextField)
        addDoneButton(to: redTextField, greenTextField, blueTextField)
    }
    
    // MARK: Add actions for sliders
    @IBAction func rgbAction(_ sender: UISlider) {
        switch sender.tag {
            case 0:
                setValue(for: redLabel)
                setValue(for: redTextField)
            case 1:
                setValue(for: greenLabel)
                setValue(for: greenTextField)
            case 2:
                setValue(for: blueLabel)
                setValue(for: blueTextField)
            default:
                break
        }
        
        setColor()
    }
    
    // MARK: doneButton action
    @IBAction func doneButtonPressed() {
        delegate?.saveColor(colorizedView.backgroundColor ?? .white)
        dismiss(animated: true)
    }    
}

extension SetColorViewController {
    
    // MARK: Set color of colorizedView
    private func setColor() {
        colorizedView.backgroundColor = UIColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: 1)
    }
    
    // MARK: Set values for labels
    private func setValue(for labels: UILabel...) {
        labels.forEach{ label in
            switch label.tag {
            case 0: redLabel.text = string(from: redSlider)
            case 1: greenLabel.text = string(from: greenSlider)
            case 2: blueLabel.text = string(from: blueSlider)
            default: break
            }
        }
    }
    
    // MARK: Set values for text fields
    private func setValue(for textFields: UITextField...) {
        textFields.forEach{ textField in
            switch textField.tag {
            case 0: redTextField.text = string(from: redSlider)
            case 1: greenTextField.text = string(from: greenSlider)
            case 2: blueTextField.text = string(from: blueSlider)
            default: break
            }
        }
    }
    
    // MARK: Get string value from sliders value
    private func string(from slider: UISlider) -> String {
        return String(format: "%.2f", slider.value)
    }
    
    // MARK: func for saving parameters of mainView color for sliders
    private func setSliders() {
        let ciColor = CIColor(color: colorizedViewColor)
        redSlider.value = Float(ciColor.red)
        greenSlider.value = Float(ciColor.green)
        blueSlider.value = Float(ciColor.blue)
    }
    
    // MARK: Add done button to the keyboard
    private func addDoneButton(to textFields: UITextField...) {
        textFields.forEach{ textField in
            let keyboardToolBar = UIToolbar()
            textField.inputAccessoryView = keyboardToolBar
            keyboardToolBar.sizeToFit()
            
            let doneButton = UIBarButtonItem(
                title: "Done",
                style: .done,
                target: self,
                action: #selector(didTapOne))
            
            let flexibleButton = UIBarButtonItem(
                barButtonSystemItem: .flexibleSpace,
                target: nil,
                action: nil)
            
            keyboardToolBar.items = [flexibleButton, doneButton]
        }
    }
    
    @objc func didTapOne() {
        view.endEditing(true)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension SetColorViewController: UITextFieldDelegate {
    
    // MARK: Hide keyboard after touch the screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: will work only with delegete segue with SetColorVC
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }

        if let currentValue = Float(text), currentValue <= 1 {
            switch textField.tag {
            case 0:
                redSlider.setValue(currentValue, animated: true)
                setValue(for: redLabel)
            case 1:
                greenSlider.setValue(currentValue, animated: true)
                setValue(for: greenLabel)
            case 2:
                blueSlider.setValue(currentValue, animated: true)
                setValue(for: blueLabel)
            default: break
            }

            setColor()
            return
        }

        showAlert(title: "Wrong format!", message: "Please enter correct value")
    }
}

