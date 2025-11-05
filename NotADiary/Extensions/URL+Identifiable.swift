//
//  URL+Identifiable.swift
//  NotADiary
//
//  Created by Pedro Augusto on 29/10/25.
//

import Foundation

extension URL: @retroactive Identifiable {
    public var id: Int { hashValue }
}
