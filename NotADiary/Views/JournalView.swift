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
    var entry: JournalEntry
    
    @Environment(CloudKitViewModel.self) var ckViewModel: CloudKitViewModel
    @State private var viewModel = MusicPlayerViewModel()
    
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
            
            
            HStack {
                if let image = ckViewModel.imagesDictionary[entry.id!]?.first?.image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 176, height: 154)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .clipped()
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 176, height: 154)
                }
            }
        }
        .padding(.horizontal)
    }
}

//#Preview {
//    JournalView(entry: JournalEntry(title: "Titulo", text: "asdjssdajfiosajdfiojsdafiojsdif", date: Date(), mood: "😃"))
//}
