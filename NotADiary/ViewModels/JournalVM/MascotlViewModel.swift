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
        case .love:
            return "love"
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
        case .ultraLove:
            return "ultraLove"
        }
    }
    
    func mascotMessage(mood: MascotMood) -> String? {
        switch mood {
        case .happiness:
            return "Este mês você se sentiu feliz com mais frequência, vamos continuar assim!"
        case .sadness:
            return "Este mês você se sentiu triste"
        case .anger:
            return "Este mês você se sentiu bravo"
        case .fear:
            return "Este mês você se sentiu medo"
        case .surprise:
            return "Este mês você se sentiu surpreso"
        case .love:
            return "Este mês você se sentiu amado"
        case .ultraHappiness:
            return "Este mês você se sentiu muito feliz!"
        case .ultraSadness:
            return "Este mês você se sentiu muito triste :("
        case .ultraAnger:
            return "Este mês você se sentiu muito bravo"
        case .ultraFear:
            return "Este mês você sentiu muito medo"
        case .ultraSurprise:
            return "Este mês você se sentiu muito surpreso"
        case .ultraLove:
            return "Este mês você se sentiu extrememente amado!"
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
        case .love:
            return .loveMascot
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
        case .ultraLove:
            return .ultraLoveMascot
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
            return .love
        case 7:
            return .ultraLove
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
        var counts = [Int: Int]()
        
        monthMood.forEach {
            counts[$0] = (counts[$0] ?? 0) + 1
        }
        
        if let (value, count) = counts.max(by: {$0.1 < $1.1}) {
            return value
        }
        return 0
    }
}
