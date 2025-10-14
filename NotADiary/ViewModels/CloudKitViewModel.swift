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
    var name: String? = ""
    
    var isLogged: Bool = false
    
    var container = CKContainer.default()
    
    var preference: Preference? = nil
    
    var entriesDictionary: [CKRecord.ID: JournalEntry] = [:]
    var entries: [JournalEntry] = []
    
    func loginButtonPressed() {
        guard name != nil, !name!.isEmpty else { return }
        
        createPreference(name: name!)
    }
    
    init() {
        Task {
            do {
                try await fetchDiaryEntries()
            }
            catch {
                print(error.localizedDescription)
            }
        }
        
        getPreferenceRecordID { recordID, error in
            if let returnedPreferenceID = recordID?.recordName {
                self.isLogged(idUser: returnedPreferenceID)
            }
        }
    }
    
    func createPreference(name: String) {
        let newPreference = CKRecord(recordType: "preferences")
        
        getPreferenceRecordID { recordID, error in
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
    
    func removePreference(preference: Preference) async throws {
        let record = preference.record
        do {
            try await container.publicCloudDatabase.deleteRecord(withID: record.recordID)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func createDiaryEntry(entry: JournalEntry) throws {
        let newEntry = CKRecord(recordType: "entries")
        
        let image = try CKAsset(image: entry.image1!)
        
        newEntry["ID"] = newEntry.recordID.recordName
        newEntry["title"] = entry.title
        newEntry["text"] = entry.text
        newEntry["image"] = image
        newEntry["date"] = entry.date
        newEntry["mood"] = entry.mood
        
        let entrySet = JournalEntry(id: newEntry.recordID, title: entry.title, text: entry.text, image1: entry.image1, date: entry.date, mood: entry.mood)
        
        entriesDictionary[newEntry.recordID] = entrySet
        sendEntryToDB(record: newEntry)
    }
    
    func editDiaryEntry(entry: JournalEntry) async throws {
        do {
            let record = try await container.privateCloudDatabase.record(for: entry.id!)
            let asset = try CKAsset(image: entry.image1!)

            record["title"] = entry.title
            record["text"] = entry.text
            record["image"] = asset
            record["date"] = entry.date
            record["mood"] = entry.mood
            
            sendEntryToDB(record: record)
        }
    }
    
    func fetchDiaryEntries() async throws {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "entries", predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        let result = try await container.privateCloudDatabase.records(matching: query)
        entries = []
        
        let records = result.matchResults.compactMap { try? $0.1.get() }
        
        records.forEach { record in
            guard let title = record["title"] as? String else { return }
            guard let text = record["text"] as? String else { return }
            guard let asset = record["image"] as? CKAsset else { return }
            guard let date = record["date"] as? Date else { return }
            guard let mood = record["mood"] as? Int else { return }
            
            if let data = try? Data(contentsOf: (asset.fileURL!)), let image = UIImage(data: data) {
                let entry = JournalEntry(id: record.recordID, title: title, text: text, image1: image, date: date, mood: mood)
                
                entriesDictionary[record.recordID] = entry
                entries.append(entry)
            }
        }
    }
    
    func removeDiaryEntry(entry: JournalEntry) async throws {
        do {
            if let recordID = entry.id {
                try await container.privateCloudDatabase.deleteRecord(withID: recordID)
            }
        }
        catch {
            if let recordID = entry.id {
                entriesDictionary.removeValue(forKey: recordID)
            }
        }
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
    
    func fetchAndDeletePreference() {
        getPreferenceRecordID { recordID, error in
            if let returnedPreferenceID = recordID?.recordName {
                self.isLogged(idUser: returnedPreferenceID)
                
                Task {
                    if let _preference = self.preference {
                        try await self.removePreference(preference: _preference)
                        
                        for entry in self.entries {
                            try await self.removeDiaryEntry(entry: entry)
                        }
                        self.isLogged = false
                    }
                }
            }
        }
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
    
    func sendEntryToDB(record: CKRecord) {
        container.privateCloudDatabase.save(record) { returnedRecord, returnedError in
            print(returnedError ?? "")
            print(returnedRecord ?? "")
        }
    }
    
    func addOperationToPrivateDB(operation: CKDatabaseOperation) {
        container.privateCloudDatabase.add(operation)
    }
}
