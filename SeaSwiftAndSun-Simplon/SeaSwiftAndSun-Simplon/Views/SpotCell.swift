//
//  SpotCell.swift
//  SeaSwiftAndSun-Simplon
//
//  Created by Amandine Cousin on 05/12/2023.
//

import UIKit

class SpotCell: UITableViewCell {
	@IBOutlet weak var spotImage: UIImageView!
	@IBOutlet weak var spotName: UILabel!
	@IBOutlet weak var spotDestinationStateCountry: UILabel!
	@IBOutlet weak var spotDifficultyLevel: UILabel!

	func setUpCell(with spotFields: SurfSpotFields) {
		self.spotName.text = spotFields.destination
		self.spotDestinationStateCountry.text = spotFields.destinationStateCountry
		self.spotDifficultyLevel.text = "\( spotFields.difficultyLevel)"

		if let photos = spotFields.photos {
			if let thumbnailUrl = photos.first?.thumbnails?.small?.url,
			   let url = URL(string: thumbnailUrl) {
				if let spotImage = self.spotImage {
					self.spotImage.load(url: url)
					spotImage.layer.cornerRadius = spotImage.frame.size.width / 2
					spotImage.clipsToBounds = true
				}
			} else {
				self.spotImage.image = UIImage(named: "surfSpot") // Image par défaut
			}
		}
	
	}
}
