
import UIKit

class GravitationalCalculatorViewController: UIViewController {
    @IBOutlet weak var firstMassTextField: UITextField!
    @IBOutlet weak var secondMassTextField: UITextField!
    @IBOutlet weak var distanceTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstMassTextField.attributedPlaceholder = NSAttributedString(
            string: "Enter mass",
            attributes: [NSAttributedString.Key.foregroundColor: AppColors.placeholderColor.color]
        )
        secondMassTextField.attributedPlaceholder = NSAttributedString(
            string: "Enter mass",
            attributes: [NSAttributedString.Key.foregroundColor: AppColors.placeholderColor.color]
        )
        distanceTextField.attributedPlaceholder = NSAttributedString(
            string: "Enter distance",
            attributes: [NSAttributedString.Key.foregroundColor: AppColors.placeholderColor.color]
        )
    }
    
    @IBAction func backTapped(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func calculateForceGotTapped(_ sender: UIButton) {
        if let firstText = firstMassTextField.text,
           let secondText = secondMassTextField.text,
           let distance = distanceTextField.text {
            if !firstText.isEmpty && !secondText.isEmpty && !distance.isEmpty {
                if Double(firstText) != 0 && Double(secondText) != 0 && Double(distance) != 0 {
                    if let calculationsVC = storyboard?.instantiateViewController(withIdentifier: "CalculationResultViewController") as? CalculationResultViewController {
                        calculationsVC.firstMass = Double(firstText)
                        calculationsVC.secondMass = Double(secondText)
                        calculationsVC.distance = Double(distance)
                        firstMassTextField.text = ""
                        secondMassTextField.text = ""
                        distanceTextField.text = ""
                        navigationController?.pushViewController(calculationsVC, animated: true)
                    }
                }
            }
        }
    }
}
