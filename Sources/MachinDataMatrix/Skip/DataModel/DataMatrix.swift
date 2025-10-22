//
//  DataMatrix.swift
//  machindatamatrixxp
//
//  Created by Anthony Stanners on 22/10/2025.
//

import Foundation

struct DataMatrix: Identifiable, Codable, Equatable {
    var id: Int32 { dmCDid } // Use dmCDid as unique identifier
    var dmCDid: Int32
    var dateScanned: Date?
    var imageData: Data?
    var rawData: String?
    var upuCountryID: String?
}
