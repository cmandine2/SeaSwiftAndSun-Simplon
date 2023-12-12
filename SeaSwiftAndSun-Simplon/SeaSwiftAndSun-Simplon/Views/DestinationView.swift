//
//  DestinationView.swift
//  SeaSwiftAndSun-Simplon
//
//  Created by Keyhan Mortezaeifar on 12/12/2023.
//

import SwiftUI

struct DestinationView: View {
    var viewModelDestinations = ViewModelDestination()
    
    var body: some View {
        List {
//            ForEach(Data)
        }
        .onAppear {
            viewModelDestinations.getSpot()
        }
    }
}

#Preview {
    DestinationView()
}
