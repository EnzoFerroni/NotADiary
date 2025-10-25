//
//  AddButtonView.swift
//  NotADiary
//
//  Created by Francisco Losada on 24/10/25.
//

import SwiftUI

struct AddButtonView: View {
    @Binding var toggleSheet: Bool
    @State var animationAmount: Double = 0.0
    
    private let gradient = AngularGradient(
        gradient: Gradient(colors: [Color.accent, .white]),
        center: .center,
        startAngle: .degrees(270),
        endAngle: .degrees(0))
    
    
    var body: some View {
        Button {
            toggleSheet.toggle()
        } label: {
            ZStack {
                Circle()
                    .fill(.clear)
                    .stroke(gradient, style: StrokeStyle(lineWidth: 15, lineCap: .round))
                    .frame(width: 120)
                    .rotationEffect(.degrees(animationAmount))
                    .onAppear {
                        withAnimation(.linear(duration: 10).repeatForever(autoreverses: false)) {
                            animationAmount += 360
                        }
                    }
                
                Image(systemName: "plus")
                    .font(.largeTitle)
                    .padding(.vertical, 280)
                    .foregroundStyle(.black)
            }
        }
    }
}
