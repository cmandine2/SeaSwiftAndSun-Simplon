//
//  LookAroundView.swift
//  SeaSwiftAndSun-Simplon
//
//  Created by Zoé Hartman on 14/12/2023.
//

import SwiftUI
import MapKit
import CoreLocation

struct SelectedSpotMapInfoView: View {
	
	@Binding var closeModal: Bool
	let selectedSpot: SurfSpotFields
	@State private var lookAroundScene: MKLookAroundScene?
	
	func getLookAroundScene() {
		lookAroundScene = nil
		Task {
			if let coor = selectedSpot.parsedCoor {
				let request = MKLookAroundSceneRequest(coordinate: coor)
				lookAroundScene = try? await request.scene
			}
		}
	}
	
    var body: some View {
		VStack{
			HStack(alignment: .top) {
				VStack (alignment: .leading) {
					HStack{
						Image(systemName: "surfboard.fill")
							.resizable()
							.scaledToFit()
							.frame(width: 18, height: 18)
							.foregroundColor(.white)
							.padding(6)
							.background(Color.accentColor)
							.clipShape(Circle())
							.opacity(0.9)
						Text("Surf Spot")
							.foregroundColor(.accentColor)
						Spacer()
					}
						Text("\(selectedSpot.destination)")
						.font(.title)
						.bold()
						Text("\(selectedSpot.destinationStateCountry)")
						.font(.title2)
				}
				.padding(10)

				Spacer()
				Button {
					closeModal = true
				} label: {
					Image(systemName: "xmark.circle.fill")
						.symbolRenderingMode(.hierarchical)
						.foregroundColor(.gray)
						.font(.system(size: 27))
						.padding(10)
				}
				
			}
			LookAroundPreview(initialScene: lookAroundScene)
				.onAppear{
					getLookAroundScene()
				}
				.onChange(of: selectedSpot) {
					getLookAroundScene()
				}
				.frame(height: 200)
				.padding(.bottom, 20)
		}
		.frame(minHeight: 50)
		.padding()
		.background(Color.white.opacity(0.9))
		.background(.ultraThinMaterial)
	}
}

#Preview {
	SelectedSpotMapInfoView(closeModal: .constant(false), selectedSpot: SurfSpotFields(
		peakSurfSeasonBegins: "2024-08-23",
		destinationStateCountry: "Tillamook, Oregon",
		peakSurfSeasonEnds: "2024-10-17",
		influencers: ["recxLX95tZ2PFokyE", "recGQHgfO1K7TeKPO"],
		surfBreak: ["Beach Break"],
		magicSeaweedLink: "https://magicseaweed.com/Rockaway-Surf-Report/384/",
		photos: [Photo(
			id: "att3KRu08PBz1d5Be",
			width: 5184,
			height: 3456,
			url: "https://v5.airtableusercontent.com/v2/23/23/1702317600000/8NrM0f5P7UjyLYtBt8lTXQ/tE5L6LgxQnGAjViaKwXxThqYcY1GsWaONsq1519fBSKhHDDoHFQftwwfOrDZb8ZgB_4g4TKzf8mgnwjRE4DWkET66Fe3sDGyleGqbQzeqgFOY6BG_aYrPE_8lqnnChrq58kT7KM8UnGdDTa8onzX1g/fsozUN-DkmZ0WFHeouCxUduG2V1HGITOjFi2s52anAI",
			filename: "dmytro-barylo-152817-unsplash.jpg",
			size: 2959901,
			type: "image/jpeg",
			thumbnails: Thumbnails(
				small: Thumbnail(
					url: "https://v5.airtableusercontent.com/v2/23/23/1702317600000/cSdR8NeSHh4Q5542aGbZUw/96MTZ8toHxJZdcw6bDRU9-Z7EZv6PONToZ8P_0zJU6rodQRwYZgufnmpNGYvv_RowJlNcXGGIujXfcyWHENX0sQ7z_jFUNEbFbZTK63mNWvu130OGINlZXLDXi5jSOjgB3q9Rz7Z1jygHmtV2TpPyA/4FDVJ0a4Gs-GSWXqR1gJeRR6e75HcMjQS5t1tjzTgvs",
					width: 54,
					height: 36
				),
				large: Thumbnail(
					url: "https://v5.airtableusercontent.com/v2/23/23/1702317600000/Nn2HN8fGr9u2Fhf8QQ3V7Q/H_TIoFt88LAJjqHOmuifqDiObNi0d53Ro0LWo1Gs00hKAOa35LyGBvn3kZarvQ2JdwS7-VTGvdXkOecHlKuyikap8ecyMRRPRPHN28gmc2D8G7IUqdYXYYvWQzpcQugJF2JJfvIHzzs1p7WcqIA0Aw/L2z2voCyI2W8V8aWDZ2lJvnHZ9Hy0bntn5PMLEWz7rM",
					width: 768,
					height: 512
				),
				full: Thumbnail(
					url: "https://v5.airtableusercontent.com/v2/23/23/1702317600000/3XZ9bTDs0qZl8wa2vvyc6Q/4_qHtir5GrRgndN0ptILEhG3zZufsVLmCMoN0tH1jMnsoLNGRX-TNqQjMf28UR4bvWoQdz64fiNBYw4fBbh0sUyFxtLc3WyPr8Lf4XrinCo8KvW4llN6AlbNPHD2UboG0LeGlLRVqhdDQjldYwKqlg/4jE6oOuB4BT6tSZHH02qENCv8SuN6bxMRxUMG3div2w",
					width: 3000,
					height: 2000
				)
			)
		)],
		difficultyLevel: 1,
		destination: "Rockaway Beach",
		travellers: [],
		coordinates: "45.614236414263345, -123.94347522746406",
		parsedCoor: CLLocationCoordinate2D(latitude: 45.614236414263345, longitude: -123.94347522746406),
		address: "Rockaway Beach, Tillamook, Oregon"
	))
}
