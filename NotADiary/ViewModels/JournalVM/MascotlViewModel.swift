//
//  JournalViewModel.swift
//  NotADiary
//
//  Created by Francisco Losada on 28/10/25.
//

import SwiftUI
import Foundation

class MascotViewModel {
    func mascotMoodImage(mood: MascotMood) -> String? {
        switch mood {
        case .happiness:
            return "happiness"
        case .sadness:
            return "sadness"
        case .anger:
            return "anger"
        case .fear:
            return "fear"
        case .surprise:
            return "surprise"
        case .disgust:
            return "disgust"
        case .ultraHappiness:
            return "ultraHappiness"
        case .ultraSadness:
            return "ultraSadness"
        case .ultraAnger:
            return "ultraAnger"
        case .ultraFear:
            return "ultraFear"
        case .ultraSurprise:
            return "ultraSurprise"
        case .ultraDisgust:
            return "ultraDisgust"
        }
    }
    
    func mascorMoodColor(mood: MascotMood) -> Color {
        switch mood {
        case .happiness:
            return .happinessMascot
        case .sadness:
            return .sadnessMascot
        case .anger:
            return .angerMascot
        case .fear:
            return .fearMascot
        case .surprise:
            return .surpriseMascot
        case .disgust:
            return .disgustMascot
        case .ultraHappiness:
            return .ultraHappinessMascot
        case .ultraSadness:
            return .ultraSadnessMascot
        case .ultraAnger:
            return .ultraAngerMascot
        case .ultraFear:
            return .ultraFearMascot
        case .ultraSurprise:
            return .ultraSurpriseMascot
        case .ultraDisgust:
            return .ultraDisgustMascot
        }
    }
    
    func moodToMascot(value: Int) -> MascotMood {
        switch value {
        case 0:
            return .happiness
        case 1:
            return .ultraHappiness
        case 2:
            return .sadness
        case 3:
            return .ultraSadness
        case 4:
            return .anger
        case 5:
            return .ultraAnger
        case 6:
            return .disgust
        case 7:
            return .ultraDisgust
        case 8:
            return .fear
        case 9:
            return .ultraFear
        case 10:
            return .surprise
        case 11:
            return .ultraSurprise
        default:
            return .ultraHappiness
        }
    }
    
    func avarageMood(viewModel: CloudKitViewModel) async -> Int {
        try? await viewModel.fetchLastThirtyEntries()
        let monthEntries: [JournalEntry] = viewModel.lastThirtyEntries
        var monthMood: [Int] = []
        for mood in monthEntries {
            monthMood.append(mood.mood)
        }
        var count = 0
        var current = 0
        var maxCount = 0
        var maxElement = current
        for i in monthMood {
            if i == current {
                count += 1
            }
            else {
                if (count > maxCount) {
                    maxCount = count
                    maxElement = current
                }
                current = i
                count = 0
            }
        }
        if count > maxCount {
            maxCount = count
            maxElement = current
        }
        print("\(maxElement)")
        return maxElement
    }
}
