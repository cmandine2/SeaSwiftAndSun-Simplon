//
//  DetailSpotViewController.swift
//  SeaSwiftAndSun-Simplon
//
//  Created by Amandine Cousin on 05/12/2023.
//

import UIKit

class DetailSpotViewController: UIViewController {
    @IBOutlet weak var spotImage: UIImageView!
    @IBOutlet weak var spotName: UILabel!
    @IBOutlet weak var spotDestination: UILabel!
    @IBOutlet weak var spotDifficulty: UILabel!
    var spotDetails: SurfSpotFields?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("details loaded")
        self.setUpUI()
        print("details set up")
    }
    
    func setUpUI() {
        if let details = spotDetails {
            if let photos = details.photos {
                if let thumbnailUrl = photos.first?.url,
                   let url = URL(string: thumbnailUrl) {
                    if let spotImage = self.spotImage {
                        self.spotImage.load(url: url)
                        self.spotImage.layer.cornerRadius = self.spotImage.frame.size.width / 2
                    }
                } else {
                    self.spotImage.image = UIImage(named: "surfSpot") // Image par défaut
                }
            }
            self.spotName.text = details.destination
            self.spotDestination.text = details.destinationStateCountry
            self.spotDifficulty.text = String(details.difficultyLevel)
        }
    }
}
