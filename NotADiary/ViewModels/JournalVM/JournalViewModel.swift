//
//  JournalViewModel.swift
//  NotADiary
//
//  Created by Francisco Losada on 28/10/25.
//

import SwiftUI
import Foundation

class JournalViewModel {
    func mascotMood(mood: MascotMood) -> String? {
        switch mood {
        case .happiness:
            return "happiness"
        case .sadness:
            return "sadness"
        }
    }
    
//    func avarageMood ()
}
