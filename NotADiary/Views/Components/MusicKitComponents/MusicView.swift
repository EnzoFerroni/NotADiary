//
//  MusicView.swift
//  NotADiary
//
//  Created by Enzo Ferroni on 17/10/25.
//

import SwiftUI
import MusicKit

struct MusicView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var viewModel = MusicPlayerViewModel()
    @State private var searchText: String = ""
    @State var isSelected: Bool = false

    @Binding var songSelectedId: String
    @Binding var loadedSong: Song?
                
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea()
                if searchText.isEmpty && songSelectedId.isEmpty {
                    VStack {
                        Image("music")
                            .resizable()
                            .frame(width: 300, height: 300)
                            .scaledToFit()
                        Text("Parece que você ainda não buscou nenhuma música...")
                            .multilineTextAlignment(.center)
                            .font(.title3)
                            .foregroundStyle(.black)
                    }
                }
                if viewModel.isAuthorized {
                    VStack(spacing: 0) {
                        ScrollView (showsIndicators: false){
                            LazyVStack(spacing: 10) {
                                ForEach(viewModel.songs) { song in
                                    SongRow(song: song, hapticsManager: viewModel.hapticsManager, viewModel: $viewModel) {
                                        Task {
                                            await viewModel.playSong(song)
                                        }
                                        songSelectedId = song.id.rawValue
                                    }
                                }
                            }
                            .padding()
                            .padding(.bottom, 100)
                        }
                        .searchable(text: $searchText, prompt: "Search music")
                        .onSubmit(of: .search) {
                            Task {
                                await viewModel.searchMusic(term: searchText)
                            }
                        }
                        .onChange(of: searchText) { oldValue, newValue in
                            if !newValue.isEmpty && newValue.count > 2 {
                                Task {
                                    await viewModel.searchMusic(term: newValue)
                                }
                            }
                        }
                        Spacer()
                    }
                    
                    if let currentSong = viewModel.currentSong {
                        VStack {
                            Spacer()
                            HStack {
                                AsyncImage(url: currentSong.artwork?.url(width: 55, height: 55)) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                            .frame(width: 55, height: 55)
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
                                .frame(width: 55, height: 55)
                                .cornerRadius(8)
                                
                                VStack (alignment: .leading){
                                    Text(currentSong.title)
                                        .foregroundColor(.black)
                                        .font(.body)
                                        .fontWeight(.semibold)
                                        .lineLimit(1)
                                    Text(currentSong.artistName)
                                        .foregroundColor(.black)
                                        .font(.subheadline)
                                        .lineLimit(1)
                                    
                                    if viewModel.hapticsManager.isHapticsActive {
                                        if viewModel.hapticsManager.isHapticsAvailable {
                                            HStack {
                                                Image(systemName: "waveform")
                                                    .foregroundColor(.green)
                                                Text("Haptics ON")
                                                    .foregroundColor(.green)
                                                    .font(.caption)
                                            }
                                        } else {
                                            Text("No haptic track")
                                                .foregroundColor(.orange)
                                                .font(.caption)
                                        }
                                    }
                                }
                                Spacer()

                                Button {
                                    Task {
                                        await viewModel.togglePlayPause()
                                    }
                                } label: {
                                    Image(systemName: viewModel.isPlaying ? "pause.circle" : "play.circle")
                                        .font(.system(size: 48))
                                        .foregroundColor(.black)
                                }
                            }
                            .padding()
                            .glassEffect(.clear, in: .capsule)
                            
                        }
                        .padding()
                    }
                }
                else {
                    VStack {
                        ProgressView()
                            .tint(.white)
                            .scaleEffect(1.5)
                        
                        Text("Loading...")
                            .foregroundColor(.white)
                            .padding()
                    }
                }
            }
            .task {
                await viewModel.requestMusicAuthorization()
                if viewModel.isAuthorized {
                    await viewModel.searchMusic(term: "")
                }
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        Task {
                            loadedSong = await viewModel.fetchSongById(songSelectedId)
                            dismiss()
                        }
                    } label: {
                        Image(systemName: "checkmark")
                    }
                }
            }
            
        }
    }
}
