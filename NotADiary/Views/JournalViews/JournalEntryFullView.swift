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
    
    @State var mpViewModel = MusicPlayerViewModel()
    @State var song: Song?
    
    var body: some View {
        NavigationStack {
            if isEdit {
                JournalEntryEdit(isEdit: $isEdit, entry: entry)
            }
            else {
                ScrollView {
                    VStack {
                        HStack {
                            Text(entry.title)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        HStack {
                            Text("\(entry.date, format: .dateTime.day().month().year())")
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundStyle(.subheadline)
                            Spacer()
                        }
                        Divider()
                        HStack {
                            Text(entry.text)
                            Spacer()
                        }
                        
                        ZStack {
                            //Placeholder for Music Card
                            RoundedRectangle(cornerRadius: 15)
                                .frame(width: 365, height: 71)
                                .foregroundStyle(.white)
                            if song != nil {
                                SongRow(isEdit: true, song: song!, hapticsManager: mpViewModel.hapticsManager, viewModel: $mpViewModel) {
                                    Task {
                                        await mpViewModel.togglePlayPause()
                                    }
                                }
                                .background(.white.opacity(0.7))
                                .frame(width: 365, height: 71)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                
                            }
                        }
                        
                        ImagesGridView(entry: entry)
                        
                    }
                    .padding(.horizontal)
                    //por enquanto
                    ShareLink(item: card, preview: SharePreview("\(entry.title)"))
                    
                    ToolbarJournalEntryFullView(isEdit: $isEdit, entry: entry)
                }
                
                .onAppear() {
                    card = FuncsCardModel.shared.entryToCard(entry: entry, imagesDictionary: ckViewModel.imagesDictionary)
                    Task {
                        do {
                            try await ckViewModel.fetchImageByDiaryEntry(entry: entry)
                            song = try await mpViewModel.fetchSongById(entry.songID)
                            
                        }
                        catch {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
        }
        .background { Color.background.ignoresSafeArea()}
    }
}
