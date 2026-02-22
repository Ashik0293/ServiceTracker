//
//  LocationService.swift
//  ServiceTracker
//
//  Created by Mohamed Ashik BUhari S on 22/02/26.
//


import CoreLocation

final class LocationService {
    
    private let geocoder = CLGeocoder()
    
    func getCoordinates(from address: String) async throws -> CLLocationCoordinate2D {
        
        let placemarks = try await geocoder.geocodeAddressString(address)
        
        guard let location = placemarks.first?.location else {
            throw NSError(domain: "GeocodingError", code: 1)
        }
        
        return location.coordinate
    }
    
}
