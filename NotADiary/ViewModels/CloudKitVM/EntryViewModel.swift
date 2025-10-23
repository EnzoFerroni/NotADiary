//
//  EntryViewModel.swift
//  NotADiary
//
//  Created by Pedro Augusto on 06/10/25.
//

import SwiftUI
import CloudKit
import Combine

class EntryViewModel: ObservableObject {
    @Published var isSignedInToiCloud: Bool = false
    @Published var error: String = ""
    @Published var name: String = ""
    @Published var permissionStatus: Bool = false
    
    var container = CKContainer.default()
    
    init() {
        getCloudKitStatus()
        requestPermission()
    }
    
    func getCloudKitStatus() {
        container.accountStatus { [weak self] returnedStatus, returnedError in
            DispatchQueue.main.async {
                switch returnedStatus {
                case .available:
                    self?.isSignedInToiCloud = true
                case .noAccount:
                    self?.error = CloudKitError.iCloudAccountNotFound.rawValue
                case .couldNotDetermine:
                    self?.error = CloudKitError.iCloudAccountNotDetermined.rawValue
                case .restricted:
                    self?.error = CloudKitError.iCloudAccountRestricted.rawValue
                default:
                    self?.error = CloudKitError.iCloudAccountUnknown.rawValue
                }
            }
        }
    }
    
    func requestPermission() {
        container.accountStatus() { [weak self] returnedStatus, returnedError in
            DispatchQueue.main.async {
                if returnedStatus == .available {
                    self?.permissionStatus = true
                }
            }
        }
    }
    
    enum CloudKitError: String, LocalizedError {
        case iCloudAccountNotFound
        case iCloudAccountNotDetermined
        case iCloudAccountRestricted
        case iCloudAccountUnknown
    }
}
