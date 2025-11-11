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
    
    @State var alert: Bool = false
    @State var haptics1: Bool = false
    @State var haptics2: Bool = false
    @State var haptics3: Bool = false
    @State var haptics4: Bool = false
    
    var card: Card
    var entry: JournalEntry
    
    var body: some View {
        Text("")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    ShareLink(item: card, preview: SharePreview("\(entry.title)")) {
                        Label("Share", systemImage: "square.and.arrow.up")
                    }
                    .onTapGesture {
                        haptics1.toggle()
                    }
                    .tint(.white)
                    .sensoryFeedback(.increase, trigger: haptics1)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Menu {
                        Button {
                            haptics2.toggle()
                            isEdit.toggle()
                        } label: {
                            Label("Editar", systemImage: "slider.horizontal.3")
                        }
                        .sensoryFeedback(.increase, trigger: haptics2)

                        Button(role: .destructive) {
                            haptics3.toggle()
                            alert.toggle()
                        } label: {
                            Label("Deletar", systemImage: "trash")
                        }
                        .sensoryFeedback(.increase, trigger: haptics3)

                    } label: {
                        Image(systemName: "ellipsis")
                    }
                    .alert("Deletar Relato", isPresented: $alert, actions: {
                            Button(role: .destructive) {
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
                                Text("Deletar")
                            }
                            Button(role: .cancel) {
                                
                            } label: {
                                Text("Cancelar")
                            }
                        
                    }, message: {
                        Text("Você está prestes a deletar este relato, não haverá maneira de recuperá-lo.")
                    })
                }
        }
    }
}
