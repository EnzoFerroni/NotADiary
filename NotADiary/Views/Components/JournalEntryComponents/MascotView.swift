//
//  AddButtonView.swift
//  NotADiary
//
//  Created by Francisco Losada on 24/10/25.
//

import SwiftUI

struct MascotView: View {
    @State var animationAmount: Double = 0.0
    
    private let gradient = LinearGradient(
        gradient: Gradient(colors: [Color.happinessBackground, .background]),
        startPoint: .top,
        endPoint: .bottom
        )
    
    var body: some View {
        VStack {
            Text("Este mês você se sentiu feliz com mais frequência, vamos continuar assim!")
                .font(.body)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            ZStack {
                Circle()
                    .fill(gradient)
                    .frame(width: 220)
                    .rotationEffect(.degrees(animationAmount))
                    .onAppear {
                        withAnimation(.linear(duration: 20).repeatForever(autoreverses: false)) {
                            animationAmount = 0
                            animationAmount += 360
                        }
                    }
                Image("happiness")
                    .resizable()
                    .frame(width: 220, height: 220)
//                    .rotationEffect(.degrees(animationAmount))
//                    .onAppear {
//                        withAnimation(.linear(duration: 10).repeatForever(autoreverses: false)) {
//                            animationAmount = 0
//                            animationAmount += 360
//                        }
//                    }
            }
        }
        .padding(.vertical, 200)

    }
}
