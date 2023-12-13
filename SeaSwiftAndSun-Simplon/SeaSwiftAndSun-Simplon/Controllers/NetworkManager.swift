//
//  NetworkManager.swift
//  SeaSwiftAndSun-Simplon
//
//  Created by Zoé Hartman on 11/12/2023.
//

import Foundation

class NetworkManager {
	static let shared = NetworkManager()
	
	func fetchSurfSpots(completion: @escaping (Result<SurfSpotResponse, Error>) -> Void) {
		let urlString = "https://api.airtable.com/v0/appcknqL5M0JnYWJs/Surf%20Destinations"
		guard let url = URL(string: urlString) else { return }
		let token = "patGEZgBMoKPULnG5.74ee97f4393d8995f9f07cb5ef6b2b8a714321247bf80a214997b8997982ce7a"
		
		var request = URLRequest(url: url)
		request.addValue("application/json", forHTTPHeaderField: "Content-Type")
		request.addValue("application/json", forHTTPHeaderField: "Accept")
		request.setValue( "Bearer \(token)", forHTTPHeaderField: "Authorization")
		
		URLSession.shared.dataTask(with: request) { data, response, error in
			if let error = error {
				completion(.failure(error))
				return
			}
			
			guard let data = data else {
				print("No data received")
				return
			}
			
			do {
				let surfSpotResponse = try JSONDecoder().decode(SurfSpotResponse.self, from: data)
//				print("surfSpotResponse : \(surfSpotResponse)")
				completion(.success(surfSpotResponse))
			} catch {
				print("Decoding error: \(error)")
				completion(.failure(error))
			}
		}.resume()
	}
}
