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
    //@State var userValence: Double = 0.0
    @State var title: String = ""
    @Binding var entryList: [JournalEntry]
    @State var whereToSave: Bool = false
//    @State var userLabel: HKStateOfMind.Label = HKStateOfMind.Label.angry
//    @State var userAssociation: HKStateOfMind.Association = HKStateOfMind.Association.community
//    @State var userLabelString: String = ""
//    @State var userAssociationString: String = ""
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
    
//    var moodFace: String {
//        switch userValence {
//        case -1 ... -0.74:
//            return "😢"
//            
//        case -0.75 ... -0.51:
//            return "☹️"
//            
//        case -0.50 ... -0.26:
//            return "🙁"
//            
//        case -0.25 ... 0.24:
//            return "😑"
//            
//        case 0.25 ... 0.49:
//            return "🙂"
//            
//        case 0.5 ... 0.74:
//            return "😊"
//            
//        case 0.75 ... 1.0:
//            return "😃"
//        default:
//            return "😑"
//        }
//    }
    
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
                        TextField("", text: $title, prompt: Text("Write your title here...").foregroundColor(.gray), axis: .vertical)
                            .focused($isKeyboardActive)
                            .padding(.vertical)
                        Divider()
                        
                        //MARK: Text
                        TextField("", text: $text, prompt: Text("Write your text here...").foregroundColor(.gray), axis: .vertical)
                            .focused($isKeyboardActive)
                            .padding(.vertical)
                        Divider()
                        
                        //MARK: Feeling
                        HStack {
                            Text("Como você está se sentindo?")
                                .foregroundStyle(.black)
                                .bold()
                                .font(.title2)
                            Spacer()
                        }
                        
//                        HStack {
//                            Button {
//                                withAnimation(.default) {
//                                    whereToSave.toggle()
//                                }
//                            } label: {
//                                if !whereToSave {
//                                    Label("Definir pelo app!",systemImage: "theatermasks.fill")
//                                        .foregroundStyle(.white)
//                                }
//                                else {
//                                    Image(systemName:"theatermasks")
//                                        .foregroundStyle(.white)
//                                }
//                            }
//                            .buttonStyle(.bordered)
//                            .background(whereToSave ? .white : .accentColor)
//                            .clipShape(RoundedRectangle(cornerRadius: 90))
//                            
//                            Spacer()
//                            
//                            Button {
//                                withAnimation(.default) {
//                                    whereToSave.toggle()
//                                }
//                            } label: {
//                                if whereToSave {
//                                    Label("Salvar pelo healthKit",systemImage: "heart.fill")
//                                        .foregroundStyle(.white)
//                                }
//                                else {
//                                    Image(systemName:"heart")
//                                        .foregroundStyle(.white)
//                                }
//                            }
//                            .buttonStyle(.bordered)
//                            .background(whereToSave ? .cyan : .white)
//                            .clipShape(RoundedRectangle(cornerRadius: 90))
//                        }
//                        .font(.title3)
//                        .foregroundStyle(.white)
//                        .padding(.horizontal)
                        
//                        if whereToSave {
//                            //Valencia por meio de slider
//                            HStack {
//                                Spacer()
//                                Text(moodFace)
//                                    .font(.largeTitle)
//                                Spacer()
//                            }
//                            Slider(value: $userValence, in: -1...1){}
//                            
//                            //Label - emocao propriamente dita
//                            HStack{
//                                Text("Como você está se sentindo?")
//                                Spacer()
//                                //Resolver
//                                Picker("", selection: $userLabelString){
//                                    ForEach(labelsStrings, id: \.self) {
//                                        Text($0)
//                                    }
//                                }
//                            }
//                            //Resolver
//                            HStack{
//                                Text("Ao que o sentimento está associado? ")
//                                Spacer()
//                                Picker("", selection: $userAssociationString){
//                                    ForEach(associationsStrings, id: \.self) {
//                                        Text($0)
//                                    }
//                                }
//                            }
//                        }
                        //else {
                            MascotGridView(mascotMood: $mascotMood)
                        //}
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
//                .onChange(of: userLabelString) { oldValue, newValue in
//                    userLabel = HKStateOfMindParseFunctions.shared.labelStringToHKStateOfMind(string: userLabelString)
//                }
//                .onChange(of: userAssociationString) { oldValue, newValue in
//                    userAssociation = HKStateOfMindParseFunctions.shared.associationStringToHKStateOfMind(string: userAssociationString)
//                }
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
