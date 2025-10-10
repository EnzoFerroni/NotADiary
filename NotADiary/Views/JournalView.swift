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
                Text(entry.title)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                Spacer()
            }
            HStack {
                Text("\(entry.date, format: .dateTime.day().month().year())")
                    .font(.title3)
                Spacer()
            }
            HStack {
                Text(entry.text)
                    .lineLimit(7)
                    .font(.headline)
                    .fontWeight(.regular)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            
            Image(uiImage: entry.image1!)
                .resizable()
                .frame(width: 280, height: 180)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .scaledToFit()
            
        }
        .foregroundStyle(.black)
        .padding(.horizontal)
    }
}

#Preview {
    JournalView(entry: JournalEntry(title: "Titulo", text: "asdjssdajfiosajdfiojsdafiojsdif", date: Date(), mood: "😃"))
}
