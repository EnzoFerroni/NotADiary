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
    @State var x: CGSize = CGSize(width: 0, height: 0)
    
    @State var mViewModel = MascotViewModel()
    @State var moodValue: Int?
    @State var mood: MascotMood?
    @State var moodImage: String?
    @State var moodColor: Color = .gray
    @State var moodMessage: String?
    
    @Binding var toogleSheet: Bool
    
    
    var body: some View {
        VStack {
            Text(moodMessage ?? "")
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .foregroundStyle(.text)
                .padding(.bottom, 64)
            
            ZStack {
                Circle()
                    .fill(moodColor.opacity(0.2))
                    .frame(width: 328)
                
                Button {
                    toogleSheet.toggle()
                } label : {
                    ZStack {
                        Image(moodImage ?? "")
                            .resizable()
                            .frame(width: 328, height: 328)
                            .overlay(
                                ZStack {
                                    Circle()
                                        .fill(moodColor)
                                        .stroke(.black, style: .init(lineWidth: 2))
                                        .frame(width: 40)
                                    Image(systemName: "plus")
                                        .foregroundStyle(.black)
                                        .padding()
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                }
                                    .padding(.top, 270)
                                    .padding(.leading, 170)
                            )
                    }
                    .offset(CGSize(width: x.width, height: x.height - 5))
                    .animation(.smooth(duration: 3).repeatForever(autoreverses: true).delay(0), value: x)
                }
                .buttonStyle(.plain)
                .onAppear {
                    x.height = -5
                    x.height += 10
                }
            }
            
            Text("Vamos criar uma memória nova?")
                .foregroundStyle(.black)
                .font(.body)
                .fontWeight(.semibold)
                .padding(.top, 12)
                .padding(.bottom, 89)
        }
        .onAppear() {
            Task {
                moodValue = await mViewModel.avarageMood(viewModel: ckViewModel)
                mood = mViewModel.moodToMascot(value: moodValue!)
                moodColor = mViewModel.mascorMoodColor(mood: mood!)
                moodImage = mViewModel.mascotMoodImage(mood: mood!)
                moodMessage = mViewModel.mascotMessage(mood: mood!)
            }
        }
    }
}
