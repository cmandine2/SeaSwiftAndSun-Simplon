//
//  MapView.swift
//  SeaSwiftAndSun-Simplon
//
//  Created by Zoé Hartman on 13/12/2023.
//

import SwiftUI
import MapKit

struct MapView: View {
	@State private var region = MKCoordinateRegion(
		center: CLLocationCoordinate2D(latitude: 34.0522, longitude: -118.2437), // Example coordinates
		span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
	)
	
	var body: some View {
		Map(coordinateRegion: $region)
	}
}

#Preview {
    MapView()
}
