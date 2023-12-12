//
//  API Manager.swift
//  SeaSwiftAndSun-Simplon
//
//  Created by Keyhan Mortezaeifar on 12/12/2023.
//

import Foundation

class SpotService {
    static let shared = SpotService()
    var urlSession = URLSession(configuration: .default)
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.urlSession = session
    }
    
    private init() {}
    
    func getSpot(callback: @escaping (CustomError?, Destinations?) -> Void) {
        guard let spotUrl = URL(string: "https://api.airtable.com/v0/app0uFVsj3OmbD18z/Surf%20Destinations")
        else {
            callback(CustomError.serverUnavailable, nil)
            return
        }
        var request = URLRequest(url: spotUrl)
        request.httpMethod = "GET"
        
        request.setValue("Bearer pataYYzFkFa1ALxIA.2b34c14d6ac57424d9f8db291e18ceb40e0340547cf72f20ae81573070bd7a0a", forHTTPHeaderField: "Authorization")
        
        urlSession.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil, let response = response as? HTTPURLResponse, response.statusCode == 200
                else {
                    callback(CustomError.serverUnavailable, nil)
                    return
                }
                guard let destination = try? JSONDecoder().decode(Destinations.self, from: data)
                else {
                    callback(CustomError.invalidData, nil)
                    return
                }
                
                callback(nil, destination)
            }
        }.resume()
    }
}

enum CustomError: Error {
    case unknownError
    case invalidData
    case authenticationError
    case serverUnavailable
    
    var errorMessage: String {
            switch self {
            case .unknownError:
                return "Unexpected response from the server"
            case .invalidData:
                return "Invalid data received"
            case .authenticationError:
                return "Authentication failed"
            case .serverUnavailable:
                return "The server is currently unavailable"
        }
    }
}
