
import Foundation

struct CosmosWeather {
    let date: Date
    let updateDate: Date
    let protonFlux: Int
    let electronFlux: Int
    let xrayFlux: Int
    let solarWind: Int
    let flareActivity: String // e.g., M2.5
    let todaySolarTemp: Int
    let tomorrowSolarTemp: Int
    let radiation: Int // in mSv
}

struct XrayFlare: Decodable {
    let timeTag: String
    let currentClass: String

    enum CodingKeys: String, CodingKey {
        case timeTag = "time_tag"
        case currentClass = "current_class"
    }
}

struct InstrumentSource: Decodable {
    let electrons: ParticleData
    let protons: ParticleData
    let xrays: ParticleData

    struct ParticleData: Decodable {
        let primary: Int
    }
}


class TemperatureManager {
    static let shared = TemperatureManager()

    func fetchCosmosWeather() async throws -> CosmosWeather {
        // Define API URLs
        let xrayFlaresURL = URL(string: "https://services.swpc.noaa.gov/json/goes/primary/xray-flares-latest.json")!
        let instrumentSourcesURL = URL(string: "https://services.swpc.noaa.gov/json/goes/instrument-sources.json")!
        let solarWindURL = URL(string: "https://services.swpc.noaa.gov/products/solar-wind/plasma-1-day.json")!

        // Fetch data from APIs
        async let (xrayFlaresData, _) = URLSession.shared.data(from: xrayFlaresURL)
        async let (instrumentSourcesData, _) = URLSession.shared.data(from: instrumentSourcesURL)
        async let (solarWindData, _) = URLSession.shared.data(from: solarWindURL)

        // Decode JSON responses
        let xrayFlares = try JSONDecoder().decode([XrayFlare].self, from: try await xrayFlaresData)
        let instrumentSources = try JSONDecoder().decode([InstrumentSource].self, from: try await instrumentSourcesData)
        let rawSolarWind = try JSONSerialization.jsonObject(with: try await solarWindData) as? [[Any]]

        // Extract required data
        guard let latestFlare = xrayFlares.first else {
            throw NSError(domain: "DataError", code: 1, userInfo: [NSLocalizedDescriptionKey: "No flare data available"])
        }

        guard let latestInstrument = instrumentSources.first else {
            throw NSError(domain: "DataError", code: 2, userInfo: [NSLocalizedDescriptionKey: "No instrument data available"])
        }

        let currentDate = Date()
        let updateDate = ISO8601DateFormatter().date(from: latestFlare.timeTag) ?? currentDate
        let flareActivity = latestFlare.currentClass
        let protonFlux = latestInstrument.protons.primary
        let electronFlux = latestInstrument.electrons.primary
        let xrayFlux = latestInstrument.xrays.primary

        var todaySolarTemp: Int = 0
        var tomorrowSolarTemp: Int = 0
        var solarWindSpeed: Int = 0

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        if let rawSolarWind = rawSolarWind {
            for row in rawSolarWind.dropFirst() {
                guard row.count == 4,
                      let dateString = row[0] as? String,
                      let speedStr = row[2] as? String,
                      let tempStr = row[3] as? String,
                      let date = formatter.date(from: dateString) else {
                    continue
                }
                
                let calendar = Calendar.current
                if calendar.isDateInToday(date) && todaySolarTemp == 0 {
                    todaySolarTemp = Int(Double(tempStr) ?? 0)
                    solarWindSpeed = Int(Double(speedStr) ?? 0)
                } else if calendar.isDateInTomorrow(date) && tomorrowSolarTemp == 0 {
                    tomorrowSolarTemp = Int(Double(tempStr) ?? 0)
                    break
                }
            }
        }
        // Construct and return the CosmosWeather object
        return CosmosWeather(
            date: currentDate,
            updateDate: updateDate,
            protonFlux: protonFlux,
            electronFlux: electronFlux,
            xrayFlux: xrayFlux,
            solarWind: solarWindSpeed,
            flareActivity: flareActivity,
            todaySolarTemp: todaySolarTemp,
            tomorrowSolarTemp: tomorrowSolarTemp,
            radiation: (protonFlux * 10)
        )
    }
}
