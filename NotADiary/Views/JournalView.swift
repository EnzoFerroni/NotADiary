//
//  JournalView.swift
//  NotADiary
//
//  Created by Francisco Losada on 08/10/25.
//

import SwiftUI

struct JournalView: View {
    var entry: JournalEntry
    
    @Environment(CloudKitViewModel.self) var ckViewModel: CloudKitViewModel

    var body: some View {
        VStack {
            HStack {
                Text("\(entry.date, format: .dateTime.day().month().year())")
                    .font(.largeTitle)
                Spacer()
            }
            HStack {
                Image(uiImage: entry.image1)
                    .resizable()
                    .frame(width: 180, height: 180)
                Image(uiImage: entry.image2)
                    .resizable()
                    .frame(width: 180, height: 180)
            }
            
            Text(entry.text)
                .lineLimit(7)
            Text(entry.mood)
                .font(.largeTitle)
        }
        .padding(.horizontal)
    }
}

//#Preview {
//    JournalView()
//}
