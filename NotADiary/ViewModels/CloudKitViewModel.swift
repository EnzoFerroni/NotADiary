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

@Observable
@MainActor
class CloudKitViewModel {
    private var userID: String = ""
    var name: String = ""
    
    var isLogged: Bool = false
    
    var container = CKContainer.default()
    
    var preference: Preference? = nil
    
    var entriesDictionary: [CKRecord.ID: Entry] = [:]
    
    func loginButtonPressed() {
        guard !name.isEmpty else { return }
        
        createPreference(name: name)
    }
    
    init() {
        getPreferenceRecordID { recordID, error in
            if let returnedPreferenceID = recordID?.recordName {
                self.isLogged(idUser: returnedPreferenceID)
            }
        }
    }
    
    func createPreference(name: String) {
        let newPreference = CKRecord(recordType: "preferences")
        
        getPreferenceRecordID { (recordID: CKRecord.ID?, error: NSError?) in
            if let userID = recordID?.recordName {
                newPreference["name"] = name
                newPreference["ID"] = userID
                
                self.sendPreferenceToDB(record: newPreference)
            }
            else {
                print("Fetched iCloudID returned nil")
            }
        }
    }
    
    func createDiaryEntry(entry: Entry) throws {
        let newEntry = CKRecord(recordType: "entries")
        let image = try CKAsset(image: entry.image)
        
        newEntry["ID"] = newEntry.recordID.recordName
        newEntry["title"] = entry.title
        newEntry["text"] = entry.text
        newEntry["image"] = image
        newEntry["date"] = entry.date
        newEntry["humor"] = entry.humor
    }
    
    func getPreferenceRecordID(complete: @escaping (_ instance: CKRecord.ID?, _ error: NSError?) -> ()) {
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
    
    func isLogged(idUser: String) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "preferences", predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        
        var returnedMatchingPreference: [Preference] = []
        
        queryOperation.recordMatchedBlock = { [weak self] returnedRecordID, returnedResult in
            switch returnedResult {
            case .success(let record):
                guard let id = record["ID"] as? String else { return }
                guard let name = record["name"] as? String else { return }
                
                if id == idUser {
                    returnedMatchingPreference.append(Preference(name: name, userID: idUser, record: record))
                    DispatchQueue.main.async {
                        self?.preference = Preference(name: name, userID: idUser, record: record)
                    }
                }
            case .failure(let error):
                print("Error recordMatchedBlock: \(error)")
            }
        }
        
        queryOperation.queryResultBlock = { [weak self] returnedResult in
            print("Returned result: \(returnedResult)")
            DispatchQueue.main.async {
                if !returnedMatchingPreference.isEmpty {
                    self?.isLogged = true
                    print("There's a user with that ID")
                }
            }
        }
        
        addOperationToPrivateDB(operation: queryOperation)
    }
    
    func sendPreferenceToDB(record: CKRecord) {
        container.privateCloudDatabase.save(record) { [weak self] returnedRecord, returnedError in
            print(returnedError ?? "")
            print(returnedRecord ?? "")

            DispatchQueue.main.async {
                self?.name = ""
            }
        }
    }
    
    func addOperationToPrivateDB(operation: CKDatabaseOperation) {
        container.privateCloudDatabase.add(operation)
    }
}
