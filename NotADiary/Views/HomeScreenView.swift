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
    var body: some View {
        NavigationStack {
            VStack {
                Button {
                    toggleSheet.toggle()
                } label: {
                    HStack {
                        Image(systemName: "plus.circle")
                        Text("Add Jounal Entry")
                    }
                }
                .font(.largeTitle)
                Divider()
                ScrollView(showsIndicators: false) {
                    ForEach(entryList) { entry in
                        JournalView(entry: entry)
                        Divider()
                    }
                }
            }
            .sheet(isPresented: $toggleSheet){
                JournalEntryView(entryList: $entryList)
            }
        }
    }
}

#Preview {
    HomeScreenView()
}
