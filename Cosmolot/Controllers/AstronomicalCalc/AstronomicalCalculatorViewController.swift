

import UIKit

class AstronomicalCalculatorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func goToCalculationScreen(_ sender: UIButton) {
        if let velocityVC = storyboard?.instantiateViewController(withIdentifier: "VelocityCalculationViewController") as? VelocityCalculationViewController {
            navigationController?.pushViewController(velocityVC, animated: true)
        }
    }
    
    @IBAction func goBackGotTapped(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}
