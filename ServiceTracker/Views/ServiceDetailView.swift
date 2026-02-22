//
//  ServiceDetailView.swift
//  ServiceTracker
//
//  Created by Mohamed Ashik BUhari S on 22/02/26.
//

import SwiftUI
import MapKit

struct ServiceDetailView: View {
    
    let service: Service
    @State private var region: MKCoordinateRegion
    @StateObject private var viewModel = ServiceDetailViewModel()
    
    
    init(service: Service) {
        self.service = service
        _region = State(initialValue: MKCoordinateRegion(
            center: service.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        ))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if let region = viewModel.region {
                    Map(initialPosition: .region(region)) {
                        Marker(service.title, coordinate: region.center)
                    }
                    .frame(height: 220)
                    .cornerRadius(15)
                    .padding(.horizontal)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                            .padding(.horizontal)
                    )
                    
                    
                } else {
                    ProgressView()
                        .frame(height: 220)
                }
                
                
                VStack(alignment: .leading, spacing: 15) {
                    HStack {
                        Text(service.title)
                            .font(.title2).bold()
                        Spacer()
                        StatusBadgeView(service: service)
                        
                    }
                    
                    DetailSection(icon: "person.circle", title: "Customer", content: service.customer)
                    DetailSection(icon: "doc.text", title: "Description", content: service.description)
                    DetailSection(icon: "clock", title: "Scheduled Time", content: formatDate(service.date))
                    DetailSection(icon: "location.square", title: "Location", content: service.location)
                    DetailSection(icon: "ellipsis.message", title: "Service Notes", content: service.notes)
                }
                .padding(.horizontal)
            }.task {
                await viewModel.fetchCoordinates(for: service.location)
            }
        }
        .navigationTitle("Service Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailSection: View {
    let icon: String
    let title: String
    let content: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(Color(hex: "2E5EAA"))
                .font(.system(size: 18))
            VStack(alignment: .leading, spacing: 4) {
                Text(title).font(.headline)
                Text(content).font(.subheadline).opacity(0.75)
            }
        }
    }
}

#Preview {
    ServiceDetailView(service: Service(
        title: "Office Space Revamp",
        customer: "XYZ Industries",
        description: "Transform your office with sleek, contemporary furnishings your team will love.",
        date: Date(),
        location: "Maple Avenue, Seattle, WA 98101", coordinate: .init(latitude: 47.6062, longitude: -122.3321),
        notes: "Ensure all furniture is removed before the renovation begins. Confirm the layout with the client and finalize color schemes for walls and furnishings",
        status: "Planned"
    ))
}
