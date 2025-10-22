//
//  JSONDataMatrixStore.swift
//  machindatamatrixxp
//
//  Created by Anthony Stanners on 22/10/2025.
//

import Foundation

//#if SKIP
import Foundation

@MainActor
final class JSONDataMatrixStore: PersistenceStore {
    typealias Model = DataMatrix
    static let shared = JSONDataMatrixStore()

    private var folder: URL {
        #if !SKIP
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        #else
        URL(fileURLWithPath: "/tmp/JSONStore")
        #endif
    }

    private var url: URL { folder.appendingPathComponent("DataMatrix.json") }

    func fetchAll() async throws -> [DataMatrix] {
        guard FileManager.default.fileExists(atPath: url.path) else { return [] }
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode([DataMatrix].self, from: data)
    }

    func save(_ item: DataMatrix) async throws {
        var items = try await fetchAll()
        if let index = items.firstIndex(where: { $0.dmCDid == item.dmCDid }) {
            items[index] = item
        } else {
            items.append(item)
        }
        let data = try JSONEncoder().encode(items)
        try data.write(to: url)
    }

    func delete(_ item: DataMatrix) async throws {
        var items = try await fetchAll()
        items.removeAll { $0.dmCDid == item.dmCDid }
        let data = try JSONEncoder().encode(items)
        try data.write(to: url)
    }

    func deleteAll() async throws {
        try? FileManager.default.removeItem(at: url)
    }
}

//#endif

