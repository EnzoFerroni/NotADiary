//
//  MascotGridView.swift
//  NotADiary
//
//  Created by Francisco Losada on 30/10/25.
//

import SwiftUI

struct MascotGridView: View {
    @Binding var mascotMood: Int
    var body: some View {
        Grid {
            GridRow {
                Button {
                    mascotMood = 0
                } label: {
                    Image("happiness")
                        .resizable()
                        .frame(width: 90, height: 90)
                }
                Button {
                    mascotMood = 1
                } label: {
                    Image("ultraHappiness")
                        .resizable()
                        .frame(width: 90, height: 90)
                }
                Button {
                    mascotMood = 2
                } label: {
                    Image("sadness")
                        .resizable()
                        .frame(width: 90, height: 90)
                }
            }
            GridRow {
                Button {
                    mascotMood = 3
                } label: {
                    Image("ultraSadness")
                        .resizable()
                        .frame(width: 90, height: 90)
                }
                Button {
                    mascotMood = 4
                } label: {
                    Image("anger")
                        .resizable()
                        .frame(width: 90, height: 90)
                }
                Button {
                    mascotMood = 5
                } label: {
                    Image("ultraAnger")
                        .resizable()
                        .frame(width: 90, height: 90)
                }
            }
            GridRow {
                Button {
                    mascotMood = 6
                } label: {
                    Image("disgust")
                        .resizable()
                        .frame(width: 90, height: 90)
                }
                Button {
                    mascotMood = 7
                } label: {
                    Image("ultraDisgust")
                        .resizable()
                        .frame(width: 90, height: 90)
                }
                Button {
                    mascotMood = 8
                } label: {
                    Image("fear")
                        .resizable()
                        .frame(width: 90, height: 90)
                }
            }
            GridRow {
                Button {
                    mascotMood = 9
                } label: {
                    Image("ultraFear")
                        .resizable()
                        .frame(width: 90, height: 90)
                }
                Button {
                    mascotMood = 10
                } label: {
                    Image("surprise")
                        .resizable()
                        .frame(width: 90, height: 90)
                }
                Button {
                    mascotMood = 11
                } label: {
                    Image("ultraSurprise")
                        .resizable()
                        .frame(width: 90, height: 90)
                }
            }
        }
    }
}
