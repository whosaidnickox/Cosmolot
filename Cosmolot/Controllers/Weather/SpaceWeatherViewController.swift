
import UIKit

class SpaceWeatherViewController: UIViewController {
    @IBOutlet weak var todayDateLabel: UILabel!
    @IBOutlet weak var radiationTodayDateLabel: UILabel!
    @IBOutlet weak var radiationStatusLabel: UILabel!
    @IBOutlet weak var protonProgressView: UIProgressView!
    @IBOutlet weak var electronProgressView: UIProgressView!
    @IBOutlet weak var xrayProgressView: UIProgressView!
    @IBOutlet weak var twoDaysBeforeDateLabel: UILabel!
    @IBOutlet weak var threeDaysBeforeDateLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var cosmosWeather: CosmosWeather?
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.isHidden = true
        activityIndicator.startAnimating()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task {
            do {
                cosmosWeather = try await TemperatureManager.shared.fetchCosmosWeather()
                print("Cosmos Weather Data: \(cosmosWeather)")
                if let cosmosWeather = cosmosWeather {
                    scrollView.isHidden = false
                    activityIndicator.stopAnimating()
                    setupData(object: cosmosWeather)
                } else {
                    showFailureAlert()
                }
            } catch {
                print("Failed to fetch cosmos weather data: \(error)")
                showFailureAlert()
            }
        }
    }
    
    @IBAction func returnToRootGotClicked(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func goToLiveStatusScreen(_ sender: UIButton) {
        if let solarActivityVC = storyboard?.instantiateViewController(withIdentifier: "SolarActivityViewController") as? SolarActivityViewController {
            solarActivityVC.cosmosWeather = cosmosWeather
            navigationController?.pushViewController(solarActivityVC, animated: true)
        }
    }
    
    func showFailureAlert() {
        let alert = UIAlertController(title: "Error", message: "There is a problem occurred while fetching information", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { [self]_ in
            navigationController?.popToRootViewController(animated: true)
        }
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
    
    func setupData(object: CosmosWeather) {
        todayDateLabel.text = formatFullDate(Date())
        radiationTodayDateLabel.text = formatFullDate(Date())
        protonProgressView.setProgress(Float(object.protonFlux) / Float(25), animated: true)
        electronProgressView.setProgress(Float(object.electronFlux) / Float(25), animated: true)
        xrayProgressView.setProgress(Float(object.xrayFlux) / Float(25), animated: true)
        twoDaysBeforeDateLabel.text = formatShortDate(Calendar.current.date(byAdding: .day, value: -2, to: Date())!)
        threeDaysBeforeDateLabel.text = formatShortDate(Calendar.current.date(byAdding: .day, value: -3, to: Date())!)
    }
    
    func formatFullDate(_ date: Date) -> String {
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: date) 
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        let dateString = formatter.string(from: date)
        return "\(weekday) \(dateString)"
    }

    func formatShortDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d"
        return formatter.string(from: date)
    }
}
