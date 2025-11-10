//
//  JournalEntryView.swift
//  NotADiary
//
//  Created by Francisco Losada on 08/10/25.
//
//TODO: BOTOES
//TODO: RAW VALUE NO FOREACH

import SwiftUI
import PhotosUI
import MusicKit

struct JournalCreateEntryView: View {
    @State var text: String = ""
    @State var day: Date = Date()
    @State var title: String = ""
    @Binding var entryList: [JournalEntry]
    @State var whereToSave: Bool = false
    @State var images: [UIImage] = []
    @State var songID: String = ""
    @State var viewModel = MusicPlayerViewModel()
    @State var mascotMood: Int = 0
        
    @FocusState var isKeyboardActive: Bool
    
    let associationsStrings = ["Community","Current Events","Dating","Education","Family","Fitness","Friends","Health","Hobbies","Identity","Money","Partner","Self Care","Spirituality","Tasks","Travel","Weather","Work"]
    
    let labelsStrings = ["Amazed","Amused","Angry","Annoyed","Anxious","Ashamed","Brave","Calm","Confident","Content","Disappointed","Discouraged","Disgusted","Drained","Embarrassed","Excited","Frustrated","Grateful","Guilty","Hopeful","Hopeless","Indifferent","Irritated","Jealous","Joyful","Lonely","Overwhelmed","Passionate","Peaceful","Proud","Relieved","Sad","Satisfied","Scared","Stressed","Surprised","Worried"]
    
    
    @State var wasClicked: Bool = false
    
    @Environment(CloudKitViewModel.self) var ckViewModel: CloudKitViewModel
    
    @State private var loadedSong: Song?
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea()

                ScrollView {
                    VStack {
                        //MARK: Date
                        HStack {
                            Text("\(day, format: .dateTime.day().month())")
                                .foregroundStyle(.black)
                                .font(.title)
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        Divider()
                        
                        //MARK: Title
                        TextField("", text: $title, prompt: Text("Escreva o título...").foregroundColor(.gray), axis: .vertical)
                            .focused($isKeyboardActive)
                            .padding(.vertical)
                            .foregroundStyle(.black)
                        Divider()
                        
                        //MARK: Text
                        TextField("", text: $text, prompt: Text("Escreva o texto...").foregroundColor(.gray), axis: .vertical)
                            .focused($isKeyboardActive)
                            .padding(.vertical)
                            .foregroundStyle(.black)

                        Divider()
                        
                        //MARK: Feeling
                        HStack {
                            Text("Como você está se sentindo?")
                                .font(.title2)
                                .foregroundStyle(.black)
                                .bold()
                            Spacer()
                        }
                        
                        MascotGridView(mascotMood: $mascotMood)
                    }
                    
                    //MARK: Music
                    if songID != "", let _loadedSong = loadedSong {
                        SongRow(isEdit: true, song: _loadedSong, hapticsManager: viewModel.hapticsManager, viewModel: $viewModel) {
                            Task {
                                await viewModel.togglePlayPause()
                            }
                        }
                        .background(.white.opacity(0.7))
                        .frame(width: 365, height: 71)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                    }
                    
                    //MARK: Images
                    ForEach (images, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 240.0, height: 236)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .scaledToFill()
                            .clipped()
                    }
                    ToolbarEntryView(entryList: $entryList, images: $images, song: $songID, loadedSong: $loadedSong, text: text, day: day, mood: mascotMood, title: title, whereToSave: whereToSave)
                }
                .padding(.horizontal)
            }
        }
        .scrollDismissesKeyboard(.immediately)
        .refreshable {
            Task {
                if songID != "" {
                    loadedSong = await viewModel.fetchSongById(songID)
                }
            }
        }
    }
}
