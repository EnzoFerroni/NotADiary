//
//  CloudKitViewModel.swift
//  NotADiary
//
//  Created by Pedro Augusto on 06/10/25.
//

import Foundation
import CloudKit
import SwiftUI
import Observation

class CloudKitViewModel {
    private var userID: String = ""
    var name: String = ""
    
    var isLogged: Bool = false
    
    var container = CKContainer.default()
    
    func registerUser(name: String) {
        let newUser = CKRecord(recordType: "preferences")
        
        getUserRecordID { (recordID: CKRecord.ID?, error: NSError?) in
            if let userID = recordID?.recordName {
                newUser["name"] = name
                
                self.sendUserToDB(record: newUser)
            }
            else {
                print("Fetched iCloudID returned nil")
            }
        }
    }
    
    func getUserRecordID(complete: @escaping (_ instance: CKRecord.ID?, _ error: NSError?) -> ()) {
        let container = CKContainer.default()
        container.fetchUserRecordID() {
            recordID, error in
            if error != nil {
                print(error!.localizedDescription)
                complete(nil, error as NSError?)
            } else {
                complete(recordID, nil)
            }
        }
    }
    
    func sendUserToDB(record: CKRecord) {
        container.privateCloudDatabase.save(record) { [weak self] returnedRecord, returnedError in
            print(returnedError ?? "")
            print(returnedRecord ?? "")

            DispatchQueue.main.async {
                self?.name = ""
            }
        }
    }
}
