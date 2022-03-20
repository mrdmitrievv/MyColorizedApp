import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorizedView.layer.cornerRadius = 15
        
        redSlider.tintColor = .red
        greenSlider.tintColor = .green
        
        setValue(for: redLabel, greenLabel, blueLabel)
        setValue(for: redTextField, greenTextField, blueTextField)
        
    }
    
    
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
}
