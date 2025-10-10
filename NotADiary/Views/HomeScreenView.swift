//
//  HomeScreenView.swift
//  NotADiary
//
//  Created by Francisco Losada on 08/10/25.
//

import SwiftUI

struct HomeScreenView: View {
    @State var toggleSheet = false
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
            .fullScreenCover(isPresented: $toggleSheet){
                JournalEntryView(entryList: $entryList)
            }
            .toolbar {
                DefaultToolbarItem(kind: .search, placement: .bottomBar)
                ToolbarSpacer(.flexible, placement: .bottomBar)
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        toggleSheet.toggle()
                    } label: {
                        Image(systemName: "square.and.pencil")
                    }
                }
            }
            .searchable(text: $teste)
        }
    }
}

#Preview {
    HomeScreenView()
}
