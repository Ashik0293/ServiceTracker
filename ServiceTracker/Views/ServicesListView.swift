//
//  ServicesListView.swift
//  ServiceTracker
//
//  Created by Mohamed Ashik BUhari S on 22/02/26.
//

import SwiftUI

struct ServiceListView: View {
    @StateObject private var viewModel = ServicesViewModel()
    
    var body: some View {
        NavigationStack {
            List(viewModel.filteredServices) { service in
                NavigationLink(destination: ServiceDetailView(service: service)) {
                    ServiceRowView(service: service)

                }
                .navigationLinkIndicatorVisibility(.hidden)
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets())
                .padding(.horizontal,16)
                .padding(.bottom,20)
            }
            .listStyle(.plain)
            .navigationTitle("Services")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $viewModel.searchText, prompt: "Search")
            .refreshable {
                await viewModel.loadServices()
            }
        }
    }
}

#Preview {
    ServiceListView()
}
