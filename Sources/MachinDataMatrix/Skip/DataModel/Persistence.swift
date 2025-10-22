//
//  Persistence.swift
//  MachinDataMatrix
//
//  Created by Anthony Stanners on 15/06/2025.
//

import SwiftUI

@MainActor
enum PersistenceController {
    #if SKIP
    static let shared: any PersistenceStore = JSONDataMatrixStore.shared
    #else
    static let shared: any PersistenceStore = CoreDataDataMatrixStore.shared
    #endif
}

@MainActor
final class StoreModel: ObservableObject {
    let store: any PersistenceStore

    init(store: any PersistenceStore) {
        self.store = store
    }
}

// For previews (if we need it)
final class DummyPersistenceStore: PersistenceStore {
    typealias Model = DataMatrix

    func fetchAll() async throws -> [DataMatrix] { [] }
    func save(_ item: DataMatrix) async throws {}
    func delete(_ item: DataMatrix) async throws {}
    func deleteAll() async throws {}
}


//// Simple holder wrapping the dummy
//final class DummyPersistenceStoreHolder: Sendable {
//    let store: DummyPersistenceStore
//    init() { self.store = DummyPersistenceStore() }
//}

//struct PersistenceStoreKey: EnvironmentKey {
//    // static default must not reference @MainActor
//    static let defaultValue = DummyPersistenceStoreHolder()
//}

//// MARK: - EnvironmentValues extension
//extension EnvironmentValues {
//    // Computed property to access the store
//    var persistenceStore: PersistenceStoreHolder {
//        get {
//            // If runtime injection has occurred, return the real store
//            (self[PersistenceStoreKey.self] as? PersistenceStoreHolder)
//            ?? PersistenceStoreHolder(store: DummyPersistenceStore())
//        }
//        set {
//            self[PersistenceStoreKey.self] = newValue
//        }
//    }
//}

/*
 import CoreData
 
 @MainActor
 struct PersistenceController {
 
 static let shared = PersistenceController(inMemory: gInMemoryCoreDataStore )
 
 static var preview: PersistenceController = {
 let result = PersistenceController(inMemory: true)
 let context = result.container.viewContext
 return result
 }()
 
 let container: NSPersistentContainer
 
 init( inMemory: Bool = gInMemoryCoreDataStore ) {
 
 container = NSPersistentContainer(name: "DataModel")
 
 if inMemory {
 container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
 }
 
 container.loadPersistentStores(completionHandler: { (storeDescription, error) in
 
 if let error = error as NSError? {
 // TODO: Replace this implementation with code to handle the error appropriately.
 // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
 
 /*
  Typical reasons for an error here include:
  * The parent directory does not exist, cannot be created, or disallows writing.
  * The persistent store is not accessible, due to permissions or data protection when the device is locked.
  * The device is out of space.
  * The store could not be migrated to the current model version.
  Check the error message to determine what the actual problem was.
  */
 fatalError("Unresolved error 1 \(error), \(error.userInfo)")
 }
 })
 
 // TODO: Tried to add the code below from recommendation in "Making Apps with CoreData" video from Apple
 // ... except it does not seem to be supported on iOS
 
 //        do {
 //            try container.viewContext.setQueryGenerationFrom(.current)
 //        } catch {
 //            fatalError("Unresolved error 2 \(error)")
 //        }
 
 container.viewContext.automaticallyMergesChangesFromParent = true
 container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
 }
 }
 */
