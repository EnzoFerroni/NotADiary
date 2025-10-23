//
//  JournalModel.swift
//  NotADiary
//
//  Created by Francisco Losada on 08/10/25.
//

import Foundation
import SwiftUI
import CloudKit
import MusicKit

struct JournalEntry: Identifiable, Hashable {
    let id: CKRecord.ID?
    var title: String
    var text: String
    var date: Date
    var mood: Int
    var songID: String
    var label: String
    var association: String
    var valence: Double
}
