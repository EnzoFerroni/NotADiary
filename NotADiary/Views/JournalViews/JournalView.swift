//
//  JournalView.swift
//  NotADiary
//
//  Created by Francisco Losada on 08/10/25.
//

import SwiftUI
import CloudKit
import MusicKit

struct JournalView: View {
    @Environment(CloudKitViewModel.self) var ckViewModel: CloudKitViewModel
    @State private var viewModel = MusicPlayerViewModel()
    @State var isLoading: Bool = true
    
    @State var mViewModel = MascotViewModel()
    @State var moodValue: Int?
    @State var mood: MascotMood?
    @State var moodColor: Color = .white
    
    var entry: JournalEntry
    
    var body: some View {
        VStack {
            HStack {
                if entry.title != "" {
                    Text(entry.title)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                        .foregroundStyle(.black)
                    Spacer()
                }
            }
            HStack {
                Text("\(entry.date, format: .dateTime.day().month().year())")
                    .font(.title3)
                    .foregroundStyle(.black)
                Spacer()
            }
            HStack {
                Text(entry.text)
                    .lineLimit(2)
                    .font(.headline)
                    .fontWeight(.regular)
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(.black)
                Spacer()
            }
            ZStack {
                if isLoading {
                    HStack {
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundStyle(.gray)
                            .frame(width: 160, height: 140)
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundStyle(.gray)
                            .frame(width: 160, height: 140)
                    }
                    .onAppear() {
                        Timer.scheduledTimer(withTimeInterval: 4.0, repeats: false) { _ in
                            isLoading = false
                        }
                    }
                }
                HStack {
                    if let image = ckViewModel.imagesDictionary[entry.id!]?.first?.image {
                        if image != ckViewModel.imagesDictionary[entry.id!]?.last?.image {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 160, height: 140)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .clipped()
                        }
                        else {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 350, height: 154)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .clipped()
                        }
                    }
                    if let image = ckViewModel.imagesDictionary[entry.id!]?.last?.image {
                        if ckViewModel.imagesDictionary[entry.id!]?.first?.image != image {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 160, height: 140)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .clipped()
                        }
                    }
                }
            }
        }
        .padding()
        .background(moodColor)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(radius: 2, x: 2, y: 3)
        .padding(.bottom, 12)
        .onAppear() {
            Task {
                moodValue = entry.mood
                mood = mViewModel.moodToMascot(value: moodValue!)
                moodColor = mViewModel.mascorMoodColor(mood: mood!)
            }
        }
    }
}
