//
//  ImagesGridView.swift
//  NotADiary
//
//  Created by Francisco Losada on 25/10/25.
//

import SwiftUI

struct ImagesGridView: View {
    @Environment(CloudKitViewModel.self) var ckViewModel: CloudKitViewModel
    
    @State var entry: JournalEntry
    
    var body: some View {
        HStack {
            if ckViewModel.imagesDictionary[entry.id!]?.first?.image != nil {
                VStack {
                    ForEach(Array(ckViewModel.imagesDictionary[entry.id!]!.enumerated()), id: \.offset) { index, image in
                        if index % 5 == 0 || index % 5 == 3 {
                            if ckViewModel.imagesDictionary[entry.id!]!.count == 1 {
                                Image(uiImage: image.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 200, height: 246)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                    .clipped()
                                    .padding(.top, 10)
                            }
                            else {
                                Image(uiImage: image.image)
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
                    ForEach(Array(ckViewModel.imagesDictionary[entry.id!]!.enumerated()), id: \.offset) { index, image in
                        if index % 5 == 1 || index % 5 == 2 || index % 5 == 4 {
                            Image(uiImage: image.image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 153, height: 160)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .clipped()
                        }
                    }
                    Spacer()
                }
            }
        }
    }
}
