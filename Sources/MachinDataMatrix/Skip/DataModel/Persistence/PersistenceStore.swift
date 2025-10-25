//
//  PersistenceStore.swift
//  machindatamatrixxp
//
//  Created by Anthony Stanners on 22/10/2025.
//

import Foundation

@MainActor
protocol PersistenceStore {
    func fetchAll() async throws -> [DataMatrix]
//    func fetch(dmCDid: Int32) async throws -> DataMatrix?  // new method
    func save(_ item: DataMatrix) async throws
    func delete(_ item: DataMatrix) async throws
    func deleteAll() async throws
}
