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

struct JournalEntryView: View {
    @State var text: String = ""
    @State var image1: UIImage?
    @State var day: Date = Date()
    @State var userValence: Double = 0
    @State var title: String = ""
    @Binding var entryList: [JournalEntry]
    @State var whereToSave: Bool = false
    @State var userLabel: HKStateOfMind.Label = HKStateOfMind.Label.angry
    @State var userAssociation: HKStateOfMind.Association = HKStateOfMind.Association.community
    
    
    @State var wasClicked: Bool = false
    
    @Environment(CloudKitViewModel.self) var ckViewModel: CloudKitViewModel
    
    var moodFace: String {
        switch userValence {
        case 0:
            return "☹️"
        case 1:
            return "🙁"
        case 2:
            return "😑"
        case 3:
            return "🙂"
        case 4:
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
                    HStack{
                        Button{
                            whereToSave.toggle()
                        }label:{
                            if (!whereToSave){
                                Label("Salvar pelo app!",systemImage: "theatermasks.fill")
                                    .buttonStyle(.bordered)
                            }else{
                                Image(systemName:"theatermasks")
                                    .buttonStyle(.bordered)
                            }
                        }
                        
                        Button{
                            whereToSave.toggle()
                        }label:{
                            if(whereToSave){
                                Label("Salvar pelo healthKit",systemImage: "heart.fill")
                                    .buttonStyle(.bordered)
                            }else{
                                Image(systemName:"heart")
                                    .buttonStyle(.bordered)
                            }
                        }
                    }
                    //valencia por meio de slider
                    Text("\(userValence)")
                        .font(.largeTitle)
                    Slider(value: $userValence, in: -1...1, step: 0.28){}
                        .padding(.horizontal)
                    //label - a emocao propriamente dita
                    Picker("Como você descreveria forma com que está se sentindo?", selection: $userLabel){
                        //                        Estudar logica do picker
                        //                        ForEach(HKStateOfMind.Association.community,id: \.self) {
                        //                            Text($0)
                        //                        }
                        //                    }
                        //Association
                        var angry = HKStateOfMind.Label.angry
                        Text("\(angry)").tag(0)
                    }
                        Picker("Por favor escolha a que o seu sentimento está associado.", selection: $userAssociation){
                        //                        Estudar logica do picker
                        //                        ForEach(HKStateOfMind.Association.community,id: \.self) {
                        //                            Text($0)
                        //                        }
                        //                    }
                        var education = HKStateOfMind.Association.education
                            Text("\(education)").tag(0)
                    }
                        //endDate picker
                        DatePicker("", selection: $day, displayedComponents: .init(arrayLiteral: .date))
                            .padding(.horizontal)
                        
                        if image1 != nil{
                            Image(uiImage: image1!)
                                .resizable()
                                .frame(width: 240.0, height: 236)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .scaledToFill()
                        }
                    }
                ToolbarEntryView(entryList: $entryList, image1: $image1, text: text, day: day, title: title, userValence: userValence,whereToSave: whereToSave, userLabel: userLabel, userAssociation: userAssociation)
                }
            }
        }
    }
    
    //#Preview {
    //    JournalEntryView()
    //}
    
    //TODO: Fazer dados mocados para preview
