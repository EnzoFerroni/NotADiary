//
//  JournalViewModel.swift
//  NotADiary
//
//  Created by Francisco Losada on 08/10/25.
//

import Foundation
import SwiftUI
import CloudKit

struct JournalEntry: Identifiable {
    let id: CKRecord.ID?
    var title: String
    var text: String
    var image1: UIImage?
    //var image2: UIImage?
    var date: Date
    var mood: Int
}
