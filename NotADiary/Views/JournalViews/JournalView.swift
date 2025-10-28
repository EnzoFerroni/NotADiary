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
    
    var entry: JournalEntry
    
    var body: some View {
        VStack {
            HStack {
                Text(entry.title)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .foregroundStyle(.black)
                Spacer()
            }
            HStack {
                Text("\(entry.date, format: .dateTime.day().month().year())")
                    .font(.title3)
                    .foregroundStyle(.black)
                Spacer()
            }
            HStack {
                Text(entry.text)
                    .lineLimit(7)
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
                            .frame(width: 176, height: 154)
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundStyle(.gray)
                            .frame(width: 176, height: 154)
                    }
                }
                HStack {
                    if let image = ckViewModel.imagesDictionary[entry.id!]?.first?.image {
                        if image != ckViewModel.imagesDictionary[entry.id!]?.last?.image {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 176, height: 154)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .clipped()
                        }
                        else {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 356, height: 154)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .clipped()
                        }
                    }
                    if let image = ckViewModel.imagesDictionary[entry.id!]?.last?.image {
                        if ckViewModel.imagesDictionary[entry.id!]?.first?.image != image {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 176, height: 154)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .clipped()
                        }
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}
