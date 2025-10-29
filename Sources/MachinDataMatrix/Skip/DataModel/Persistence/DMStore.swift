//
//  DMStore.swift
//  MachinDataMatrix
//
//  Created by Anthony Stanners on 15/06/2025.
//

import SwiftUI

@MainActor
final class DMStore: ObservableObject {
     
    let store: any PersistenceStore
    
    @Published private(set) var allData: [DataMatrix] = []
    
    private var nextSequenceNo: Int32 = 1
    
    init(store: any PersistenceStore) {
        self.store = store
    }
    
    // MARK: --- Interpreted Computed Porperty
    var interpreted: [any BC] {
        allData.compactMap { interpret($0) }
    }
    
    // MARK: --- Interpret
    private func interpret(_ dm: DataMatrix) -> (any BC)? {
        guard let rawData = dm.rawData else { return nil }

        switch detectType(from: rawData) {
        case .MachinDM:
            return MachinDM(rawData: rawData, dateScanned: dm.dateScanned )
        // Future cases can go here, e.g.:
        // case .XYZType: return XYZDM(rawData: rawData)
        default:
            return nil
        }
    }

    // MARK: --- DetectType
    private func detectType(from rawData: String) -> BCType {
        if rawData.count == MachinDM.totalLen {
            return .MachinDM
        }
        return .undefined
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
//            upuCountryID: String(rawData.prefix(4))
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

// MARK: --- CSV PROCESSING
extension DMStore {
    
    // MARK: --- GenerateCSVUKMachin
    func generateCSVUKMachin(outputtingRawValues: Bool) -> URL? {
        guard !allData.isEmpty else { return nil }

        var rows: [String] = []
        var firstRow = true

        for dmCD in allData {
            let dm = MachinDM(rawData: dmCD.rawData ?? "", dateScanned: dmCD.dateScanned )
            let elems = dm.elementDescriptors as! [MachinDMElementType : MachinDMElement]

            if firstRow {
                let heading = MachinDMElementType.allCases
                    .map { elems[$0]?.elementDescriptor.description ?? "Error" }
                    .joined(separator: ", ")
                rows.append(heading)
                firstRow = false
            }

            let row = MachinDMElementType.allCases
                .map { outputtingRawValues ? (elems[$0]?.value ?? "Error") : (elems[$0]?.getBCElementDescripton() ?? "Error") }
                .joined(separator: ", ")
            rows.append(row)
        }

        let stringData = rows.joined(separator: "\n")

        do {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd_HH-mm-ss"
            let dateString = formatter.string(from: Date())
            let filename = outputtingRawValues
                ? "DataMatrixUKMachinRaw_\(dateString).csv"
                : "DataMatrixUKMachin_\(dateString).csv"

            let folder = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileURL = folder.appendingPathComponent(filename)
            try stringData.write(to: fileURL, atomically: true, encoding: .utf8)
            return fileURL
        } catch {
            print("Failed to generate CSV: \(error)")
            return nil
        }
    }
}


// MARK: --- For previews (if we need it)
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
