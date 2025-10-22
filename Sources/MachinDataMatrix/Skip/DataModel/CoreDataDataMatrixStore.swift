//
//  CoreDataDataMatrixStore.swift
//  machindatamatrixxp
//
//  Created by Anthony Stanners on 22/10/2025.
//

#if !SKIP

import CoreData

@MainActor
final class CoreDataDataMatrixStore: PersistenceStore {
    typealias Model = DataMatrix
    static let shared = CoreDataDataMatrixStore(inMemory: gInMemoryCoreDataStore)

    let container: NSPersistentContainer

    init(inMemory: Bool = gInMemoryCoreDataStore) {
        container = NSPersistentContainer(name: "DataModel")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { _, error in
            if let error = error { fatalError("Core Data error: \(error)") }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
    }

    func fetchAll() async throws -> [DataMatrix] {
        let request = NSFetchRequest<DataMatrixCD>(entityName: "DataMatrixCD")
        let results = try container.viewContext.fetch(request)
        return results.map { cd in
            DataMatrix(
                dmCDid: cd.dmCDid,
                dateScanned: cd.dateScanned,
                imageData: cd.imageData,
                rawData: cd.rawData,
                upuCountryID: cd.upuCountryID
            )
        }
    }

    func save(_ item: DataMatrix) async throws {
        let context = container.viewContext
        let fetch = NSFetchRequest<DataMatrixCD>(entityName: "DataMatrixCD")
        fetch.predicate = NSPredicate(format: "dmCDid == %d", item.dmCDid)
        let existing = try context.fetch(fetch).first ?? DataMatrixCD(context: context)
        existing.dmCDid = item.dmCDid
        existing.dateScanned = item.dateScanned
        existing.imageData = item.imageData
        existing.rawData = item.rawData
        existing.upuCountryID = item.upuCountryID
        try context.save()
    }

    func delete(_ item: DataMatrix) async throws {
        let context = container.viewContext
        let fetch = NSFetchRequest<DataMatrixCD>(entityName: "DataMatrixCD")
        fetch.predicate = NSPredicate(format: "dmCDid == %d", item.dmCDid)
        if let obj = try context.fetch(fetch).first {
            context.delete(obj)
            try context.save()
        }
    }

    func deleteAll() async throws {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "DataMatrixCD")
        let batch = NSBatchDeleteRequest(fetchRequest: fetch)
        try container.viewContext.execute(batch)
    }
}

#endif
