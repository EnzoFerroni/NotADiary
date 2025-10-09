//
//  PreferenceModel.swift
//  NotADiary
//
//  Created by Pedro Augusto on 06/10/25.
//

import Foundation
import CloudKit

struct Preference: Hashable {
    let name: String
    let userID: String
    let record: CKRecord
}
