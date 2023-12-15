//
//  SwiftUIContainerView.swift
//  SeaSwiftAndSun-Simplon
//
//  Created by Zoé Hartman on 13/12/2023.
//

import SwiftUI

struct FinalView: UIViewControllerRepresentable {
	var allSpots: [SurfSpotFields]
	
	func makeUIViewController(context: Context) -> some UIViewController {
		let swiftUIView = MapView(allSpots: allSpots)
		let hostingController = UIHostingController(rootView: swiftUIView)
		return hostingController
	}
	
	func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
	}
}
