//
//  JournalEntryFullView.swift
//  NotADiary
//
//  Created by Francisco Losada on 09/10/25.
//

import SwiftUI

struct JournalEntryFullView: View {
    @Environment(CloudKitViewModel.self) var ckViewModel: CloudKitViewModel
    
    @State var entry: JournalEntry
    @State var isEdit: Bool = false
    @State var fullImage: Bool = false
    
    @State var viewModel = MusicPlayerViewModel()
    
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
                        //Placeholder for Music Card -
//                        RoundedRectangle(cornerRadius: 15)
//                            .frame(width: 365, height: 71)
//                            .foregroundStyle(.gray)
                        if entry.songID != "" {
                            SongRow(song: _loadedSong, hapticsManager: viewModel.hapticsManager, viewModel: $viewModel) {
                                Task {
                                    await viewModel.togglePlayPause()
                                }
                            }
                        }
                        
                        ImagesGridView(entry: entry)
                        
                    }
                    .padding(.horizontal)
                    
                    ToolbarJournalEntryFullView(isEdit: $isEdit, entry: entry)
                }
                .onAppear() {
                    Task {
                        do {
                            try await ckViewModel.fetchImageByDiaryEntry(entry: entry)
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
