//
//  ImageModel.swift
//  NotADiary
//
//  Created by Pedro Augusto on 20/10/25.
//

import CloudKit
import UIKit
import Foundation

struct ImageModel: Identifiable {
    let id: CKRecord.ID?
    var entry: CKRecord.ID
    var image: UIImage
}
