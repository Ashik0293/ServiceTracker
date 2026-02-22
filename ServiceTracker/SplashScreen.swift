//
//  SplashGIF.swift
//  ProductUIDemo
//
//  Created by Mohamed Ashik Buhari on 23/04/25.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(#colorLiteral(red: 0.06551094353, green: 0.09096168727, blue: 0.4252249599, alpha: 1)).opacity(0.5), Color(#colorLiteral(red: 0.06625432521, green: 0.907472074, blue: 0.5388760567, alpha: 1)).opacity(0.3)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)
            VStack {
                Image("Logo")
                    .resizable()
                    .frame(width: 220, height: 120)
                    .clipShape(Circle())
            }
        }
    }
}
