//
//  ToolbarEntryView.swift
//  NotADiary
//
//  Created by Francisco Losada on 08/10/25.
//

import SwiftUI
import MusicKit


struct ToolbarEntryView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(CloudKitViewModel.self) var ckViewModel: CloudKitViewModel

    @Binding var entryList: [JournalEntry]
    @Binding var images: [UIImage]
    @Binding var song: String
    @Binding var loadedSong: Song?
    
    @State var presentMusicSheet: Bool = false
    @State var presentHapticSheet: Bool = false
    @State var selectedHaptic: String?
    @State var haptics1: Bool = false
    @State var haptics2: Bool = false
    @State var haptics3: Bool = false
    @State var haptics4: Bool = false
        
    var text: String
    var day: Date
    var mood: Int
    var title: String
    var userValence: Double = 0.0
    var whereToSave: Bool
    
    //var userLabel: HKStateOfMind.Label
    //var userAssociation: HKStateOfMind.Association
    //@State private var relato: HKStateOfMind?
        
    var body: some View {
        NavigationStack {
            Text("")
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Button {
                            haptics1.toggle()
                            presentHapticSheet.toggle()
                        } label: {
                            Image(systemName: "waveform.path.badge.plus")
                        }
                        .sensoryFeedback(.selection, trigger: haptics1)

                    }
                    ToolbarItem(placement: .bottomBar) {
                        Button {
                            haptics2.toggle()
                            presentMusicSheet.toggle()
                        } label: {
                            Image(systemName: "music.note")
                        }
                        .sensoryFeedback(.selection, trigger: haptics2)

                    }
                    ToolbarItem(placement: .bottomBar) {
                        PhotoPickerAddView(image: $images, isEdit: false)
                        Image(systemName: "photo.badge.plus.fill")
                    }
//                    ToolbarItem(placement: .bottomBar) {
//                        Button {
//                            print("4")
//                        } label: {
//                            Image(systemName: "microphone.fill")
//                        }
//                    }
                    ToolbarSpacer(.flexible, placement: .bottomBar)
                    ToolbarItem (placement: .bottomBar) {
                        Button {
                            haptics3.toggle()
//                            relato = HealthManager.shared.createSample(eventAssociation: userAssociation, userLabel: userLabel, userValence: userValence, endDate: day)
                            Task {
                                do {
                                    let entry = try await ckViewModel.createDiaryEntry(entry: JournalEntry(id: nil, title: title, text: text, date: day, mood: mood, songID: song, label: "", association: "", valence: userValence))
                                    
                                    ckViewModel.createImageEntry(entry: entry, images: images)
                                }
                                catch {
                                    print(error.localizedDescription)
                                }
//                                if whereToSave {
//                                    await HealthManager.shared.save(sample: relato!)
//                                }
                                
                                // ÖS DORAKM AVAROSKA
                                dismiss()
                            }
                        } label: {
                            Image(systemName: "checkmark")
                        }
                        .sensoryFeedback(.selection, trigger: haptics3)
                    }
                    ToolbarSpacer(.fixed, placement: .bottomBar)
                    ToolbarItem (placement: .bottomBar) {
                        Button {
                            haptics4.toggle()
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                        }
                        .sensoryFeedback(.warning, trigger: haptics4)
                    }
                }
                .sheet(isPresented: $presentHapticSheet) {
                    HapticSelectionView(selectedHaptic: $selectedHaptic)
                }
                .sheet(isPresented: $presentMusicSheet) {
                    MusicView(songSelectedId: $song, loadedSong: $loadedSong)
                }
        }
    }
}
