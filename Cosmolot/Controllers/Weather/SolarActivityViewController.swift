
import UIKit

class SolarActivityViewController: UIViewController {
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var flareActivityLabel: UILabel!
    @IBOutlet var periodSelectionOutlets: [UIButton]!
    @IBOutlet weak var activityPeriodLabel: UILabel!
    @IBOutlet weak var firstDateLabel: UILabel!
    @IBOutlet weak var secondDateLabel: UILabel!
    @IBOutlet weak var thirdDateLabel: UILabel!
    
    var cosmosWeather: CosmosWeather?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let cosmosWeather = cosmosWeather {
            windLabel.text = "\(cosmosWeather.solarWind) km/s"
            flareActivityLabel.text = "\(cosmosWeather.flareActivity)"
            firstDateLabel.text = "\(formatShortDate(Calendar.current.date(byAdding: .day, value: -1, to: Date())!))"
            secondDateLabel.text = "\(formatShortDate(Calendar.current.date(byAdding: .day, value: -2, to: Date())!))"
            thirdDateLabel.text = "\(formatShortDate(Calendar.current.date(byAdding: .day, value: -3, to: Date())!))"
        } else {
            showFailureAlert()
        }
    }
    
    @IBAction func goBackGotClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func periodSelected(_ sender: UIButton) {
        for date in periodSelectionOutlets {
            if sender.tag == date.tag {
                date.backgroundColor = AppColors.selectedCategoryColor.color
                activityPeriodLabel.text = "\(["24h", "7d", "30d"][sender.tag]) Activity"
            } else {
                date.backgroundColor = AppColors.unselectedDateCategory.color
            }
        }
    }
    @IBAction func currentStatusSelected(_ sender: UIButton) {
        if let liveStatusVC = storyboard?.instantiateViewController(withIdentifier: "LiveStatusViewController") as? LiveStatusViewController {
            liveStatusVC.cosmosWeather = cosmosWeather
            navigationController?.pushViewController(liveStatusVC, animated: true)
        }
    }
    
    @IBAction func goHomeGotTriggered(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func formatShortDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d"
        return formatter.string(from: date)
    }
    
    func showFailureAlert() {
        let alert = UIAlertController(title: "Error", message: "There is a problem occurred while fetching information", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { [self]_ in
            navigationController?.popToRootViewController(animated: true)
        }
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
}
