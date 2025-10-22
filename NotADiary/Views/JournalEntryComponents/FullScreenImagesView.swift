//
//  FullScreenImagesView.swift
//  NotADiary
//
//  Created by Francisco Losada on 22/10/25.
//

import SwiftUI

struct FullScreenImagesView: View {
    @Environment(\.dismiss) private var dismiss

    var imageList: [String]

    var body: some View {
        VStack {
            TabView {
                ForEach(imageList, id: \.self) { image in
                    Image(image)
                        .resizable()
                        .scaledToFit()
                        .border(.red)
                }
            }
            .tabViewStyle(.page)
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                        }
                        .border(.blue)
                    }
                }
        }
        
    }
}

#Preview {
    FullScreenImagesView(imageList: ["teste2", "teste2", "teste", "amiguinho", "amiguinho", "amiguinho", "teste"])
}
