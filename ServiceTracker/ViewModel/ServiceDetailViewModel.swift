//
//  ServiceDetailViewModel.swift
//  ServiceTracker
//
//  Created by Mohamed Ashik BUhari S on 22/02/26.
//

import MapKit
import SwiftUI
import Combine

@MainActor
class ServiceDetailViewModel: ObservableObject {
   
    @Published var region: MKCoordinateRegion?
    
    private let locationService = LocationService()
    
    func fetchCoordinates(for address: String) async {
        do {
            let coordinate = try await locationService.getCoordinates(from: address)
            
            region = MKCoordinateRegion(
                center: coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
        } catch {
            print("Geocoding failed:", error)
        }
    }
}
