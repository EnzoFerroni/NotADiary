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
                    Button {
                        print("share")
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                    }
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


