//
//  SongRow.swift
//  NotADiary
//
//  Created by Enzo Ferroni on 17/10/25.
//

import SwiftUI
import MusicKit
import MediaAccessibility

struct SongRow: View {
    let song: Song
    let hapticsManager: MusicHapticsManager
        
    @Binding var viewModel: MusicPlayerViewModel
    
    let onTap: () -> Void
    
    @State private var hasHaptics: Bool = false
    @State private var isChecking: Bool = true
    @State private var isSelected: Bool = false
    
    
    var body: some View {
        Button(action: {
            print("Song ID: \(song.id)")
            onTap()
        }) {
            HStack {
                ZStack {
                    AsyncImage(url: song.artwork?.url(width: 50, height: 50)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 50, height: 50)
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        case .failure(_):
                            ZStack {
                                Color.gray
                                Image(systemName: "music.note")
                                    .foregroundColor(.black)
                            }
                        @unknown default:
                            Color.gray
                        }
                    }
                    .frame(width: 50, height: 50)
                    .cornerRadius(8)
                    
                    Image(systemName: viewModel.isPlaying && viewModel.currentSong?.id == song.id ? "pause.circle.fill" : "play.circle.fill")
                        .font(.title)
                        .foregroundStyle(.white)
                }
                
                VStack(alignment: .leading) {
                    Text(song.title)
                        .foregroundColor(.black)
                    Text(song.artistName)
                        .foregroundColor(.gray)
                        .font(.caption)
                }
                
                Spacer()
                
                if isChecking {
                    ProgressView()
                        .scaleEffect(0.7)
                        .tint(.gray)
                } else if hasHaptics {
                    Image(systemName: "waveform")
                        .foregroundColor(.green)
                }
            }
            .padding()
            .background(viewModel.isPlaying && viewModel.currentSong?.id == song.id ? Color.white.opacity(1) : Color.white.opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(radius: 2, x: 2, y: 3)

        }
        .task {
            await checkHaptics()
        }
    }
    
    private func checkHaptics() async {
        guard let isrc = song.isrc else {
            isChecking = false
            return
        }
        
        await withCheckedContinuation { continuation in
            MAMusicHapticsManager.shared.checkHapticTrackAvailabilityForMedia(
                matchingCode: isrc
            ) { available in
                Task { @MainActor in
                    self.hasHaptics = available
                    self.isChecking = false
                    continuation.resume()
                }
            }
        }
    }
}
