//
//  JournalViewModel.swift
//  NotADiary
//
//  Created by Francisco Losada on 08/10/25.
//

import Foundation
import SwiftUI

struct JournalEntry: Identifiable {
    var title: String
    var text: String
    var image1: UIImage?
    //var image2: UIImage?
    var date: Date
    let id: UUID = UUID()
    var userValence: Double
//    var whereToSave: Bool
//    var userLabel: HKStateOfMind.Label
//    var userAssociation: HKStateOfMind.Association
}
