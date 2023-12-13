import Foundation

// MARK: - Welcome
struct Destinations: Codable {
    let spots: [Spot]
    
    enum CodingKeys: String, CodingKey {
        case spots = "records"
    }
}

// MARK: - Record
struct Spot: Codable, Identifiable {
    let id: String
    let createdTime: String
    let fields: Fields
}

// MARK: - Fields
struct Fields: Codable {
    let difficultyLevel: Int
    let surfBreak: [String]
    let magicSeaweedLink: String
    let photos: [Photo]
    let peakSurfSeasonBegins: String
    let destinationStateCountry: String
    let peakSurfSeasonEnds: String
    let destination: String
    let influencers: [String]?
    let address: String

    enum CodingKeys: String, CodingKey {
        case difficultyLevel = "Difficulty Level"
        case surfBreak = "Surf Break"
        case magicSeaweedLink = "Magic Seaweed Link"
        case photos = "Photos"
        case peakSurfSeasonBegins = "Peak Surf Season Begins"
        case destinationStateCountry = "Destination State/Country"
        case peakSurfSeasonEnds = "Peak Surf Season Ends"
        case destination = "Destination"
        case influencers = "Influencers"
        case address = "Address"
    }
}

// MARK: - Photo
struct Photo: Codable {
    let id: String
    let width: Int
    let height: Int
    let url: String
    let filename: String
    let size: Int
    let type: String
}
