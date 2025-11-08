//
//  JournalEntryFullView.swift
//  NotADiary
//
//  Created by Francisco Losada on 09/10/25.
//

import SwiftUI
import MusicKit

struct JournalEntryFullView: View {
    @Environment(CloudKitViewModel.self) var ckViewModel: CloudKitViewModel
    
    @State var entry: JournalEntry
    @State var isEdit: Bool = false
    @State var fullImage: Bool = false
    @State var card: Card = Card(images: [], title: "", text: "", date: Date.now, mood: 0, songID: "", label: "", association: "", valence: 0)
    @State var moodImage: String?
    @State var moodValue: MascotMood?
    
    @State var mpViewModel = MusicPlayerViewModel()
    @State var song: Song?
    
    var mViewModel = MascotViewModel()
    
    var body: some View {
        NavigationStack {
            if isEdit {
                JournalEntryEdit(isEdit: $isEdit, entry: entry)
            }
            else {
                ZStack {
                    ScrollView {
                        VStack {
                            HStack {
                                Text(entry.title)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.black)
                                
                                Spacer()
                            }
                            HStack {
                                Text("\(entry.date, format: .dateTime.day().month().year())")
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                    .foregroundStyle(.subheadline)
                                Spacer()
                            }
                            Image(moodImage ?? "")
                                .resizable()
                                .frame(width: 193, height: 193)
                            HStack {
                                Text(entry.text)
                                    .foregroundStyle(.black)
                                
                                Spacer()
                            }
                            
                            ImagesGridView(entry: entry)
                        }
                        .padding(.horizontal)
                        
                        ToolbarJournalEntryFullView(isEdit: $isEdit, card: card, entry: entry)
                    }
                    
//                    if song != nil {
//                        VStack {
//                            Spacer()
//                            SongAudioHapticsRow(
//                                song: song!,
//                                isPlaying: true,
//                                onPlayPause: {
//                                    Task {
//                                        await mpViewModel.togglePlayPause()
//                                    }
//                                },
//                                showMic: true,
//                                showWaveform: true,
//                                onMic: { print("Mic tapped!") },
//                                onWaveform: { print("Waveform tapped!") }
//                            )
//                            .frame(height: 71)
//                            .clipShape(RoundedRectangle(cornerRadius: 15))
//                            .padding()
//                            .shadow(radius: 8)
//                        }
//                        .edgesIgnoringSafeArea(.bottom)
//                        .transition(.move(edge: .bottom).combined(with: .opacity))
//                        .animation(.spring(), value: song)
//                    }
                }
                
                .onAppear() {
                    card = FuncsCardModel.shared.entryToCard(entry: entry, imagesDictionary: ckViewModel.imagesDictionary)
                    Task {
                        do {
                            try await ckViewModel.fetchImageByDiaryEntry(entry: entry)
                            song = await mpViewModel.fetchSongById(entry.songID)
                        }
                        catch {
                            print(error.localizedDescription)
                        }
                    }
                    moodValue = mViewModel.moodToMascot(value: entry.mood)
                    moodImage = mViewModel.mascotMoodImage(mood: moodValue!)
                }
            }
        }
        .background { Color.background.ignoresSafeArea()}
    }
}
