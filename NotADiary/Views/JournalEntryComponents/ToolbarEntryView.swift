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
    var text: String
    var image1: UIImage?
    var image2: UIImage?
    var day: Date
    var mood: String
    var title: String
    
    var toolbarConfirmation: String {
        if text.isEmpty || image1 == nil || image2 == nil {
            return "xmark"
        }
        else {
            return "checkmark"
        }
    }
    
    var body: some View {
        Text("")
            .toolbar {
                ToolbarItem (placement: .confirmationAction){
                    Button {
                        if toolbarConfirmation == "checkmark" {
                            entryList.append(JournalEntry(title: title, text: text, image1: image1!, image2: image2!, date: day, mood: mood))
                            dismiss()
                        }
                        else {
                            dismiss()
                        }
                    } label: {
                        Image(systemName: toolbarConfirmation)
                    }
                    .buttonStyle(.bordered)
                }
            }
    }
}

//#Preview {
//    ToolbarEntryView()
//}
