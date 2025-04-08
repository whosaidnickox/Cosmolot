
import Foundation

struct Planet {
    let name: String
    let subInfo: String
    let diameter: String
    let temperature: String
    let mass: String
    let orbitalPeriod: String
    let surfaceGravity: String
    let moons: String
    let distanceFromSun: String
    let facts: [String]
    
    static func fetchPlanets() -> [Planet] {
        [
            Planet(name: "Mercury",
                   subInfo: "Smallest and fastest planet",
                   diameter: "4880 km",
                   temperature: "-173°C to 427°C",
                   mass: "3.30E23 kg",
                   orbitalPeriod: "88 Earth days",
                   surfaceGravity: "3.7 m/s²",
                   moons: "None",
                   distanceFromSun: "57.9M km",
                   facts: ["A day on Mercury is longer than a year.", "It has no atmosphere to retain heat.", "It has the largest temperature variation in the solar system."]
                  ),
            Planet(name: "Venus",
                   subInfo: "Hottest planet, thick atmosphere",
                   diameter: "12104 km",
                   temperature: "464°C",
                   mass: "4.87E24 kg",
                   orbitalPeriod: "225 Earth days",
                   surfaceGravity: "8.87 m/s²",
                   moons: "None",
                   distanceFromSun: "108.2M km",
                   facts: ["Venus rotates in the opposite direction of most planets.", "Its atmosphere traps heat, making it hotter than Mercury.", "It has the longest rotation period of any planet."]
                  ),
            Planet(name: "Earth",
                   subInfo: "Only known life-supporting planet",
                   diameter: "12742 km",
                   temperature: "15°C",
                   mass: "5.97E24 kg",
                   orbitalPeriod: "365.25 days",
                   surfaceGravity: "9.81 m/s²",
                   moons: "1 (Moon)",
                   distanceFromSun: "149.6M km",
                   facts: ["71% of Earth’s surface is covered in water.", "The only planet with plate tectonics.", "The atmosphere protects against harmful space radiation."]
                  ),
            Planet(name: "Mars",
                   subInfo: "The Red Planet",
                   diameter: "6779 km",
                   temperature: "-63°C",
                   mass: "6.39E23 kg",
                   orbitalPeriod: "687 Earth days",
                   surfaceGravity: "3.721 m/s²",
                   moons: "2 (Phobos, Deimos)",
                   distanceFromSun: "227.9M km",
                   facts: ["Home to the tallest volcano in the solar system, Olympus Mons.", "Has signs of ancient riverbeds and water.", "Its thin atmosphere makes liquid water unstable on the surface."]
                  ),
            Planet(name: "Jupiter",
                   subInfo: "Largest planet, gas giant",
                   diameter: "139820 km",
                   temperature: "-110°C",
                   mass: "1.90E27 kg",
                   orbitalPeriod: "11.86 Earth years",
                   surfaceGravity: "24.79 m/s²",
                   moons: "79 (Ganymede, Europa)",
                   distanceFromSun: "778.5M km",
                   facts: ["Has the biggest storm in the solar system, the Great Red Spot.", "Its moon, Ganymede, is the largest in the solar system.", "Has a faint ring system made of dust."]
                  ),
            Planet(name: "Saturn",
                   subInfo: "Famous for its rings",
                   diameter: "116460 km",
                   temperature: "-140°C",
                   mass: "5.68E26 kg",
                   orbitalPeriod: "29.46 Earth years",
                   surfaceGravity: "10.44 m/s²",
                   moons: "83 (Titan, Enceladus)",
                   distanceFromSun: "1.43B km",
                   facts: ["Its rings are made mostly of ice and rock.", "Titan, its largest moon, has lakes of liquid methane.", "It’s the least dense planet—could float on water."]
                  ),
            Planet(name: "Uranus",
                   subInfo: "Sideways-tilted, ice giant",
                   diameter: "50724 km",
                   temperature: "-195°C",
                   mass: "8.68E25 kg",
                   orbitalPeriod: "84 Earth years",
                   surfaceGravity: "8.69 m/s²",
                   moons: "27 (Titania, Oberon)",
                   distanceFromSun: "2.87B km",
                   facts: ["Rotates on its side, unlike any other planet.", "Has faint, dark rings.", "The coldest planet in the solar system."]
                  ),
            Planet(name: "Neptune",
                   subInfo: "Windiest planet, blue giant",
                   diameter: "49244 km",
                   temperature: "-200°C",
                   mass: "1.02E26 kg",
                   orbitalPeriod: "165 Earth years",
                   surfaceGravity: "11.15 m/s²",
                   moons: "14 (Triton, Proteus)",
                   distanceFromSun: "4.5B km",
                   facts: ["Has the strongest winds in the solar system (2,100 km/h).", "Triton, its largest moon, orbits in the opposite direction.", "It was the first planet discovered using mathematical calculations."]
                  )
        ]
    }
    
