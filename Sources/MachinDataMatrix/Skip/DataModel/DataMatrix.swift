//
//  DataMatrix.swift
//  machindatamatrixxp
//
//  Created by Anthony Stanners on 22/10/2025.
//

import Foundation

public struct DataMatrix: Identifiable, Codable, Equatable, Hashable {
    public var id: Int32 { dmID }
    var dmID: Int32
    var dateScanned: Date?
    var imageData: Data?
    var rawData: String?
}

extension DataMatrix {
    
    var upuCountryID: String? {
        guard let raw = rawData, raw.count >= 4 else { return nil }
        return String(raw.prefix(4))
    }
    
    var upuCountryEnum: UPUCountryIDs {
        guard let code = upuCountryID else { return .noUPUCountryID }
        return UPUCountryIDs.fromString(code)
    }
}

