//
//  AddButtonView.swift
//  NotADiary
//
//  Created by Francisco Losada on 24/10/25.
//

import SwiftUI

struct MascotView: View {
    @Environment(CloudKitViewModel.self) var ckViewModel: CloudKitViewModel

    @State var animationAmount: Double = 0.0
    
    @State var mViewModel = MascotViewModel()
    @State var moodValue: Int?
    @State var mood: MascotMood?
    @State var moodImage: String?
    @State var moodColor: Color = .gray
    
    var body: some View {
        let gradient = LinearGradient(
            gradient: Gradient(colors: [moodColor, .background]),
            startPoint: .top,
            endPoint: .bottom
            )
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
                Image(moodImage ?? "")
                    .resizable()
                    .frame(width: 220, height: 220)
            }
        }
        .onAppear() {
            Task {
                moodValue = await mViewModel.avarageMood(viewModel: ckViewModel)
                mood = mViewModel.moodToMascot(value: moodValue!)
                moodColor = mViewModel.mascorMoodColor(mood: mood!)
                moodImage = mViewModel.mascotMoodImage(mood: mood!)
            }
        }
        .padding(.vertical, 200)
    }
}
