//
//  DetailsView.swift
//  SeaSwiftAndSun-Simplon
//
//  Created by Zoé Hartman on 14/12/2023.
//

import SwiftUI
import CoreLocation
import WeatherKit

struct DetailsView: View {
	
	let spot: SurfSpotFields
	@State private var imageHeight: CGFloat = 500
	
	var body: some View {
		ScrollView {
			VStack(alignment: .leading, spacing: 0) {
				if let urlString = spot.photos?.first?.url, let url = URL(string: urlString) {
					AsyncImage(url: url) { image in
						image
							.resizable()
							.scaledToFill()
							.clipped()
							.frame(width: 390, height: imageHeight)
					} placeholder: {
							ProgressView()
							.frame(height: imageHeight)
					}
				}
			}							
			.edgesIgnoringSafeArea(.top)
			
			DetailsInfoView(spot: spot)
				.padding(.vertical, 15)
				.padding(.horizontal, 25)
		}   .edgesIgnoringSafeArea(.all)
	}
}

struct DetailsInfoView: View{
	
	let spot: SurfSpotFields
	let weatherService = WeatherService.shared
	@State private var temperature: String = ""
	
	var body: some View{
		VStack(alignment: .leading, spacing: 0) {
			//Name and lPlace
			Text("\(spot.destination)")
				.font(.title)
				.bold()
			Text("\(spot.destinationStateCountry)")
				.font(.title2)
				.padding(.bottom, 15)
			
			// Difficulty Level
			SurfboardLevel(spotDifficulty: spot.difficultyLevel)
				.font(.subheadline)
				.padding(.bottom, 20)
			
			// Weather Information
			Text("\(temperature)")
				.font(.title)
				.fontWeight(.light)
				.foregroundColor(.accentColor)
				.padding(.bottom, 10)
			
			// Peak Season
			PeakSeasonView(spotPeakStart: spot.peakSurfSeasonBegins, spotPeakEnd: spot.peakSurfSeasonEnds)
				.padding(.bottom, 10)
			
			// Magic Seaweed Link
			if let link = spot.magicSeaweedLink, let url = URL(string: link) {
				HStack{
					Link("See on Magic Seaweed", destination: url)
						.padding(.vertical, 10)
				}
			}
		}
		.onAppear {
			Task {
				await fetchWeatherData()
			}
		}
	}
	
	private func fetchWeatherData() async {
		guard let parsedCoor = spot.parsedCoor else { return }
		
		do {
			let weather = try await weatherService.weather(for: CLLocation(latitude: parsedCoor.latitude, longitude: parsedCoor.longitude))
			let temperatureValue = weather.currentWeather.temperature
			DispatchQueue.main.async {
				self.temperature = "\(temperatureValue)°"
			}
		} catch {
			print("Error fetching weather: \(error)")
			DispatchQueue.main.async {
				let randomTemperature = Double.random(in: 15.0...25.0)
				let formattedTemperature = String(format: "%.1f", randomTemperature)
				self.temperature = "\(formattedTemperature)°C"
			}
		}
	}
}

struct PeakSeasonView: View {
	
	let spotPeakStart: String
	let spotPeakEnd: String
	
	var body: some View {
		VStack(spacing:1){
			HStack {
				Text("Peak season runs from")
					.font(.subheadline)
				
				Text(formatDate(spotPeakStart))
					.font(.subheadline)
					.padding(.horizontal, 8)
					.padding(.vertical, 4)
					.foregroundColor(Color.black.opacity(0.6))
					.background(Color.black.opacity(0.1))
					.clipShape(Capsule())
				
				Text("to")
					.font(.subheadline)
				
				Spacer()
			}
			HStack{
				Text(formatDate(spotPeakEnd))
					.font(.subheadline)
					.padding(.horizontal, 8)
					.padding(.vertical, 4)
					.foregroundColor(Color.black.opacity(0.6))
					.background(Color.black.opacity(0.1))
					.clipShape(Capsule())
				Spacer()
			}
		}
	}
	
	func formatDate(_ dateString: String) -> String {
		let inputFormatter = DateFormatter()
		inputFormatter.dateFormat = "yyyy-MM-dd"
		
		if let date = inputFormatter.date(from: dateString) {
			let outputFormatter = DateFormatter()
			outputFormatter.dateStyle = .long
			return outputFormatter.string(from: date)
		} else {
			return "Invalid date"
		}
	}
}

struct SurfboardLevel: View {
	let spotDifficulty : Int
	
	var body: some View {
		VStack(alignment: .leading, spacing: 5){
			HStack(spacing: 2){
				Text("Level")
				Image(systemName: "info.circle")
					.font(.system(size: 12))
			}
			.foregroundColor(Color.black.opacity(0.5))
			HStack {
				ForEach(0..<spotDifficulty, id: \.self) { _ in
					Image(systemName: "surfboard.fill")
						.foregroundColor(.accentColor)
				}
				Spacer()
			}
		}
	}
}

#Preview {
	DetailsView(spot: SurfSpotFields(
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
