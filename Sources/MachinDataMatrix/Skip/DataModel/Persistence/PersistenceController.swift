//
//  PersistenceController.swift
//  machindatamatrixxp
//
//  Created by Anthony Stanners on 24/10/2025.
//

@MainActor
enum PersistenceController {
    #if SKIP
    static let shared: any PersistenceStore = JSONDataMatrixStore.shared
    #else
    static let shared: any PersistenceStore = CoreDataDataMatrixStore.shared
    #endif
}
