//
//  ViewModelDestination.swift
//  SeaSwiftAndSun-Simplon
//
//  Created by Keyhan Mortezaeifar on 12/12/2023.
//

import Foundation

class ViewModelDestination {
    func getSpot() {
            SpotService.shared.getSpot { error, spot in
                //sera executé en asynchrone
                //Je peux réutiliser mes variables error et spot
                print(spot as Any)
            }
        }
}
