//
//  AirtableData.swift
//  SeaSwiftAndSun-Simplon
//
//  Created by Zoé Hartman on 11/12/2023.
//

import Foundation
import CoreLocation

struct SurfSpotResponse: Codable {
	let records: [SurfSpotRecord]
	
	enum CodingKeys: String, CodingKey {
		case records = "records"
	}
}

struct SurfSpotRecord: Codable {
	let id: String
	let createdTime: String
	let fields: SurfSpotFields
}

struct SurfSpotFields: Codable, Hashable {
	let id = UUID()
	let peakSurfSeasonBegins: String
	let destinationStateCountry: String
	let peakSurfSeasonEnds: String
	let influencers: [String]?
	let surfBreak: [String]?
	let magicSeaweedLink: String?
	let photos: [Photo]?
	let difficultyLevel: Int
	let destination: String
	let travellers: [String]?
	let coordinates: String?
	var parsedCoor: CLLocationCoordinate2D?
	let address: String?
	
	enum CodingKeys: String, CodingKey {
		case peakSurfSeasonBegins = "Peak Surf Season Begins"
		case destinationStateCountry = "Destination State/Country"
		case peakSurfSeasonEnds = "Peak Surf Season Ends"
		case influencers = "Influencers"
		case surfBreak = "Surf Break"
		case magicSeaweedLink = "Magic Seaweed Link"
		case photos = "Photos"
		case difficultyLevel = "Difficulty Level"
		case destination = "Destination"
		case travellers = "Travellers"
		case coordinates = "Coordinates"
		case address = "Address"
	}
	
	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
		hasher.combine(destination)
		if let parsedCoor = parsedCoor {
			hasher.combine(parsedCoor.latitude)
			hasher.combine(parsedCoor.longitude)
		}
	}
	
	static func == (lhs: SurfSpotFields, rhs: SurfSpotFields) -> Bool {
		lhs.id == rhs.id
	}
}

struct Photo: Codable {
	let id: String?
	let width: Int?
	let height: Int?
	let url: String?
	let filename: String?
	let size: Int?
	let type: String?
	let thumbnails: Thumbnails?
}

struct Thumbnails: Codable {
	let small: Thumbnail?
	let large: Thumbnail?
	let full: Thumbnail?
}

struct Thumbnail: Codable {
	let url: String?
	let width: Int?
	let height: Int?
}
