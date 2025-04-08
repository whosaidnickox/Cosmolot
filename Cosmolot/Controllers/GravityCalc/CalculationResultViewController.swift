
import UIKit

class CalculationResultViewController: UIViewController {
    @IBOutlet weak var gravityForceLabel: UILabel!
    @IBOutlet weak var firstMassLabel: UILabel!
    @IBOutlet weak var secondMassLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    var firstMass: Double?
    var secondMass: Double?
    var distance: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let firstMass = firstMass, 
            let secondMass = secondMass,
            let distance = distance {
            gravityForceLabel.text = "\(formatToScientificString(calculateGravitationalForce(mass1: firstMass, mass2: secondMass, distance: distance)))"
            firstMassLabel.text = "\(formatToScientificString(firstMass))"
            secondMassLabel.text = "\(formatToScientificString(secondMass))"
            distanceLabel.text = "\(formatToScientificString(distance))"

        }
    }
    
    @IBAction func returnToPrevious(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func calculationsGotClicked(_ sender: UIButton) {
        if let calculationsVC = storyboard?.instantiateViewController(withIdentifier: "CalculationsViewController") as? CalculationsViewController {
            calculationsVC.distance = distance
            calculationsVC.firstMass = firstMass
            calculationsVC.secondMass = secondMass
            navigationController?.pushViewController(calculationsVC, animated: true)
        }
    }
    
    func formatToScientificString(_ number: Double) -> String {
        guard number != 0 else { return "0" }

        let exponent = Int(floor(log10(abs(number))))
        let mantissa = number / pow(10, Double(exponent))
        
        // Format mantissa with 1 digit after decimal
        let mantissaString = String(format: "%.1f", mantissa)
        
        // Convert exponent to superscript
        let superscriptMap: [Character: Character] = [
            "0": "⁰", "1": "¹", "2": "²", "3": "³", "4": "⁴",
            "5": "⁵", "6": "⁶", "7": "⁷", "8": "⁸", "9": "⁹", "-": "⁻"
        ]
        
        let exponentString = String(exponent).compactMap { superscriptMap[$0] }.map { String($0) }.joined()
        
        return "\(mantissaString) × 10\(exponentString)"
    }

    func calculateGravitationalForce(mass1: Double, mass2: Double, distance: Double) -> Double {
        let G = 6.67430e-11 // gravitational constant in N·m²/kg²
        guard distance != 0 else { return 0 } // prevent division by zero
        return G * (mass1 * mass2) / pow(distance, 2)
    }
}
