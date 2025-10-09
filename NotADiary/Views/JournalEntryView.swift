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
    @State var image2: UIImage?
    @State var day: Date = Date()
    @State var mood: Double = 0
    @Binding var entryList: [JournalEntry]
    
    @State var wasClicked: Bool = false
    
    @Environment(CloudKitViewModel.self) var ckViewModel: CloudKitViewModel
    
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
                    PhotoPickerView(image: $image1)
                    PhotoPickerView(image: $image2)
                    
                    Button {
                        ckViewModel.createPreference(name: text)
                    } label: {
                        Text("Confirmar")
                    }
                    .disabled(!wasClicked)
                }
                ToolbarEntryView(entryList: $entryList, text: text, image1: image1, image2: image2, day: day, mood: moodFace)
            }
        }
    }
}

//#Preview {
//    JournalEntryView()
//}

//TODO: Fazer dados mocados para preview
