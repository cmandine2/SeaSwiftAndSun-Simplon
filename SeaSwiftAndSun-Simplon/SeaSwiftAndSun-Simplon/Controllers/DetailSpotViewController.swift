//
//  DetailSpotViewController.swift
//  SeaSwiftAndSun-Simplon
//
//  Created by Amandine Cousin on 05/12/2023.
//

import UIKit
import SwiftUI

class DetailSpotViewController: UIViewController {
	var spot: SurfSpotFields?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setUpUI()
	}
	
	private func setUpUI() {
		guard let spot = spot else { return }
		
		// Create the SwiftUI view
		let detailSpotView = DetailsView(spot: spot)
		
		// Use a UIHostingController to host the SwiftUI view
		let hostingController = UIHostingController(rootView: detailSpotView)
		
		// Add the hosting controller as a child view controller
		addChild(hostingController)
		view.addSubview(hostingController.view)
		hostingController.didMove(toParent: self)
		
		// Set up constraints for the hosting controller's view
		hostingController.view.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
			hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
}