    static func fetchStars() -> [Planet] {
        [
            Planet(name: "Sun",
                   subInfo: "The center of our solar system",
                   diameter: "1391000 km",
                   temperature: "-5,500°C",
                   mass: "1.989E30 kg",
                   orbitalPeriod: "it doesn't orbit another star",
                   surfaceGravity: "274 m/s²",
                   moons: "None",
                   distanceFromSun: "149.6M km",
                   facts: ["The Sun makes up 99.8% of the solar system's mass.", "It takes about 8 minutes for its light to reach Earth.", "It will eventually become a red giant and engulf Mercury and Venus."]
                  ),
            Planet(name: "Sirius",
                   subInfo: "The brightest star in the night sky",
                   diameter: "2375000 km",
                   temperature: "9,940°C",
                   mass: "2.02E30 kg",
                   orbitalPeriod: "50.1 Earth years (binary system)",
                   surfaceGravity: "24.79 m/s²",
                   moons: "None",
                   distanceFromSun: "8.6 light-years",
                   facts: ["It is actually a binary system with a white dwarf companion (Sirius B).", "Ancient Egyptians used Sirius to predict the annual flooding of the Nile.", "It is 25 times more luminous than the Sun."]
                  ),
            Planet(name: "Vega",
                   subInfo: "A bright blue-white star",
                   diameter: "2362000 km",
                   temperature: "9,602°C",
                   mass: "2.135E30 kg",
                   orbitalPeriod: "single star",
                   surfaceGravity: "20.87 m/s²",
                   moons: "None",
                   distanceFromSun: "25 light-years",
                   facts: ["Vega was the North Star around 12,000 BC and will be again in 13,000 years.", "It is spinning so fast that it bulges at the equator.", "It was the first star to be photographed and have its spectrum recorded."]
                  ),
            Planet(name: "Polaris",
                   subInfo: "The North Star, a guiding light",
                   diameter: "44600000 km",
                   temperature: "6,015°C",
                   mass: "5.4E30 kg",
                   orbitalPeriod: "30 years (binary system)",
                   surfaceGravity: "1.14 m/s²",
                   moons: "None",
                   distanceFromSun: "433 light-years",
                   facts: ["It is actually a triple star system, with two companion stars.", "It has been used for navigation for centuries.", "It is slowly getting brighter over time."]
                  )
        ]
    }
    
    static func fetchGalaxies() -> [Planet] {
        [
            Planet(name: "Milky Way",
                   subInfo: "Our home galaxy, a barred spiral",
                   diameter: "~105,700 light-years",
                   temperature: "10K to 10 million K",
                   mass: "~1.5E12 solar masses",
                   orbitalPeriod: "225-250 million years",
                   surfaceGravity: "Varies across regions",
                   moons: "None",
                   distanceFromSun: "We are inside it",
                   facts: ["It contains over 100 billion stars.", "A supermassive black hole (Sagittarius A*) sits at its center.", "It is on a collision course with the Andromeda Galaxy in ~4.5 billion years."]
                  ),
            Planet(name: "Andromeda Galaxy",
                   subInfo: "The nearest spiral galaxy to us",
                   diameter: "220,000 light-years",
                   temperature: "Varies (similar to the Milky Way)",
                   mass: "~1.5E12 solar masses",
                   orbitalPeriod: "~10 billion years",
                   surfaceGravity: "Varies across regions",
                   moons: "None",
                   distanceFromSun: "2.5 million light-years",
                   facts: ["It is the largest galaxy in the Local Group.", "It is moving toward the Milky Way and will merge with it in ~4.5 billion years.", "It contains about 1 trillion stars, more than the Milky Way."]
                  ),
            Planet(name: "Whirlpool Galaxy",
                   subInfo: "A stunning face-on spiral galaxy",
                   diameter: "~76,000 light-years",
                   temperature: "Varies (hot star-forming regions ~10,000K)",
                   mass: "~1.6E11 solar masses",
                   orbitalPeriod: "None",
                   surfaceGravity: "Varies across regions",
                   moons: "None",
                   distanceFromSun: "31 million light-years",
                   facts: ["It has a small companion galaxy (NGC 5195) interacting with it.", "It was the first galaxy recognized as a spiral structure.", "It is a favorite target for astronomers and photographers due to its bright, well-defined arms."]
                  )
        ]
    }
    
    static func fetchBlackHoles() -> [Planet] {
        [
            Planet(name: "Sagittarius A",
                   subInfo: "Supermassive black hole at the center of the Milky Way",
                   diameter: "~44 million km",
                   temperature: "~10 million K",
                   mass: "~4.3E6 solar masses",
                   orbitalPeriod: "surrounding stars orbit it",
                   surfaceGravity: "distorting space-time",
                   moons: "None",
                   distanceFromSun: "~26,500 light-years",
                   facts: ["It was directly imaged in 2022 by the Event Horizon Telescope.", "Despite its immense mass, it has a relatively low accretion rate.", "Stars near it move at speeds exceeding 8,000 km/s due to its gravity."]
                  ),
            Planet(name: "TON 618",
                   subInfo: "One of the largest known black holes",
                   diameter: "~390 billion km",
                   temperature: "Millions of K",
                   mass: "~66E9 solar masses",
                   orbitalPeriod: "One of the strongest gravitational forces known",
                   surfaceGravity: "distorting space-time",
                   moons: "None",
                   distanceFromSun: "~10.4 billion light-years",
                   facts: ["It is a hypermassive black hole, one of the biggest ever discovered.", "Its accretion disk is one of the brightest quasars in the universe.", "It could swallow the entire solar system with room to spare."]
                  )
        ]
    }
}
