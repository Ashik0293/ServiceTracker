//
//  ServicesViewModel.swift
//  ServiceTracker
//
//  Created by Mohamed Ashik BUhari S on 22/02/26.
//

import SwiftUI
import Combine
import MapKit

@MainActor
class ServicesViewModel: ObservableObject {
    
    @Published var services: [Service] = []
    @Published var filteredServices: [Service] = []
    @Published var searchText: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    private let locationService = LocationService()
    
    init() {
        
        $searchText
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .sink { [weak self] searchText in
                self?.filterServices(with: searchText)
            }
            .store(in: &cancellables)
        
        
        Task {
            await self.loadServices()
        }
    }
    
    func loadServices() async {
        
        services = await fetchMockServices()
        filterServices(with: searchText)
        
    }
    
    private func fetchMockServices() async -> [Service] {
        try? await Task.sleep(for: .seconds(2))
        
        let now = Date()
        let today3PM = Calendar.current.date(bySettingHour: 15, minute: 0, second: 0, of: now)!
        let today330PM = Calendar.current.date(bySettingHour: 15, minute: 30, second: 0, of: now)!
        let today4PM = Calendar.current.date(bySettingHour: 16, minute: 0, second: 0, of: now)!
        let today5PM = Calendar.current.date(bySettingHour: 17, minute: 0, second: 0, of: now)!
        
        return [
            
            Service(title: "Office Space Revamp",
                    customer: "XYZ Industries",
                    description: "Transform your office with sleek, contemporary furnishings.",
                    date: today3PM,
                    location: "Maple Avenue, Seattle, WA 98101",
                    coordinate: .init(latitude: 47.6062, longitude: -122.3321),
                    notes: "Ensure all furniture is removed before the renovation begins. Confirm the layout with the client and finalize color schemes for walls and furnishings.",
                    status: "Planned"),
            Service(title: "Modern Workspace Makeover",
                    customer: "Acme Corp",
                    description: "Revitalize your workspace with stylish, modern decor that inspires creativity.",
                    date: today330PM,
                    location: "Pine Street, Seattle, WA 98102", coordinate:.init(latitude: 47.6062, longitude: -122.3321),
                    notes: "Focus on ergonomic furniture and lighting. Discuss preferences with the team lead.",
                    status: "Scheduled"),
            Service(title: "Contemporary Office Transformation",
                    customer: "Beta Solutions",
                    description: "Elevate your office environment with chic, innovative designs that spark inspiration.",
                    date: today4PM,
                    location: "Oak Lane, Seattle, WA 98103",coordinate:.init(latitude: 47.6062, longitude: -122.3321),
                    notes: "Incorporate smart tech integrations. Verify electrical outlets placement.",
                    status: "Confirmed"),
            Service(title: "Modern Workspace Overhaul",
                    customer: "Alpha Innovations",
                    description: "Transform your workspace with stylish, cutting-edge designs that inspire creativity.",
                    date: today5PM,
                    location: "Cedar Road, Seattle, WA 98104",coordinate:.init(latitude: 47.6062, longitude: -122.3321),
                    notes: "Prioritize open spaces and collaborative areas. Finalize material selections.",
                    status: "Approved"),
            Service(title: "Revamp Your Workspace Today",
                    customer: "Innovative Solutions Inc.",
                    description: "Innovative solutions to revamp your workspace with modern touches.",
                    date: Calendar.current.date(byAdding: .day, value: 1, to: now)!,
                    location: "Birch Avenue, Seattle, WA 98105",coordinate:.init(latitude: 47.6062, longitude: -122.3321),
                    notes: "Schedule team walkthrough. Confirm delivery times for new items.",
                    status: "Planned")
            
            
        ]
    }
    
    private func filterServices(with text: String) {
        if text.isEmpty {
            filteredServices = services
        } else {
            let lowerText = text.lowercased()
            filteredServices = services.filter { service in
                service.title.lowercased().contains(lowerText) ||
                service.customer.lowercased().contains(lowerText) ||
                service.description.lowercased().contains(lowerText)
            }
        }
    }
    
}
