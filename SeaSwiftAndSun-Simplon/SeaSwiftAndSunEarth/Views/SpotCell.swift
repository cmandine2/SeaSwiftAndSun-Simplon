//
//  SpotCell.swift
//  SeaSwiftAndSun-Simplon
//
//  Created by Amandine Cousin on 05/12/2023.
//

import UIKit

class SpotCell: UITableViewCell {
    var spot: Spot?
    
    @IBOutlet weak var spotImage: UIImageView!
    @IBOutlet weak var spotName: UILabel!
    @IBOutlet weak var spotStateCountry: UILabel!
    @IBOutlet weak var difficultyLevel: UILabel!
    
    func setUpCell(spot: Spot){
        self.spot = spot
        guard let urlString = spot.fields.photos.first?.url else {
            return
        }
        self.spotImage.load(url: URL(string: urlString)!)
        self.spotImage.layer.cornerRadius = self.spotImage.frame.size.width / 2

        self.spotName.text = spot.fields.destination
        
        self.spotStateCountry.text = spot.fields.destinationStateCountry
        
        self.difficultyLevel.text = String(spot.fields.difficultyLevel)
    }
}


extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
