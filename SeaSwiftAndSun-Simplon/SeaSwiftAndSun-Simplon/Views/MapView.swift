//
//  MapView.swift
//  SeaSwiftAndSun-Simplon
//
//  Created by Zoé Hartman on 13/12/2023.
//

import SwiftUI
import MapKit

import SwiftUI
import MapKit

struct MapView: View {
	@State private var allSpots: [SurfSpotFields]
//	@State private var selectedSpot: SurfSpotFields?

	@State private var region: MKCoordinateRegion
	
	init(allSpots: [SurfSpotFields]) {
		self.allSpots = allSpots.filter { $0.parsedCoor != nil }
//		self.selectedSpot = selectedSpot
		self._region = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 180, longitudeDelta: 360)))
	}
	
	var body: some View {
		Map() {
			ForEach(allSpots, id: \.id) { spot in
				if let coor = spot.parsedCoor {
					Annotation(spot.destination, coordinate: coor, anchor: .bottom){
						Image(systemName: "surfboard")
							.resizable()
							.scaledToFit()
							.frame(width: 30, alignment: .center)
							.padding(1)
							.cornerRadius(3)
							.opacity(0.9)
					}
				}
			}
		}.mapControls {
			MapPitchToggle()
			MapScaleView()
		}
		.mapStyle(.standard(elevation: .realistic))
//		.safeAreaInset(edge: .bottom)
		.ignoresSafeArea(.container)
	}
}
