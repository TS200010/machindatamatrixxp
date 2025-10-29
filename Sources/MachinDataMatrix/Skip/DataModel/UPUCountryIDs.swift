//
//  UPUCountryIDs.swift
//  MachinDataMatrix
//
//  Created by Anthony Stanners on 21/06/2025.
//

import Foundation
import ItMkLibrary

// TODO: Check Tracked48

// TODO: THere is a lot of magic number processing in here - needs a thorough test set.

@objc public enum UPUCountryIDs: Int32, HasStringRepresentation {
    
    public func rawValueAsString() -> String {
        return "Need to implement this"
    }
    
    
    case UK = 1
    case Generic = 2
    case noUPUCountryID = 99
    
    func asString() -> String {
        
        switch self {
                
            case .UK:
                return "UK"
                
            case .Generic:
                return "Generic"
                
            case .noUPUCountryID:
                return "Undetermined BarCode"
        }
    }
    
    
    static func fromInt( _ i: Int ) -> UPUCountryIDs {
        
        switch i {
            case 1:  return Self.UK
            case 2:  return Self.Generic
            default: return .noUPUCountryID
        }
    }
    
    static func fromInt32( _ i: Int32 ) -> UPUCountryIDs {
        
        return UPUCountryIDs.fromInt( Int( i ) )
    }
    
    static func fromString( _ s: String ) -> UPUCountryIDs {
        switch s {
            case "JGB ": return Self.UK
            case "0100": return Self.Generic
            default: return .noUPUCountryID
        }
    }
    
}

// TODO: --- Implementation needed
@objc enum InformationTypeIDs: Int32, HasStringRepresentation {
    func rawValueAsString() -> String {
        return "Need to implement this"
    }
    
    case domesticSortedAndUnsorted = 0
    case internationalSortedAndUnsorted = 1
    case responseServices = 2
    case tracked48 = 6
    case onlinePostage = 65         // ASCII value 'A'
    case franking = 66              // ASCII value 'B'
    case consolidation = 67         // ASCII value 'C'
    case stamp = 83                 // ASCII value 'S'
    case noInformationTypeID = 99
    
    func asString() -> String {
        
        switch self {
            case .domesticSortedAndUnsorted:
                return "Domestic Sorted and Unsorted"
                
            case .internationalSortedAndUnsorted:
                return "International Sorted and Unsorted"
                
            case .responseServices:
                return "Response Services"
                
            case .tracked48:
                return "Tracked 48"
                
            case .onlinePostage:
                return "Online Postage"
                
            case .franking:
                return "Franking"
                
            case .consolidation:
                return "Consolidation"
                
            case .stamp:
                return "Stamp"
                
            case .noInformationTypeID:
                return "ERROR-12"
        }
    }
    
    
    static func fromInt( _ i: Int ) -> InformationTypeIDs {
        
        switch i {
            case 0:  return Self.domesticSortedAndUnsorted
            case 1:  return Self.internationalSortedAndUnsorted
            case 2:  return Self.responseServices
            case 6:  return Self.tracked48
            case 65:  return Self.onlinePostage
            case 66:  return Self.franking
            case 67:  return Self.consolidation
            case 83:  return Self.stamp
            default: return .noInformationTypeID
        }
    }
    
    
    static func fromInt32( _ i: Int32 ) -> InformationTypeIDs {
        
        return InformationTypeIDs.fromInt( Int( i ) )
    }
    
    
    static func fromString( _ s: String ) -> InformationTypeIDs {
     
        switch s {
            case "0": return Self.domesticSortedAndUnsorted
            case "1": return Self.internationalSortedAndUnsorted
            case "2": return Self.responseServices
            case "6": return Self.tracked48
            case "A": return Self.onlinePostage
            case "B": return Self.franking
            case "C": return Self.consolidation
            case "S": return Self.stamp
            default: return .noInformationTypeID
        }
    }
}


