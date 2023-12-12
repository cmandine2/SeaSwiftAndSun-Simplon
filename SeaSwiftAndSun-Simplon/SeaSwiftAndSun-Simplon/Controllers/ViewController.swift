//
//  ViewController.swift
//  SeaSwiftAndSun-Simplon
//
//  Created by Amandine Cousin on 05/12/2023.
//

import UIKit

class ViewController: UIViewController {
	@IBOutlet weak var tableView: UITableView!
	var surfSpots: [SurfSpotFields] = []

	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.delegate = self
		tableView.dataSource = self
		loadSurfSpotsData()
	}
	
	private func loadSurfSpotsData() {
		NetworkManager.shared.fetchSurfSpots { [weak self] result in
			DispatchQueue.main.async {
				switch result {
					case .success(let surfSpotResponse):
//						print("success test")
						self?.surfSpots = surfSpotResponse.records.map { $0.fields }
						self?.updateUI()
					case .failure(let error):
						print("failure test")
						self?.handleError(error)
				}
			}
		}
	}
	
	private func updateUI() {
		tableView.reloadData()
	}
	
	private func handleError(_ error: Error) {
		print(error)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "toDetails",
		   let indexPath = sender as? IndexPath,
		   let destinationVC = segue.destination as? DetailSpotViewController {
			destinationVC.spotDetails = surfSpots[indexPath.row]
		}
	}
}

//MARK: Handle Data source and delegate of tableview
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Sections
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 3
//    }
//    
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
        switch section {
        default:
				return surfSpots.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SpotCell", for: indexPath) as! SpotCell
		let spotField = surfSpots[indexPath.row]
		cell.setUpCell(with: spotField)
		return cell
    }
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		performSegue(withIdentifier: "toDetails", sender: indexPath)
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

