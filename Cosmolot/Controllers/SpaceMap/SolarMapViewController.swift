
import UIKit

class SolarMapViewController: UIViewController {
    @IBOutlet weak var centerImageView: UIImageView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var diameterLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bannerBottomConstraint: NSLayoutConstraint!
    
    var object: Planet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userInterfaceSetup()
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeDown(_:)))
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)
    }
    
    @objc func handleSwipeDown(_ gesture: UISwipeGestureRecognizer) {
        bannerBottomConstraint.constant = -230

        UIView.animate(withDuration: 0.4, animations: {
            self.view.layoutIfNeeded()
        }) { _ in
            self.navigationController?.popViewController(animated: true)
        }
    }

    
    func userInterfaceSetup() {
        guard let object = object else { return }
        nameLabel.text = object.name
        distanceLabel.text = object.distanceFromSun
        diameterLabel.text = object.diameter
        temperatureLabel.text = object.temperature
        centerImageView.image = UIImage(named: formatName(object.name))
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
