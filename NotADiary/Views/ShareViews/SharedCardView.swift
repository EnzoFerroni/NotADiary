//
//  JournalEntryFullView.swift
//  NotADiary
//
//  Created by Francisco Losada on 09/10/25.
//

import SwiftUI
import MusicKit

struct SharedCardView: View {
    @Environment(\.dismiss) var dismiss
    @State var imageList: [UIImage] = []
    @State var entry: Card = Card(images: [], title: "Dados não disponíveis", text: "Dados não disponíveis", date: Date(), mood: 0, songID: "", label: "", association: "", valence: 0)
    @State var fullImage: Bool = false
    @State var mpViewModel = MusicPlayerViewModel()
    @State var song: Song?
    
    var sharedURL: URL
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    HStack {
                        Text(entry.title)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    HStack {
                        Text("\(entry.date, format: .dateTime.day().month().year())")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundStyle(.subheadline)
                        Spacer()
                    }
                    Divider()
                    HStack {
                        Text(entry.text)
                        Spacer()
                    }
                    
                    ZStack {
                        //Placeholder for Music Card
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 365, height: 71)
                            .foregroundStyle(.white)
                        if song != nil {
                            SongRow(isEdit: true, song: song!, hapticsManager: mpViewModel.hapticsManager, viewModel: $mpViewModel) {
                                Task {
                                    await mpViewModel.togglePlayPause()
                                }
                            }
                            .background(.white.opacity(0.7))
                            .frame(width: 365, height: 71)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            
                        }
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
                        entry = FuncsCardModel.shared.loadJson(url: sharedURL) ?? Card(images: [], title: "Dados não disponíveis", text: "Dados não disponíveis", date: Date(), mood: 0, songID: "", label: "", association: "", valence: 0)
                        if(!(entry.images.isEmpty)){
                            for imagex64 in entry.images{
                                guard let rebornImg = imagex64.imageFromBase64 else {
                                    //handle error
                                    return
                                }
                                imageList.append(rebornImg)
                            }
                            Task {
                                do {
                                    song =  await mpViewModel.fetchSongById(entry.songID)
                                }
                            }
                        }
                    }
                    .background { Color.background.ignoresSafeArea()}
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
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
