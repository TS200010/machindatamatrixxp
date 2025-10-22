//
//  PersistenceStore.swift
//  machindatamatrixxp
//
//  Created by Anthony Stanners on 22/10/2025.
//

import Foundation

@MainActor
protocol PersistenceStore {
    associatedtype Model: Codable & Identifiable
    func fetchAll() async throws -> [Model]
    func save(_ item: Model) async throws
    func delete(_ item: Model) async throws
    func deleteAll() async throws
}
