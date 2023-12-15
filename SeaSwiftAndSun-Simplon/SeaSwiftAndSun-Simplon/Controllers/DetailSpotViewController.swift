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
    @IBOutlet weak var peakSeasonView: UIStackView!
    @IBOutlet weak var peakSeasonLabelOne: UILabel!
    @IBOutlet weak var peakSeasonLabelTwo: UILabel!
    @IBOutlet weak var peakSeasonStartDate: UILabel!
    @IBOutlet weak var peakSeasonEndDate: UILabel!
    @IBOutlet weak var magicSinkWeedLink: UIButton!
    @IBOutlet weak var link: UIStackView!
    var spotDetails: SurfSpotFields?
    var url = URL(string: "")

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
    }
    
    func setUpUI() {
        if let details = spotDetails {
            if let photos = details.photos {
                if let thumbnailUrl = photos.first?.url,
                   let url = URL(string: thumbnailUrl) {
					if self.spotImage != nil {
                        self.spotImage.load(url: url)
                    }
                } else {
                    self.spotImage.image = UIImage(named: "surfSpot") // Image par défaut
                }
            }
            self.spotName.text = details.destination
            self.spotDestination.text = details.destinationStateCountry
            self.spotDifficulty.text = String(details.difficultyLevel)
            self.magicSinkWeedLink.setTitle("Magic Seaweed Link", for: .normal)
            self.peakSeasonLabelOne.text = "Peak season runs from"
            self.peakSeasonLabelTwo.text = "to"
            self.peakSeasonStartDate.text = details.peakSurfSeasonBegins
            self.peakSeasonEndDate.text = details.peakSurfSeasonEnds
        }
    }

    @IBAction func goToURL(_ sender: Any) {
        if let url = URL(string: spotDetails?.magicSeaweedLink ?? "") {
            UIApplication.shared.open(url)
        }
    }
}
