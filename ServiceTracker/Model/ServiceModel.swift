//
//  ServiceModel.swift
//  ServiceTracker
//
//  Created by Mohamed Ashik BUhari S on 22/02/26.
//


import CoreLocation

struct Service: Identifiable {
    let id = UUID()
    let title: String
    let customer: String
    let description: String
    let date: Date
    let location: String
    let coordinate: CLLocationCoordinate2D
    let notes: String
    let status: String
}
