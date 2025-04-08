
import UIKit

class DetailsScreenViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var objectImageView: UIImageView!
    @IBOutlet weak var diameterLabel: UILabel!
    @IBOutlet weak var temperaturaLabel: UILabel!
    @IBOutlet weak var massLabel: UILabel!
    @IBOutlet weak var orbitalPeriodLabel: UILabel!
    @IBOutlet weak var surfaceGravityLabel: UILabel!
    @IBOutlet weak var moonsLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var firstInfoLabel: UILabel!
    @IBOutlet weak var secondInfoLabel: UILabel!
    @IBOutlet weak var thirdInfoLabel: UILabel!
    
    var object: Planet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetupOfObject()
    }
    
    @IBAction func backTaapped(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func learnMoreGotTapped(_ sender: UIButton) {
        if let solarMapVC = storyboard?.instantiateViewController(withIdentifier: "SolarMapViewController") as? SolarMapViewController {
            solarMapVC.object = object
            navigationController?.pushViewController(solarMapVC, animated: true)
        }
    }
}
extension DetailsScreenViewController {
    func initialSetupOfObject() {
        guard let object = object else { return }
        titleLabel.text = object.name
        diameterLabel.text = object.diameter
        temperaturaLabel.text = object.temperature
        massLabel.text = object.mass
        orbitalPeriodLabel.text = object.orbitalPeriod
        surfaceGravityLabel.text = object.surfaceGravity
        moonsLabel.text = object.moons
        firstInfoLabel.text = object.facts.first
        secondInfoLabel.text = object.facts[1]
        thirdInfoLabel.text = object.facts.last
        objectImageView.image = UIImage(named: formatName(object.name))
    }
    
    func formatName(_ input: String) -> String {
        let words = input.components(separatedBy: " ").filter { !$0.isEmpty }
        
        if words.count == 1 {
            return words[0].lowercased()
        } else if words.count == 2 {
            let first = words[0].lowercased()
            let second = words[1].capitalized
            return first + second
        } else {
            return input
        }
    }
}
