//
//  JournalEntryView.swift
//  NotADiary
//
//  Created by Francisco Losada on 08/10/25.
//

import SwiftUI
import PhotosUI

struct JournalEntryView: View {
    @State var text: String = ""
    @State var image1: UIImage?
    @State var day: Date = Date()
    @State var mood: Double = 0
    @State var title: String = ""
    @Binding var entryList: [JournalEntry]
    
    var moodFace: String {
        switch mood {
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
                    
                    Text(moodFace)
                        .font(.largeTitle)
                    Slider(value: $mood, in: 0...4, step: 1){}
                        .padding(.horizontal)
                    
                    DatePicker("", selection: $day, displayedComponents: .init(arrayLiteral: .date))
                        .padding(.horizontal)
                    
                    HStack {
                        Text("Text:")
                            .font(.title)
                            .padding(.horizontal)
                        Spacer()
                    }
                    TextField("Write here...", text: $text, axis: .vertical)
                        .padding(.horizontal)
                    
                    HStack {
                        Text("Photo:")
                            .font(.title)
                            .padding(.horizontal)
                        Spacer()
                    }
                    if image1 != nil{
                        Image(uiImage: image1!)
                            .resizable()
                            .frame(width: 240.0, height: 236)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .scaledToFill()
                    }
                    //PhotoPickerView(image: $image1)
                }
                ToolbarEntryView(entryList: $entryList, image1: $image1, text: text, day: day, mood: moodFace, title: title)
            }
        }
    }
}

//#Preview {
//    JournalEntryView()
//}

//TODO: Fazer dados mocados para preview
