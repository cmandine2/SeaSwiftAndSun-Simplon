//
//  DetailSpotViewController.swift
//  SeaSwiftAndSun-Simplon
//
//  Created by Amandine Cousin on 05/12/2023.
//

import UIKit

class DetailSpotViewController: UIViewController {
    var selectedSpot: Spot?
    var selectedImage: UIImage?
    
    @IBOutlet weak var spotName: UILabel!
    @IBOutlet weak var spotImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let spot = selectedSpot {
            self.setUpUI(spot: spot)
        }
    }
    
    func setUpUI(spot: Spot) {
        self.spotImage.image = self.selectedImage 
        self.spotImage.layer.cornerRadius = self.spotImage.frame.size.width / 2
    }
}
