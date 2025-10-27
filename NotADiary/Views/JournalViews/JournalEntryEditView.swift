//
//  JournalEntryEdit.swift
//  NotADiary
//
//  Created by Francisco Losada on 09/10/25.
//
// TODO: ARRUMAR PICKER
import SwiftUI
import PhotosUI

struct JournalEntryEdit: View {
    @Binding var isEdit: Bool
    
    @Environment(CloudKitViewModel.self) var ckViewModel: CloudKitViewModel
    
    @State var entry: JournalEntry
    
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
                    TextField("Write here...", text: $entry.title, axis: .vertical)
                        .padding(.horizontal)
                    
                    HStack {
                        Text("Text:")
                            .font(.title)
                            .padding(.horizontal)
                        Spacer()
                    }
                    TextField("Write here...", text: $entry.text, axis: .vertical)
                        .padding(.horizontal)
                    
                    HStack {
                        Text("Photo:")
                            .font(.title)
                            .padding(.horizontal)
                        Spacer()
                    }
                    if (ckViewModel.imagesDictionary[entry.id!]?.first?.image) != nil {
                        ForEach(ckViewModel.imagesDictionary[entry.id!]!) { image in
                            PhotoPickerEditView(image: image)
                        }
                    }
                }
            }
            .onAppear() {
                Task {
                    do {
                        try await ckViewModel.fetchImageByDiaryEntry(entry: entry)
                    }
                    catch {
                        print(error.localizedDescription)
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
