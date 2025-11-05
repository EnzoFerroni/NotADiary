//
//  NotificationsModel.swift
//  NotADiary
//
//  Created by Pedro Augusto on 04/11/25.
//

import Foundation

struct Notifications : Hashable {
    let id = UUID()
    var hour: String
    var minute: String
}
