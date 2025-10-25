//
//  DMStore.swift
//  MachinDataMatrix
//
//  Created by Anthony Stanners on 15/06/2025.
//

import SwiftUI

@MainActor
@Observable
final class DMStore {

    let store: any PersistenceStore
    
    private(set) var allData: [DataMatrix] = []
    
    private var nextSequenceNo: Int32 = 1
    
    init(store: any PersistenceStore) {
        self.store = store
    }
    
    // MARK: --- Refresh
    func refresh() async {
        do {
            allData = try await store.fetchAll()
            nextSequenceNo = computeNextSequenceNo(from: allData)
        } catch {
            print("Failed to refresh data: \(error)")
        }
    }
    
    // MARK: --- Fetch
    func fetch(dmID: Int32) async -> DataMatrix? {
        // First check in-memory cache
        if let item = allData.first(where: { $0.dmID == dmID }) {
            return item
        }

        // If cache is empty, fetch all from the backend and update the cache
        if allData.isEmpty {
            do {
                allData = try await store.fetchAll()
            } catch {
                print("Failed to fetch all data: \(error)")
                return nil
            }
            return allData.first(where: { $0.dmID == dmID })
        }

        // Item not found
        return nil
    }
    
    // MARK: --- NewDataMatrix
    func newDataMatrix(rawData: String, imageData: Data? = nil) throws -> Result< DataMatrix?, DataMatrixError > {
        // Check for duplicates
        if let existing = allData.first(where: { $0.rawData == rawData }) {
            throw DataMatrixError.alreadyScanned(dmCDid: existing.dmID)
        }
        
        let newItem = DataMatrix(
            dmID: nextSequenceNo,
            dateScanned: Date(),
            imageData: imageData,
            rawData: rawData,
            upuCountryID: String(rawData.prefix(4))
        )
        
        nextSequenceNo += 1
        Task { try await store.save( newItem ) }
        allData.append(newItem)
        return .success(newItem)
    }
    
    // MARK: --- Delete
    func delete(_ item: DataMatrix) async throws {
        try await store.delete(item)
        allData.removeAll { $0.dmID == item.dmID }
    }
    
    // MARK: --- DeleteAll
    func deleteAll() async throws {
        try await store.deleteAll()
        allData.removeAll()
        nextSequenceNo = 1
    }
    
    // MARK: --- Helpers
    private func computeNextSequenceNo(from items: [DataMatrix]) -> Int32 {
        var maxId: Int32 = 0
        for item in items {
            if item.dmID > maxId { maxId = item.dmID }
        }
        return maxId + 1
    }
    
    // MARK: --- Errors
    enum DataMatrixError: Error {
        case alreadyScanned(dmCDid: Int32)
    }
}


// For previews (if we need it)
final class DummyPersistenceStore: PersistenceStore {

    typealias Model = DataMatrix

    func fetchAll() async throws -> [DataMatrix] { [] }
    func fetch(dmCDid: Int32) async throws -> DataMatrix? {
        DataMatrix(dmID: 0)
    }
    func save(_ item: DataMatrix) async throws {}
    func delete(_ item: DataMatrix) async throws {}
    func deleteAll() async throws {}
}
