
//  MachinDMElement.swift
//  MachinDataMatrix
//
//  Created by Anthony Stanners on 20/07/2025.
//

import Foundation

/// A Type represents DataMatrix Element on a UK Machin Stamp
struct MachinDMElement: BCElement, Identifiable
{

    // MARK: --- DMElement Conformance
    typealias T = MachinDMElementDescriptor
    
    let id: UUID = UUID()
    
    var elementDescriptor: MachinDMElementDescriptor
    
    var value: String = ""
    
    var mdmElementType: MachinDMElementType { get {
        return elementDescriptor.dmElementType
    }}
    
    func getBCElementDescripton() -> String {
        
        switch elementDescriptor.dmElementType {
                
            case .UPUCountryID:
                return value
                
            case .productType:
                if value == "S" {
                    return "Stamp"
                }
                else {
                    return "Unknown"
                }
                
            case .versionNumber:
                return value
                
            case .stampType:
                switch value {
                    case "1":
                        return "Letter"
                    case "2":
                        return "Large Letter"
                    case "9":
                        return "Other"
                    default:
                        return "Unknown"
                }
                
                
            case .classXXX:
                switch value {
                    case "1":
                        return "1st Class"
                    case "2":
                        return "2nd Class"
                    case "9":
                        return "Non NVI"
                    default:
                        return "Unknown"
                }
                
            case .container:
                switch value {
                    case "1":
                        return "MFIL"
                    case "2":
                        return "MEIL"
                    case "3":
                        return "MBIL"
                    case "4":
                        return "Make-up"
                    case "5":
                        return "Counter Sheet"
                    case "6":
                        return "Unknown"
                    case "7":
                        return "Christmas Mini"
                    case "8":
                        return "Prestige"
                    case "9":
                        return "Other"
                    case "0":
                        return "FDC"
                    default:
                        return "Unknown"
                }
                
            case .supplyChain:
                return value
                
            case .item:
                return value
                
            case .sheetPos:
                return value
                
            case .value:
                var wip = value
                while wip.first == "0" {
                    wip = String( wip.dropFirst() )
                }
                return wip + "p"
                
            case .date:
                let months = [" ", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
                let dd = value.classicalIndex(from: 0, to: 1)
                let mm = value.classicalIndex(from: 2, to: 3)
                let yy = value.classicalIndex(from: 4, to: 5)
                let mmInt = Int(mm)
                if let mmInt {
                    if mmInt <= 12 {
                        return dd + " " + months[ mmInt ] + " " + "20" + yy
                    }
                }
                return dd + "/" + mm + "/" + yy
                
                
            case .campaign:
                
                switch value {
                    case "01":
                        return "Definitives"
                    case "02":
                        return "Christmas"
                    case "03":
                        return "England"
                    case "04":
                        return "Wales"
                    case "05":
                        return "Scotland"
                    case "06":
                        return "N Ireland"
                    default:
                        return "Unknown"
                }
                
            case .checksum:
                return value
        }
    }
}
