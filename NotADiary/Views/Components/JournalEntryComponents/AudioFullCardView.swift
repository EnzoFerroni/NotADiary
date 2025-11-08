//
//  AudioFullCardView.swift
//  NotADiary
//
//  Created by Pedro Augusto on 08/11/25.
//

import SwiftUI

struct AudioFullCardView: View {
    @State var viewState: Int = 1
    @State var isPlaying: Bool = false
    
    var body: some View {
        if viewState == 1 {
            HStack {
                AudioCardView(title: "Don't Stop Me Now", subtitle: "Queen", image: "amiguinho", isPlaying: $isPlaying)
                Button {
                    
                } label: {
                    Image(systemName: "waveform")
                    
                }
                
                Button {
                    
                } label: {
                    Image(systemName: "music.note")
                }
            }
        }
    }
}

#Preview {
    AudioFullCardView()
}
