//
//  MachinDMElementType.swift
//  MachinDataMatrix
//
//  Created by Anthony Stanners on 21/06/2025.
//

import Foundation

enum MachinDMElementType: Int, Comparable, Hashable, CaseIterable, BCEnumProtocol {
    
    static func < (lhs: MachinDMElementType, rhs: MachinDMElementType) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
    
    case UPUCountryID = 0
    case productType
    case versionNumber
    case stampType
    case classXXX
    case container
    case supplyChain
    case item
    case sheetPos
    case value
    case date
    case campaign
    case checksum
}
