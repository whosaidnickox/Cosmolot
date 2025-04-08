
import UIKit

struct PlanetTimeInfo {
    let name: String
    let timeZone: String
    let dayLength: String
    let yearLength: String
    let timeDifferenceWithEarth: String
}

struct PlanetaryTime {
    let hours: Int
    let minutes: Int
    let seconds: Int
    let label: String  // e.g. "AM", "PM", etc.
}

class SpaceTimeDetailsViewController: UIViewController {
    @IBOutlet weak var firstPlanetNameLabel: UILabel!
    @IBOutlet weak var secondPlanetNameLabel: UILabel!
    @IBOutlet weak var firstTimeLabel: UILabel!
    @IBOutlet weak var firstTimeSuffixLabel: UILabel!
    @IBOutlet weak var secondTimeLabel: UILabel!
    @IBOutlet weak var secondTimeSuffixLabel: UILabel!
    @IBOutlet weak var firstPlanetTimeLabel: UILabel!
    @IBOutlet weak var secondPlanetTimeLabel: UILabel!
    @IBOutlet weak var firstSuffixLbl: UILabel!
    @IBOutlet weak var secondSuffixLbl: UILabel!
    @IBOutlet weak var dayLengthLabel: UILabel!
    @IBOutlet weak var yearLengthLabel: UILabel!
    @IBOutlet weak var timeDifferenceLabel: UILabel!
    
    var index: Int?
    
    let infos: [PlanetTimeInfo] = [
        PlanetTimeInfo(
            name: "Moon",
            timeZone: "GMT+0 (UTC)",
            dayLength: "29.53 Earth days",
            yearLength: "365.25 days (same as Earth)",
            timeDifferenceWithEarth: "28.53 Earth days"
        ),
        PlanetTimeInfo(
            name: "Mars",
            timeZone: "MTC (Mars Time)",
            dayLength: "24h 39m 35s (1 sol)",
            yearLength: "687 Earth days",
            timeDifferenceWithEarth: "39m 35s"
        ),
        PlanetTimeInfo(
            name: "Jupiter",
            timeZone: "Jupiter System Time",
            dayLength: "9h 55m",
            yearLength: "4333 Earth days (~11.86 years)",
            timeDifferenceWithEarth: "14h 5m"
        )
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let index = index {
            setupUI(index: index)
        }
    }
    
    @IBAction func returnToBackTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func firstPlanetTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func secondPlanetTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Select the planet", message: "", preferredStyle: .alert)
        let firstAction = UIAlertAction(title: "Moon", style: .default) { action in
            self.index = 0
            self.setupUI(index: self.index!)
        }
        let secondAction = UIAlertAction(title: "Mars", style: .default) { action in
            self.index = 1
            self.setupUI(index: self.index!)
        }
        let thirdAction = UIAlertAction(title: "Jupiter", style: .default) { action in
            self.index = 2
            self.setupUI(index: self.index!)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(firstAction)
        alert.addAction(secondAction)
        alert.addAction(thirdAction)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    func getPlanetaryTimes(from earthDate: Date = Date()) -> [String: PlanetaryTime] {
        let earthSecondsInDay: Double = 86400
        let calendar = Calendar(identifier: .gregorian)

        // Get current Earth seconds since midnight UTC
        let components = calendar.dateComponents([.hour, .minute, .second], from: earthDate)
        let hours = components.hour ?? 0
        let minutes = components.minute ?? 0
        let seconds = components.second ?? 0

        let totalSeconds = (hours * 3600) + (minutes * 60) + seconds
        let earthSeconds = Double(totalSeconds)
        // Planet day lengths in Earth seconds
        let planetaryDayLengths: [String: Double] = [
            "Moon": 2551443,     // 29.5 Earth days
            "Mars": 88775.244,   // 24h 37m 22.4s
            "Jupiter": 35730     // 9h 55m 30s
        ]

        var results: [String: PlanetaryTime] = [:]

        for (planet, planetDaySeconds) in planetaryDayLengths {
            // Scale current Earth time proportionally to the planetary day
            let planetarySeconds = (earthSeconds / earthSecondsInDay) * planetDaySeconds

            let hours = Int(planetarySeconds) / 3600
            let minutes = (Int(planetarySeconds) % 3600) / 60
            let seconds = Int(planetarySeconds) % 60

            let label: String
            if hours < 12 {
                label = "AM"
            } else if hours < 24 {
                label = "PM"
            } else {
                label = "MTC" // Mars or non-24-hour planet labels if needed
            }

            results[planet] = PlanetaryTime(
                hours: hours % Int(planetDaySeconds / 3600),
                minutes: minutes,
                seconds: seconds,
                label: label
            )
        }

        return results
    }

    func formatToHourMinute(from date: Date) -> (String, String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        formatter.timeZone = .current // or .gmt, .utc etc. based on use case

        let formattedString = formatter.string(from: date)
        let components = formattedString.split(separator: " ")

        if components.count == 2 {
            return (String(components[0]), String(components[1]))
        } else {
            return ("", "")
        }
    }
    
    func setupUI(index: Int) {
        secondPlanetNameLabel.text = infos[index].name
        secondPlanetTimeLabel.text = "\(infos[index].name) Time"
        secondSuffixLbl.text = infos[index].timeZone
        dayLengthLabel.text = infos[index].dayLength
        yearLengthLabel.text = infos[index].yearLength
        timeDifferenceLabel.text = infos[index].timeDifferenceWithEarth
        firstTimeLabel.text = formatToHourMinute(from: Date()).0
        firstTimeSuffixLabel.text = formatToHourMinute(from: Date()).1
        let planetaryTimes = getPlanetaryTimes()
        for (planet, time) in planetaryTimes {
            secondTimeLabel.text = "\(time.hours):\(String(format: "%02d", time.minutes))"
            secondTimeSuffixLabel.text = time.label
        }
    }
}
