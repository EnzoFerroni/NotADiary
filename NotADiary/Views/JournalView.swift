//
//  JournalView.swift
//  NotADiary
//
//  Created by Francisco Losada on 08/10/25.
//

import SwiftUI

struct JournalView: View {
    var entry: JournalEntry

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
                    .frame(width: 200, height: 200)
                Image(uiImage: entry.image2)
                    .resizable()
                    .frame(width: 200, height: 200)
            }
            
            Text(entry.text)
                .lineLimit(7)
        }
        .padding(.horizontal)
    }
}

//#Preview {
//    JournalView()
//}
