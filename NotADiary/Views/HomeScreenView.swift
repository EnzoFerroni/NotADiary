//
//  HomeScreenView.swift
//  NotADiary
//
//  Created by Francisco Losada on 08/10/25.
//

import SwiftUI

struct HomeScreenView: View {
    @State var toggleSheet: Bool = false
    @State var entryList: [JournalEntry] = []
    @State var teste: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Boas Vindas, <Pessoa>!")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    Spacer()
                }
                
                ScrollView {
                    ForEach(Array(entryList.enumerated()), id: \.offset) { index, entry in
                        NavigationLink {
                            JournalEntryFullView(entry: $entryList[index])
                        } label: {
                            VStack {
                                JournalView(entry: entry)
                                Divider()
                            }
                        }
                    }
                }
            }
            .task {
                await HealthManager.shared.requestHealthAuthorization()
            }
            .fullScreenCover(isPresented: $toggleSheet){
                JournalEntryView(entryList: $entryList)
            }
            
            ToolbarHomeScreenView(toggleSheet: $toggleSheet, teste: $teste)
        }
    }
}

