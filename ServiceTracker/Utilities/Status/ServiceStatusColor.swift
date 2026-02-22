//
//  SwiftUIView.swift
//  ServiceTracker
//
//  Created by Mohamed Ashik BUhari S on 22/02/26.
//

import SwiftUI

struct StatusBadgeView: View {
    
    let service: Service
    
    var body: some View {
        HStack(spacing: 6) {
            
            RoundedRectangle(cornerRadius: 4)
                .fill(statusColor(for: service.status).opacity(0.2))
                .frame(width: 16, height: 16)
            
            Text(service.status)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(statusColor(for: service.status))
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(statusColor(for: service.status).opacity(0.08))
        .clipShape(Capsule())
    }
    
}

func statusColor(for status: String) -> Color {
    switch status.lowercased() {
    case "planned":
        return .blue
    case "scheduled":
        return .green
    case "confirmed":
        return .blue
    case "approved":
        return .orange
    default:
        return .gray
    }
}
