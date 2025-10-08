//
//  JournalViewModel.swift
//  NotADiary
//
//  Created by Francisco Losada on 08/10/25.
//

import Foundation
import SwiftUI

struct JournalEntry: Identifiable {
    var text: String
    var image1: UIImage
    var image2: UIImage
    var date: Date
    var mood: String
    let id: UUID = UUID()
}
