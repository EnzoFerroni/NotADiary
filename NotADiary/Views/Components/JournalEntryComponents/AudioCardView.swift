//
//  AudioCard.swift
//  NotADiary
//
//  Created by Pedro Augusto on 08/11/25.
//

import SwiftUI

struct AudioCardView: View {
    var title: String
    var subtitle: String
    var image: String
    @Binding var isPlaying: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .frame(width: 310,height: 80)
                .background(.ultraThinMaterial)
                .overlay(
                    HStack(spacing: 12) {
                        Image(image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 45, height: 45)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text(title)
                                .font(.headline)
                            Text(subtitle)
                                .font(.caption)
                                .opacity(0.7)
                        }
                        
                        Spacer()
                        
                        Button {
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                                isPlaying.toggle()
                            }
                        } label: {
                            Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                                .font(.title3)
                                .padding(10)
                                .background(.ultraThinMaterial, in: Circle())
                                .shadow(radius: 2)
                        }
                    }
                        .padding(12)
                        .padding(.horizontal)
                )
        }
    }
}


#Preview {
    @Previewable @State var isPlaying: Bool = false
    
    AudioCardView(title: "Dont", subtitle: "Queen", image: "amiguinho", isPlaying: $isPlaying)
}
