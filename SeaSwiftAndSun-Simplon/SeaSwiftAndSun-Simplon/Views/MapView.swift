//
//  MapView.swift
//  SeaSwiftAndSun-Simplon
//
//  Created by Zoé Hartman on 13/12/2023.
//

import SwiftUI
import MapKit

struct MapView: View {
	@State private var allSpots: [SurfSpotFields]
	@State private var selectedSpot: SurfSpotFields?
	@State private var closeModal = false
	@State private var position: MapCameraPosition = .automatic
	
	init(allSpots: [SurfSpotFields]) {
		_allSpots = State(initialValue: allSpots.filter { $0.parsedCoor != nil })
		_selectedSpot = State(initialValue: nil)
	}
	
	var body: some View {
		Map(position: $position, selection: $selectedSpot) {
			ForEach(allSpots, id: \.self) { spot in
				if let coor =  spot.parsedCoor {
					Annotation(spot.destination, coordinate: coor, anchor: .bottom){
						Image(systemName: "surfboard.fill")
							.resizable()
							.scaledToFit()
							.frame(width: 18, height: 18)
							.foregroundColor(.white)
							.padding(6)
							.background(Color.accentColor)
							.clipShape(Circle())
							.overlay(
								Circle().stroke(Color.white, lineWidth: 2)
							)
							.opacity(0.9)
					}.tag(spot.hashValue)
				}
			}
		}
		.safeAreaInset(edge: .bottom){
			if let selectedSpot {
				SelectedSpotMapInfoView(closeModal: $closeModal, selectedSpot: selectedSpot)
					.cornerRadius(20)
					.shadow(radius: 10)
					.transition(.move(edge: .bottom))
					.transaction { transaction in
						transaction.animation = .easeInOut
					}
			}
		}
		.onChange(of: closeModal, { oldValue, newValue in
			if newValue == true {
				selectedSpot = nil
			}
		})
		.mapControls {
			MapPitchToggle()
			MapScaleView()
		}
		.mapStyle(.standard(elevation: .realistic))
		.ignoresSafeArea(.container)
	}
}
