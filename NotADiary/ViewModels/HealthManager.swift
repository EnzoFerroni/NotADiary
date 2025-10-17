import SwiftUI
import HealthKit


class HealthManager{
    
    public static let shared = HealthManager()
    
    private var results: [HKStateOfMind] = []
    
    // MARK: - Types
    
    private let moodType = HKObjectType.stateOfMindType()
    
    // MARK: - Authorization
    
    func requestHealthAuthorization() async {
        
        //tratar a falta de disponiblidade do healthkit
        guard HKHealthStore.isHealthDataAvailable() else { return }
        
        // Request authorization to read the user's step count from HealthKit
        // Tratar a falta de autorizacao do usuario
        try? await HKHealthStore().requestAuthorization(toShare: [moodType], read: [moodType])
    }
    
    // MARK: - Writing Mood
    
    /// Create State of Mind sample for an event and emoji selection
    
    func createSample(eventAssociation: HKStateOfMind.Association, userLabel: HKStateOfMind.Label, userValence: Double, endDate: Date) -> HKStateOfMind {
        let kind: HKStateOfMind.Kind = .momentaryEmotion
        let valence: Double = userValence
        let label = userLabel
        let association = eventAssociation
        return HKStateOfMind(date: endDate,
                             kind: kind,
                             valence: valence,
                             labels: [label],
                             associations: [association])
    }
    
    func save(sample: HKSample) async {
        do {
            try await HKHealthStore().save(sample)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Reading Mood
    
    // Busca os moods registrados num intervalo (ex: últimos 7 dias)
    
    func fetchMoods() async -> [HKStateOfMind] {
        
        
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        let datePredicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictStartDate)
        
        let stateOfMindPredicate = HKSamplePredicate.stateOfMind(datePredicate)
        
        let descriptor = HKSampleQueryDescriptor(predicates: [stateOfMindPredicate],
                                                 sortDescriptors: [])
        do {
            // Launch the query and wait for the results.
            results = try await descriptor.result(for: HKHealthStore())
        } catch {
            print(error.localizedDescription)
        }
        return results
    }
}
