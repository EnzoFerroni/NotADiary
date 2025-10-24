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
import HealthKit
import MusicKit

struct JournalCreateEntryView: View {
    @State var text: String = ""
    @State var day: Date = Date()
    @State var userValence: Double = -0.96
    @State var title: String = ""
    @Binding var entryList: [JournalEntry]
    @State var whereToSave: Bool = false
    @State var userLabel: HKStateOfMind.Label = HKStateOfMind.Label.angry
    @State var userAssociation: HKStateOfMind.Association = HKStateOfMind.Association.community
    @State var userLabelString: String = ""
    @State var userAssociationString: String = ""
    @State var images: [UIImage] = []
    @State var songID: String = ""
    
    @State var viewModel = MusicPlayerViewModel()
    
    let associationsStrings = ["Community","Current Events","Dating","Education","Family","Fitness","Friends","Health","Hobbies","Identity","Money","Partner","Self Care","Spirituality","Tasks","Travel","Weather","Work"]
    
    let labelsStrings = ["Amazed","Amused","Angry","Annoyed","Anxious","Ashamed","Brave","Calm","Confident","Content","Disappointed","Discouraged","Disgusted","Drained","Embarrassed","Excited","Frustrated","Grateful","Guilty","Hopeful","Hopeless","Indifferent","Irritated","Jealous","Joyful","Lonely","Overwhelmed","Passionate","Peaceful","Proud","Relieved","Sad","Satisfied","Scared","Stressed","Surprised","Worried"]
    
    
    @State var wasClicked: Bool = false
    
    @Environment(CloudKitViewModel.self) var ckViewModel: CloudKitViewModel

    @State private var loadedSong: Song?
    
    var moodFace: String {
        switch userValence {
        case -1 ... -0.74:
            return "😢"
            
        case -0.75 ... -0.51:
            return "☹️"
            
        case -0.50 ... -0.26:
            return "🙁"
            
        case -0.25 ... 0.24:
            return "😑"
            
        case 0.25 ... 0.49:
            return "🙂"
            
        case 0.5 ... 0.74:
            return "😊"
            
        case 0.75 ... 1.0:
            return "😃"
        default:
            return "😑"
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    HStack {
                        Text("Title:")
                            .font(.title)
                            .padding(.horizontal)
                            .lineLimit(1)
                        Spacer()
                    }
                    TextField("Write here...", text: $title, axis: .vertical)
                        .padding(.horizontal)

                    HStack {
                        Text("Text:")
                            .font(.title)
                            .padding(.horizontal)
                        Spacer()
                    }
                    TextField("Write here...", text: $text, axis: .vertical)
                        .padding(.horizontal)
                    
                    Text("Como você está se sentindo?")
                        .bold()
                        .font(.title2)
                    HStack {
                        Button {
                            whereToSave.toggle()
                        } label: {
                            if !whereToSave {
                                Label("Salvar pelo app!",systemImage: "theatermasks.fill")
                            }
                            else {
                                Image(systemName:"theatermasks")
                            }
                        }
                        .buttonStyle(.bordered)
                        .background(whereToSave ? .white : .cyan)
                        .clipShape(RoundedRectangle(cornerRadius: 90))
                        Spacer()
                        Button{
                            whereToSave.toggle()
                        } label: {
                            if whereToSave {
                                Label("Salvar pelo healthKit",systemImage: "heart.fill")
                            }
                            else {
                                Image(systemName:"heart")
                            }
                        }
                        .buttonStyle(.bordered)
                        .background(whereToSave ? .cyan : .white)
                        .clipShape(RoundedRectangle(cornerRadius: 90))
                    }
                    .font(.title3)
                    .foregroundStyle(.white)
                    .padding(.horizontal)
                    //valencia por meio de slider
                    Text(moodFace)
                        .font(.largeTitle)
                    Slider(value: $userValence, in: -1...1){}
                        .padding(.horizontal)
                    //label - a emocao propriamente dita
                    HStack{
                        Text("Como você está se sentindo?")
                        Spacer()
                        //Resolver
                        Picker("", selection: $userLabelString){
                            ForEach(labelsStrings, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                    .padding(.horizontal)
                    HStack{
                        Text("Ao que o sentimento está associado? ")
                        Spacer()
                        //Resolver
                        Picker("", selection: $userAssociationString){
                            ForEach(associationsStrings, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                    .padding(.horizontal)
                    //endDate picker
                    DatePicker("", selection: $day, displayedComponents: .init(arrayLiteral: .date))
                        .padding(.horizontal)
                    
                    ForEach (images, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 240.0, height: 236)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .scaledToFill()
                            .clipped()
                        
                    }
                    if songID != "", let _loadedSong = loadedSong {
                        SongRow(song: _loadedSong, hapticsManager: viewModel.hapticsManager, viewModel: $viewModel) {
                            Task {
                                await viewModel.togglePlayPause()
                            }
                        }
                    }
                }
                .onChange(of: userLabelString) { oldValue, newValue in
                    userLabel = HKStateOfMindParseFunctions.shared.labelStringToHKStateOfMind(string: userLabelString)
                }
                .onChange(of: userAssociationString) { oldValue, newValue in
                    userAssociation = HKStateOfMindParseFunctions.shared.associationStringToHKStateOfMind(string: userAssociationString)
                }
                
                ToolbarEntryView(entryList: $entryList, images: $images, song: $songID, text: text, day: day, mood: 0, title: title, userValence: userValence, whereToSave: whereToSave, userLabel: userLabel, userAssociation: userAssociation)
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
}

//#Preview {
//    JournalEntryView()
//}

//TODO: Fazer dados mocados para preview
