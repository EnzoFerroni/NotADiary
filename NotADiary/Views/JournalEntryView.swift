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
    @Binding var entryList: [JournalEntry]
    
    var body: some View {
        NavigationStack {
            VStack {
                DatePicker("", selection: $day, displayedComponents: .init(arrayLiteral: .date))
                HStack {
                    Text("Texto:")
                    Spacer()
                }
                TextField("O que você está pensando?", text: $text, axis: .vertical)
                    
                PhotoPickerView(image: $image1)
                PhotoPickerView(image: $image2)
            }
            ToolbarEntryView(entryList: $entryList, text: text, image1: image1, image2: image2, day: day)
        }
    }
}

//#Preview {
//    JournalEntryView()
//}

//TODO: Fazer dados mocados para preview
