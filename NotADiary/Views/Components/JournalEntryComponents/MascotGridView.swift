//
//  MascotGridView.swift
//  NotADiary
//
//  Created by Francisco Losada on 30/10/25.
//

import SwiftUI

struct MascotGridView: View {
    let moods: [String] = ["happiness", "ultraHappiness", "sadness", "ultraSadness", "anger", "ultraAnger", "disgust", "ultraDisgust", "fear", "ultraFear", "surprise", "ultraSurprise"]
    @Binding var mascotMood: Int //alterar para binding depois
    @State var selected: Int = 12
    @State var moodImage: String?
    var body: some View {
        if selected == mascotMood {
            Image(moodImage!)
                .resizable()
                .frame(width: 180, height: 180)
        }
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], alignment: .center) {
            ForEach(moods.enumerated(), id: \.offset) { i, mood in
                Button {
                    mascotMood = i
                    selected = mascotMood
                    moodImage = moods[selected]
                } label: {
                    Image(mood)
                        .resizable()
                        .frame(width: 100, height: 100)
                }
            }
        }
        .padding(.horizontal)
    }
}
