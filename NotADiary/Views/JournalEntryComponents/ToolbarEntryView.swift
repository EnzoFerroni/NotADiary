//
//  ToolbarEntryView.swift
//  NotADiary
//
//  Created by Francisco Losada on 08/10/25.
//

import SwiftUI

struct ToolbarEntryView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var entryList: [JournalEntry]
    @Binding var image1: UIImage?
    
    let imagePlaceholder: UIImage = UIImage(named: "amiguinho")!

    var text: String
    var day: Date
    var mood: String
    var title: String
        
    var body: some View {
        NavigationStack {
            Text("")
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Button {
                            print("1")
                        } label: {
                            Image(systemName: "waveform.path.badge.plus")
                        }
                    }
                    ToolbarItem(placement: .bottomBar) {
                        Button {
                            print("2")
                        } label: {
                            Image(systemName: "music.note")
                        }
                    }
                    ToolbarItem(placement: .bottomBar) {
                        PhotoPickerView(image: $image1, isEdit: false)
                        Image(systemName: "photo.badge.plus.fill")
                    }
                    ToolbarItem(placement: .bottomBar) {
                        Button {
                            print("4")
                        } label: {
                            Image(systemName: "waveform")
                        }
                    }
                    ToolbarSpacer(.fixed, placement: .bottomBar)
                    
                    ToolbarItem (placement: .bottomBar){
                        Button {
                            entryList.append(JournalEntry(title: title, text: text, image1: image1 ?? imagePlaceholder, date: day, mood: mood))
                            dismiss()
                        } label: {
                            Image(systemName: "checkmark")
                        }
                    }
                    ToolbarSpacer(.fixed, placement: .bottomBar)
                    ToolbarItem (placement: .bottomBar) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                        }
                    }
                }
        }
    }
}

//#Preview {
//    ToolbarEntryView()
//}
