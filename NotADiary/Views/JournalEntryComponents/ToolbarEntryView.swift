//
//  ToolbarEntryView.swift
//  NotADiary
//
//  Created by Francisco Losada on 08/10/25.
//

import SwiftUI
import HealthKit


struct ToolbarEntryView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(CloudKitViewModel.self) var ckViewModel: CloudKitViewModel

    @Binding var entryList: [JournalEntry]
    @Binding var images: [UIImage]
        
    var text: String
    var day: Date
    var mood: Int
    var title: String
    var userValence: Double
    var whereToSave: Bool
    var userLabel: HKStateOfMind.Label
    var userAssociation: HKStateOfMind.Association
    
    @State private var relato: HKStateOfMind?
    
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
                        PhotoPickerAddView(image: $images, isEdit: false)
                        Image(systemName: "photo.badge.plus.fill")
                    }
                    ToolbarItem(placement: .bottomBar) {
                        Button {
                            print("4")
                        } label: {
                            Image(systemName: "waveform")
                        }
                    }
                    ToolbarSpacer(.flexible, placement: .bottomBar)
                    ToolbarItem (placement: .bottomBar) {
                        Button {
                            relato = HealthManager.shared.createSample(eventAssociation: userAssociation, userLabel: userLabel, userValence: userValence, endDate: day)
                            do {
                                let entry = try ckViewModel.createDiaryEntry(entry: JournalEntry(id: nil, title: title, text: text, date: day, mood: mood, songID: "", label: "", association: "", valence: userValence))
                                
                                if let _image = image {
                                    ckViewModel.createImageEntry(entry: entry, image: _image)
                                }
                            }
                            catch {
                                print(error.localizedDescription)
                            }
                            
                            Task {
                                if whereToSave {
                                    await HealthManager.shared.save(sample: relato!)
                                }
                            }
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
