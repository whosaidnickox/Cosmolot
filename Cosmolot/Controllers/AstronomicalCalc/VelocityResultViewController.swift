
import UIKit

class VelocityResultViewController: UIViewController {
    @IBOutlet weak var forceLabel: UILabel!
    
    var force: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let force = force {
            forceLabel.text = "\(formatToScientificString(force))"
        }
    }
    
    @IBAction func goBackGotTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
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
}
