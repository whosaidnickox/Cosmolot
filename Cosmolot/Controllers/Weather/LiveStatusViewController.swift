
import UIKit

class LiveStatusViewController: UIViewController {
    @IBOutlet weak var lastUpdatedLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windSpeedCompareLabel: UILabel!
    @IBOutlet weak var radiationAmountLabel: UILabel!
    @IBOutlet weak var radiationStatusLabel: UILabel!
    
    var cosmosWeather: CosmosWeather?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let cosmosWeather = cosmosWeather {
            lastUpdatedLabel.text = "Last updated: \(timeDifferenceDescription(from: cosmosWeather.updateDate)) ago"
            windSpeedLabel.text = "\(cosmosWeather.todaySolarTemp)°C"
            radiationAmountLabel.text = "\(cosmosWeather.radiation) mSv"
            switch cosmosWeather.radiation {
            case 0...100:
                radiationStatusLabel.text = "Low level"
            case 100...1000:
                radiationStatusLabel.text = "Moderate level"
            case 1000...50000:
                radiationStatusLabel.text = "Average level"
            default:
                radiationStatusLabel.text = "Critical level"
            }
        } else {
            showFailureAlert()
        }
    }
    @IBAction func popToPreviousView(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func popToRootGotClicked(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func showFailureAlert() {
        let alert = UIAlertController(title: "Error", message: "There is a problem occurred while fetching information", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { [self]_ in
            navigationController?.popToRootViewController(animated: true)
        }
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
    func timeDifferenceDescription(from date: Date) -> String {
        let now = Date()
        let difference = Calendar.current.dateComponents([.hour, .minute], from: date, to: now)

        let hour = difference.hour ?? 0
        let minute = difference.minute ?? 0

        if hour >= 1 {
            let hourString = hour == 1 ? "1 hour" : "\(hour) hours"
            let minuteString = minute == 1 ? "1 minute" : "\(minute) minutes"
            return "\(hourString) \(minuteString)"
        } else {
            let minuteString = minute == 1 ? "1 minute" : "\(minute) minutes"
            return minuteString
        }
    }
}
