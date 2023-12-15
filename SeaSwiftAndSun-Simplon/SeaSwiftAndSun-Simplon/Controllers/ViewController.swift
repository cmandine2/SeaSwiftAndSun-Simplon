//
//  ViewController.swift
//  SeaSwiftAndSun-Simplon
//
//  Created by Amandine Cousin on 05/12/2023.
//

import UIKit
import SwiftUI
import CoreLocation

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var surfSpots: [SurfSpotFields] = []
    let segmentedControl = UISegmentedControl(items: ["List", "Map"])
    private var mapViewController: UIHostingController<MapView>?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        loadSurfSpotsData()
        setupSegmentedControl()
    }
    
    private func loadSurfSpotsData() {
        NetworkManager.shared.fetchSurfSpots { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let surfSpotResponse):
                        self?.surfSpots = surfSpotResponse.records.compactMap { record -> SurfSpotFields? in
                            var spot = record.fields
                            if let coordinateString = spot.coordinates {
                                spot.parsedCoor = self?.parseCoordinates(from: coordinateString)
                            }
                            return spot
                        }
                        self?.updateUI()
                    case .failure(let error):
                        print("failure test")
                        self?.handleError(error)
                }
            }
        }
    }
    
    private func setupSegmentedControl() {
        segmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0
        view.addSubview(segmentedControl)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            segmentedControl.heightAnchor.constraint(greaterThanOrEqualToConstant: 30)
        ])
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc func segmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0:
                tableView.isHidden = false
                mapViewController?.view.removeFromSuperview()
                mapViewController = nil
            case 1:
                tableView.isHidden = true
                presentMapView()
            default:
                break
        }
    }
    
    
    private func presentMapView() {
        if mapViewController != nil {
            return
        }
        
        let hostingController = UIHostingController(rootView: MapView(allSpots: surfSpots))
        self.mapViewController = hostingController
        
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 8),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func parseCoordinates(from string: String) -> CLLocationCoordinate2D? {
        let components = string.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
        if components.count == 2,
           let latitude = Double(components[0]),
           let longitude = Double(components[1]) {
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
        return nil
    }
    
    private func updateUI() {
        tableView.reloadData()
    }
    
    private func handleError(_ error: Error) {
        print(error)
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
           let storyboard = UIStoryboard(name: "Main", bundle: nil)
           if let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailSpotViewController") as? DetailSpotViewController {
               detailVC.spot = surfSpots[indexPath.row]
               self.navigationController?.pushViewController(detailVC, animated: true)
           }
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
