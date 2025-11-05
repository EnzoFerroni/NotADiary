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
    @State var searchText: String = ""
    @State var sharedURL: URL? = nil
    @State var toggleShared: Bool = false
    
    @Environment(CloudKitViewModel.self) var ckViewModel: CloudKitViewModel
    @Environment(\.refresh) private var refresh
    
    var body: some View {
        NavigationStack {
            ScrollView {
                MascotView(toogleSheet: $toggleSheet)
                ForEach(Array(ckViewModel.entries.enumerated()), id: \.offset) { index, entry in
                    NavigationLink {
                        JournalEntryFullView(entry: entry)
                            .onDisappear {
                                Task {
                                    do {
                                        try await ckViewModel.fetchDiaryEntries()
                                    }
                                    catch {
                                        print(error.localizedDescription)
                                    }
                                }
                            }
                    } label: {
                        VStack {
                            JournalView(entry: entry)
                                .task {
                                    do {
                                        try await ckViewModel.fetchImageByDiaryEntry(entry: entry)
                                    }
                                    catch {
                                        print(error.localizedDescription)
                                    }
                                }
                        }
                    }
                }
                ToolbarHomeScreenView()
            }
            .refreshable {
                Task {
                    do {
                        try await ckViewModel.fetchDiaryEntries()
                    }
                    catch {
                        print(error.localizedDescription)
                    }
                }
            }
            .background { Color.background.ignoresSafeArea()}
            .task {
                await HealthManager.shared.requestHealthAuthorization()
            }
            .fullScreenCover(isPresented: $toggleSheet){
                JournalCreateEntryView(entryList: $entryList)
                    .onDisappear {
                        Task {
                            do {
                                try await ckViewModel.fetchDiaryEntries()
                            }
                            catch {
                                print(error.localizedDescription)
                            }
                        }
                    }
            }
        }
        .onOpenURL { URL in
            sharedURL = URL
            toggleShared = true
            print(URL)
        }
        .fullScreenCover(item: $sharedURL) { url in
            SharedCardView(sharedURL: url)
                .task {
                    print(url)
                }
        }
    }
    
}

