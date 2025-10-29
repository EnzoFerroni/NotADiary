//
//  JournalEntryFullToolbarView.swift
//  NotADiary
//
//  Created by Francisco Losada on 20/10/25.
//

import SwiftUI

struct ToolbarJournalEntryFullView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(CloudKitViewModel.self) var ckViewModel: CloudKitViewModel
    @Binding var isEdit: Bool
    
    var entry: JournalEntry
    
    var body: some View {
        NavigationStack{
            Text("")
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Button {
                            print("waveform")
                        } label: {
                            Image(systemName: "waveform")
                        }
                    }
                    
                    ToolbarItem(placement: .bottomBar) {
                        Button {
                            print("headphones")
                        } label: {
                            Image(systemName: "headphones")
                        }
                    }
                    
                    ToolbarItem(placement: .bottomBar) {
                        //it was supposed to be the share option but it doesn`t seem do work
                    }
                    
                    ToolbarSpacer(.flexible, placement: .bottomBar)
                    
                    ToolbarItem (placement: .bottomBar) {
                        Button {
                            isEdit.toggle()
                        } label: {
                            Image(systemName: "slider.horizontal.3")
                        }
                    }
                    
                    ToolbarItem (placement: .confirmationAction) {
                        Button {
                            Task {
                                do {
                                    try await ckViewModel.removeDiaryEntry(entry: entry)
                                }
                                catch {
                                    print(error.localizedDescription)
                                }
                            }
                            dismiss()
                        } label: {
                            Image(systemName: "trash")
                                .foregroundStyle(.black)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.deleteButton)
                    }
                }
        }
    }
}
