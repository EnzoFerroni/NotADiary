//
//  MascotGridView.swift
//  NotADiary
//
//  Created by Francisco Losada on 30/10/25.
//

import SwiftUI

struct MascotGridView: View {
    let moods: [String] = ["ultraSadness", "sadness", "happiness", "ultraHappiness", "ultraSurprise", "surprise",  "love", "ultraLove", "ultraAnger", "anger", "fear", "ultraFear"]
    @Binding var mascotMood: Int
    @State var selected: Int = 12
    @State var moodImage: String?
    @State var moodMascot: MascotMood?
    @State var mViewModel = MascotViewModel()
    @State var moodName: String?
    
    var body: some View {
        if selected == mascotMood {
            VStack {
                Image(moodImage!)
                    .resizable()
                    .frame(width: 180, height: 180)

                Text(moodName ?? "")
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
            }
        }
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 76))], alignment: .center) {
            ForEach(moods.enumerated(), id: \.offset) { i, mood in
                Button {
                    mascotMood = i
                    selected = mascotMood
                    moodImage = moods[selected]
                } label: {
                    Image(mood)
                        .resizable()
                        .frame(width: 85, height: 85)
                }
            }
        }
        .onChange(of: selected, { oldValue, newValue in
            moodMascot = mViewModel.moodToMascot(value: mascotMood)
            moodName = mViewModel.moodToName(mood: moodMascot!)
        })
    }
}
