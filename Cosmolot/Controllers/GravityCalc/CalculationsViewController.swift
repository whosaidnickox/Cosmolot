
import UIKit

class CalculationsViewController: UIViewController {
    @IBOutlet weak var firstMassLabel: UILabel!
    @IBOutlet weak var secondMassLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var distanceProgressView: UIProgressView!
    @IBOutlet weak var gravitationalForceInitialNumberLabel: UILabel!
    @IBOutlet weak var gravitationalForceSuffixLabel: UILabel!
    @IBOutlet weak var potentialEnergyInitialNumberLabel: UILabel!
    @IBOutlet weak var potentialEnergySuffixLabel: UILabel!
    
    var firstMass: Double?
    var secondMass: Double?
    var distance: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupValues()
    }
    
    @IBAction func minusFirstMass(_ sender: UIButton) {
        let numbers = log10(abs(firstMass!))
        if firstMass! > 0 {
            firstMass! -= pow(10, numbers - 1)
            setupValues()
        }
    }
    
    @IBAction func plusFirstMass(_ sender: Any) {
        var numbers = log10(abs(firstMass!))
        numbers = (numbers == 0) ? 1 : numbers
        firstMass! += pow(10, numbers)
        setupValues()
    }
    
    @IBAction func minusSecondMass(_ sender: Any) {
        let numbers = log10(abs(secondMass!))
        if secondMass! > 0 {
            secondMass! -= pow(10, numbers - 1)
            setupValues()
        }
    }
    
    @IBAction func plusSecondMass(_ sender: Any) {
        var numbers = log10(abs(secondMass!))
        numbers = (numbers == 0) ? 1 : numbers
        secondMass! += pow(10, numbers)
        setupValues()
    }
    func formatToScientificString(_ number: Double) -> (String, String) {
        guard number != 0 else { return ("0", "× 10⁰") }

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
        
        return ("\(mantissaString)", " × 10\(exponentString)")
    }

    func calculateGravitationalForce(mass1: Double, mass2: Double, distance: Double) -> Double {
        let G = 6.67430e-11 // gravitational constant in N·m²/kg²
        guard distance != 0 else { return 0 } // prevent division by zero
        return G * (mass1 * mass2) / pow(distance, 2)
    }
    
    func formatToScientific(_ number: Double, fractionDigits: Int = 2) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .scientific
        formatter.positiveFormat = "0.\(String(repeating: "#", count: fractionDigits))E0"
        formatter.exponentSymbol = "e"
        formatter.maximumFractionDigits = fractionDigits
        return formatter.string(from: NSNumber(value: number)) ?? "\(number)"
    }
    
    func gravitationalPotentialEnergy(mass1: Double, mass2: Double, distance: Double) -> Double {
        let G = 6.67430e-11 // gravitational constant in m^3 kg^-1 s^-2
        return -G * mass1 * mass2 / distance
    }
    
    func setupValues() {
        if let firstMass = firstMass,
           let secondMass = secondMass,
           let distance = distance {
            firstMassLabel.text = formatToScientific(firstMass)
            secondMassLabel.text = formatToScientific(secondMass)
            distanceLabel.text = formatToScientific(distance)
            distanceProgressView.setProgress(Float(distance) / 10000000000, animated: true)
            gravitationalForceInitialNumberLabel.text = "\(formatToScientificString(calculateGravitationalForce(mass1: firstMass, mass2: secondMass, distance: distance)).0)"
            gravitationalForceSuffixLabel.text = "\(formatToScientificString(calculateGravitationalForce(mass1: firstMass, mass2: secondMass, distance: distance)).1) N"
            potentialEnergyInitialNumberLabel.text = "\(formatToScientificString(gravitationalPotentialEnergy(mass1: firstMass, mass2: secondMass, distance: distance)).0)"
            potentialEnergySuffixLabel.text = "\(formatToScientificString(gravitationalPotentialEnergy(mass1: firstMass, mass2: secondMass, distance: distance)).1) J"
        }
    }
    
    @IBAction func dismissToPrevious(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
