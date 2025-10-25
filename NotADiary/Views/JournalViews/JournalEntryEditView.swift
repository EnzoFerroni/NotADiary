//
//  JournalEntryEdit.swift
//  NotADiary
//
//  Created by Francisco Losada on 09/10/25.
//
// TODO: ARRUMAR PICKERRRR
import SwiftUI

struct JournalEntryEdit: View {
    @Binding var isEdit: Bool
    
    @Environment(CloudKitViewModel.self) var ckViewModel: CloudKitViewModel
        
    @State var title: String = ""
    @State var text: String = ""
    @State var image: UIImage?
    
    var entry: JournalEntry
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    HStack {
                        Text("Title:")
                            .font(.title)
                            .padding(.horizontal)
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
                    
                    HStack {
                        Text("Photo:")
                            .font(.title)
                            .padding(.horizontal)
                        Spacer()
                    }
                    ForEach(ckViewModel.imagesDictionary[entry.id!]!) { image in
                        NavigationLink {
                            PhotoPickerEditView(image: $image, isEdit: true)
                        } label: {
                            Image(uiImage: image.image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 200, height: 246)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .clipped()
                        }
                        
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
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
                    Text("Save")
                }
            }
        }
    }
}
