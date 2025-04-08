

import UIKit

class VelocityCalculationViewController: UIViewController {
    @IBOutlet weak var mass1TextField: UITextField!
    @IBOutlet weak var radius1TextField: UITextField!
    @IBOutlet weak var mass2TextField: UITextField!
    @IBOutlet weak var radius2TextField: UITextField!
    @IBOutlet weak var distanceTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mass1TextField.attributedPlaceholder = NSAttributedString(
            string: "Enter mass",
            attributes: [NSAttributedString.Key.foregroundColor: AppColors.placeholderColor.color]
        )
        mass2TextField.attributedPlaceholder = NSAttributedString(
            string: "Enter mass",
            attributes: [NSAttributedString.Key.foregroundColor: AppColors.placeholderColor.color]
        )
        radius1TextField.attributedPlaceholder = NSAttributedString(
            string: "Enter radius",
            attributes: [NSAttributedString.Key.foregroundColor: AppColors.placeholderColor.color]
        )
        radius2TextField.attributedPlaceholder = NSAttributedString(
            string: "Enter radius",
            attributes: [NSAttributedString.Key.foregroundColor: AppColors.placeholderColor.color]
        )
        distanceTextField.attributedPlaceholder = NSAttributedString(
            string: "Enter distance",
            attributes: [NSAttributedString.Key.foregroundColor: AppColors.placeholderColor.color]
        )
    }
    
    @IBAction func calculateForceGotTapped(_ sender: UIButton) {
        if mass1TextField.text != "", 
            mass2TextField.text != "",
            radius1TextField.text != "",
            radius2TextField.text != "",
           distanceTextField.text != "" {
            let mass1 = Double(mass1TextField.text!)
            let mass2 = Double(mass2TextField.text!)
            let radius1 = Double(radius1TextField.text!)
            let radius2 = Double(radius2TextField.text!)
            let distance = Double(distanceTextField.text!)
            if mass1 != 0, mass2 != 0, radius1 != 0, radius2 != 0, distance != 0 {
                let force = calculateGravitationalForceUsingRadii(mass1: mass1 ?? 1, mass2: mass2 ?? 1, radius1: radius1 ?? 1, radius2: radius2 ?? 1, surfaceDistance: distance ?? 1)
                if let resultVC = storyboard?.instantiateViewController(withIdentifier: "VelocityResultViewController") as? VelocityResultViewController {
                    resultVC.force = force
                    navigationController?.pushViewController(resultVC, animated: true)
                }
            }
        }
    }
    
    @IBAction func goBackGotClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func calculateGravitationalForceUsingRadii(mass1: Double, mass2: Double, radius1: Double, radius2: Double, surfaceDistance: Double) -> Double {
        let G = 6.67430e-11
        let centerDistance = surfaceDistance + radius1 + radius2
        return (G * mass1 * mass2) / pow(centerDistance, 2)
    }

}
