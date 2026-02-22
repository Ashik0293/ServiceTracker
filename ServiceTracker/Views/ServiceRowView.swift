//
//  ServiceRowView.swift
//  ServiceTracker
//
//  Created by Mohamed Ashik BUhari S on 22/02/26.
//

import SwiftUI
import MapKit


struct ServiceRowView: View {
    
    let service: Service
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            HStack(alignment: .top) {
                Text(service.title)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.black)
                
                Spacer()
                
                Circle()
                    .fill(statusColor(for: service.status))
                    .frame(width: 10, height: 10)
                    .padding(.top, 8)
            }
            
            
            HStack(alignment: .center, spacing: 10) {
                Image(systemName: "person.circle")
                    .foregroundColor(Color(hex: "2E5EAA"))
                    .font(.system(size: 14))
                
                Text(service.customer)
                    .font(.system(size: 14))
                    .foregroundColor(.black).opacity(0.75)
            }
            
            
            HStack(alignment: .top, spacing: 10) {
                Image(systemName: "doc.text")
                    .foregroundColor(Color(hex: "2E5EAA"))
                    .font(.system(size: 14))
                
                Text(service.description)
                    .font(.system(size: 14))
                    .foregroundColor(.black.opacity(0.8))
                    .lineLimit(3)
                    .lineSpacing(4)
            }
            //.padding(.bottom, 10)
            
            
            HStack {
                
                StatusBadgeView(service: service)
                
                Spacer()
                
                Text(formatDate(service.date))
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(25)
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
    }
}


#Preview {
    ServiceRowView(
        service: Service(
            title: "Office Space Revamp",
            customer: "XYZ Industries",
            description: "Transform your office with sleek, contemporary furnishings your team will love.",
            date: Date(),
            location: "Maple Avenue, Seattle, WA 98101", coordinate: .init(latitude: 47.6062, longitude: -122.3321),
            notes: "Ensure all furniture is removed before the renovation begins. Confirm the layout with the client and finalize color schemes for walls and furnishings.",
            status: "Planned"
        )
    )
    .padding()
}
