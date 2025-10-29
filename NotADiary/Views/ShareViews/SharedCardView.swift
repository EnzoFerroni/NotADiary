//
//  JournalEntryFullView.swift
//  NotADiary
//
//  Created by Francisco Losada on 09/10/25.
//

import SwiftUI
import MusicKit

struct SharedCardView: View {
    
    @State var imageList: [UIImage] = []
    @State var entry: Card?
    @State var fullImage: Bool = false
    //@State var mpViewModel = MusicPlayerViewModel()
    @State var song: Song?
    var sharedURL: URL
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    HStack {
                        Text(entry?.title ?? "Dados não disponíveis")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    HStack {
                        Text("\(entry?.date ?? Date(), format: .dateTime.day().month().year())")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundStyle(.subheadline)
                        Spacer()
                    }
                    Divider()
                    HStack {
                        Text(entry?.text ?? "Dados não disponíveis")
                        Spacer()
                    }
                    
                    ZStack {
                        //Placeholder for Music Card
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 365, height: 71)
                            .foregroundStyle(.white)
                        //                        if song != nil {
                        //                            SongRow(isEdit: true, song: song!, hapticsManager: mpViewModel.hapticsManager, viewModel: $mpViewModel) {
                        //                                Task {
                        //                                    await mpViewModel.togglePlayPause()
                        //                                }
                        //                            }
                        //                            .background(.white.opacity(0.7))
                        //                            .frame(width: 365, height: 71)
                        //                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        
                        //                      }
                    }
                    HStack {
                        if imageList.first != nil {
                            VStack {
                                ForEach(imageList.enumerated(), id: \.offset) {  index, image in
                                    if index % 5 == 0 || index % 5 == 3 {
                                        if imageList.count == 1 {
                                            Image(uiImage: image)
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 200, height: 246)
                                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                                .clipped()
                                                .padding(.top, 10)
                                        }
                                        else {
                                            Image(uiImage: image)
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 200, height: 244)
                                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                                .clipped()
                                        }
                                    }
                                }
                                Spacer()
                            }
                            
                            VStack {
                                ForEach(imageList.enumerated(), id: \.offset) {  index, image in
                                    if index % 5 == 1 || index % 5 == 2 || index % 5 == 4 {
                                        Image(uiImage: image)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 153, height: 160)
                                            .clipShape(RoundedRectangle(cornerRadius: 16))
                                            .clipped()
                                    }
                                }
                                Spacer()
                            }
                            .padding(.horizontal)
                            
                        }
                    }
                    .onAppear() {
                        entry = FuncsCardModel.shared.loadJson(url: sharedURL)
                        if(entry?.images != nil){
                            for imagex64 in entry!.images{
                                guard let rebornImg = imagex64.imageFromBase64 else {
                                    //handle error
                                    return
                                }
                                imageList.append(rebornImg)
                            }
                            Task {
                                do {
                                    //song = try await mpViewModel.fetchSongById(entry.songID)
                                }
                                catch {
                                    print(error.localizedDescription)
                                }
                            }
                        }
                    }
                    .background { Color.background.ignoresSafeArea()}
                }
            }
        }
    }
}
