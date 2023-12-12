//
//  ViewController.swift
//  SeaSwiftAndSun-Simplon
//
//  Created by Amandine Cousin on 05/12/2023.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    var spots: [Spot] = []
        
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getSpot()
        self.title = "Liste des spots de surf"
    }
    
    func getSpot() {
        SpotService.shared.getSpot { error, destination in
            self.spots = destination?.spots ?? []
            self.tableView.reloadData()
            print("destinations:", destination as Any)
        }
        
    }
}


//MARK: Handle Data source and delegate of tableview
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Sections
//    func numberOfSections(in tableView: UITableView) -> Int {
//        let surfBreak = viewModelDestination.destionations.map { record in
//            record.fields.surfBreak
//        }
//        return surfBreak.count
//
//    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        switch section {
//        case 1:
//            return "Beach Break"
//        case 2:
//            return "Reef Break"
//        default:
//            return "Point Break"
//        }
//    }

    // Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        switch section {
//        case 1:
//            return 1
//        default:
//            return 3
//        }
        return spots.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SpotCell", for: indexPath) as! SpotCell
        cell.setUpCell(spot: spots[indexPath.row])
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SpotDetails" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = segue.destination as! DetailSpotViewController
                let selectedSpot = spots[indexPath.row]
                controller.selectedSpot = selectedSpot
                guard let cell: SpotCell = tableView.cellForRow(at: indexPath) as? SpotCell else { return }
                controller.selectedImage = cell.spotImage.image
            }
        
        }
    }
}

