//
//  JournalEntryEdit.swift
//  NotADiary
//
//  Created by Francisco Losada on 09/10/25.
//
// TODO: ARRUMAR PICKER
import SwiftUI
import PhotosUI
import MusicKit

struct JournalEntryEdit: View {
    @Binding var isEdit: Bool
    
    @Environment(CloudKitViewModel.self) var ckViewModel: CloudKitViewModel
    
    @State var entry: JournalEntry
    @State var viewModel = MusicPlayerViewModel()
    @State private var loadedSong: Song?
    @State var presentMusicSheet: Bool = false
    
    @FocusState var isKeyboardActive: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea()
                ScrollView {
                    VStack {
                        //MARK: Date
                        HStack {
                            Text("\(entry.date, format: .dateTime.day().month())")
                                .foregroundStyle(.black)
                                .font(.title)
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        Divider()
                        
                        //MARK: Title
                        TextField("", text: $entry.title, prompt: Text("Write your title here...").foregroundColor(.gray), axis: .vertical)
                            .focused($isKeyboardActive)
                            .padding(.vertical)
                            .foregroundStyle(.black)
                        Divider()
                        
                        
                        //MARK: Text
                        TextField("", text: $entry.text, prompt: Text("Write your text here...").foregroundColor(.gray), axis: .vertical)
                            .focused($isKeyboardActive)
                            .padding(.vertical)
                            .foregroundStyle(.black)
                        Divider()
                        
                        //MARK: Feeling
                        HStack {
                            Text("Como você estava se sentindo?")
                                .foregroundStyle(.black)
                                .bold()
                                .font(.title2)
                            Spacer()
                        }
                        
                        Label("Salvar pelo app!",systemImage: "theatermasks.fill")
                            .foregroundStyle(.white)
                            .padding()
                            .background(Color.accentColor)
                            .clipShape(RoundedRectangle(cornerRadius: 90))
                            .font(.title3)
                        
                        MascotGridView(mascotMood: $entry.mood)
                        
                        if entry.songID != "", let _loadedSong = loadedSong {
                            SongRow(song: _loadedSong, hapticsManager: viewModel.hapticsManager, viewModel: $viewModel) {
                                Task {
                                    await viewModel.togglePlayPause()
                                }
                            }
                            .background(.white.opacity(0.7))
                            .frame(width: 365, height: 71)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .onAppear() {
                                Task {
                                    if entry.songID != "" {
                                        loadedSong = await viewModel.fetchSongById(entry.songID)
                                    }
                                    
                                }
                            }
                        }
                        HStack {
                            if ckViewModel.imagesDictionary[entry.id!]?.first?.image != nil {
                                VStack {
                                    ForEach(Array(ckViewModel.imagesDictionary[entry.id!]!.enumerated()), id: \.offset) { index, image in
                                        if index % 5 == 0 || index % 5 == 3 {
                                            PhotoPickerEditView(image: image, isSmall: false)
                                                .contextMenu {
                                                    Button(role: .destructive) {
                                                        Task {
                                                            await ckViewModel.removeImageEntry(image: image)
                                                        }
                                                    } label: {
                                                        Label("Deletar", systemImage: "trash")
                                                    }
                                                }
                                        }
                                    }
                                    Spacer()
                                }
                                VStack {
                                    ForEach(Array(ckViewModel.imagesDictionary[entry.id!]!.enumerated()), id: \.offset) { index, image in
                                        if index % 5 == 1 || index % 5 == 2 || index % 5 == 4 {
                                            PhotoPickerEditView(image: image, isSmall: true)
                                                .contextMenu {
                                                    Button(role: .destructive) {
                                                        Task {
                                                            await ckViewModel.removeImageEntry(image: image)
                                                        }
                                                    } label: {
                                                        Label("Deletar", systemImage: "trash")
                                                    }
                                                }
                                        }
                                    }
                                    Spacer()
                                }
                            }
                        }
                    }
                    .toolbar {
                        ToolbarItem(placement: .bottomBar) {
                            Button {
                                presentMusicSheet.toggle()
                            } label: {
                                Image(systemName: "music.note")
                            }
                            .sheet(isPresented: $presentMusicSheet) {
                                MusicView(songSelectedId: $entry.songID, loadedSong: $loadedSong)
                            }
                        }
                        ToolbarItem(placement: .bottomBar) {
                            PhotoPickerEmptyEditView(entry: entry)
                            Image(systemName: "photo.badge.plus.fill")
                        }
                        ToolbarSpacer(.flexible, placement: .bottomBar)
                        ToolbarItem(placement: .bottomBar) {
                            Button {
                                isEdit.toggle()
                                Task {
                                    do {
                                        try await ckViewModel.editDiaryEntry(entry: entry)
                                    }
                                    catch {
                                        print(error.localizedDescription)
                                    }
                                }
                            } label: {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
            .onAppear() {
                Task {
                    do {
                        try await ckViewModel.fetchImageByDiaryEntry(entry: entry)
                        if entry.songID != "" {
                            loadedSong = await viewModel.fetchSongById(entry.songID)
                        }
                    }
                    catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
        .scrollDismissesKeyboard(.immediately)
        .background { Color.background.ignoresSafeArea()}
        .refreshable {
            Task {
                if entry.songID != "" {
                    loadedSong = await viewModel.fetchSongById(entry.songID)
                }
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
