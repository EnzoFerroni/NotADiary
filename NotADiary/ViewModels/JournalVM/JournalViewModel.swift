//
//  JournalViewModel.swift
//  NotADiary
//
//  Created by Francisco Losada on 28/10/25.
//

import SwiftUI
import Foundation

class JournalViewModel {
    @Environment(CloudKitViewModel.self) var ckViewModel: CloudKitViewModel

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
        }
    }
    
//    func avarageMood () -> MascotMood {
//        var monthMoods: [Int] = []
//        for i in
//        return .happiness
//        
//    }
}
