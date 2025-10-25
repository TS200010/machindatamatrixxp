//
//  MachinDM.swift
//  MachinDM
//
//  Created by Anthony Stanners on 30/08/2024.
//

import Foundation


    /// A Type that represents a Machin DataMatrix code
struct MachinDM : BC {

    
    // MARK: --- DM Conformance
  
    static let visiblyIdenticalFields: [ MachinDMElementType ] = [.productType, .stampType, .classXXX, .value ]
    
    var rawData: String = ""
    
    var BCType: BCType  = .MachinDM
    
    var UPUCountryID: (any BCElement)? = nil
    
    var elementDescriptors: [ AnyHashable  :  any BCElement ]  = [ : ]
    
    init() {
        self.rawData = ""
        self.BCType = .MachinDM
        self.elementDescriptors = [:]
        self.UPUCountryID = nil
    }

    
    init( rawData: String ) {
        
        guard rawData != "" else {
            return
        }
        
        self.rawData = rawData
        
        self.UPUCountryID = MachinDMElement(elementDescriptor: MachinDM.UPUCountryIDDescr,
                                       value: getElementValue(using: MachinDM.UPUCountryIDDescr))
        
        self.elementDescriptors = [
            
            MachinDMElementType.UPUCountryID : MachinDMElement(elementDescriptor: MachinDM.UPUCountryIDDescr,
                                                     value: getElementValue(using: MachinDM.UPUCountryIDDescr)),
            
            MachinDMElementType.productType : MachinDMElement(elementDescriptor: MachinDM.productTypeDescr,
                                                    value: getElementValue(using: MachinDM.productTypeDescr)),
            
            MachinDMElementType.versionNumber : MachinDMElement(elementDescriptor: MachinDM.versionNumberDescr,
                                                      value: getElementValue(using: MachinDM.versionNumberDescr)),
            
            MachinDMElementType.stampType : MachinDMElement(elementDescriptor: MachinDM.stampTypeDescr,
                                                  value: getElementValue(using: MachinDM.stampTypeDescr)),
            
            MachinDMElementType.classXXX : MachinDMElement(elementDescriptor: MachinDM.classDescr,
                                                 value: getElementValue(using: MachinDM.classDescr)),
            
            MachinDMElementType.container : MachinDMElement(elementDescriptor: MachinDM.containerDescr,
                                                  value: getElementValue(using: MachinDM.containerDescr)),
            
            MachinDMElementType.supplyChain : MachinDMElement(elementDescriptor: MachinDM.supplyChainDescr,
                                                    value: getElementValue(using: MachinDM.supplyChainDescr)),
            
            MachinDMElementType.item : MachinDMElement(elementDescriptor: MachinDM.itemDescr,
                                             value: getElementValue(using: MachinDM.itemDescr)),
            
            MachinDMElementType.sheetPos : MachinDMElement(elementDescriptor: MachinDM.sheetPosDescr,
                                                 value: getElementValue(using: MachinDM.sheetPosDescr)),
            
            MachinDMElementType.value : MachinDMElement(elementDescriptor: MachinDM.valueDescr,
                                              value: getElementValue(using: MachinDM.valueDescr)),
            
            MachinDMElementType.date : MachinDMElement(elementDescriptor: MachinDM.dateDescr,
                                             value: getElementValue(using: MachinDM.dateDescr)),
            
            MachinDMElementType.campaign : MachinDMElement(elementDescriptor: MachinDM.campaignDescr,
                                                 value: getElementValue(using: MachinDM.campaignDescr)),
            
            MachinDMElementType.checksum : MachinDMElement(elementDescriptor: MachinDM.checksumDescr,
                                                 value: getElementValue(using: MachinDM.checksumDescr)),
            
        ]
        
    }
    
/// A funtion that returns true if the the supplied DM
        /// - Parameter dmIn: the DM to be compared against
        /// - Returns: true if the DM supplied is visually identical to self
    func isVisiblyIdentical( to dmIn: any BC ) -> Bool {
        
        // Casts that make the following code easier to read
        let lhs = self.elementDescriptors as! [ MachinDMElementType : MachinDMElement ]
        let rhs = dmIn.elementDescriptors as! [ MachinDMElementType : MachinDMElement ]
        
        let b = MachinDM.visiblyIdenticalFields.allSatisfy() { lhs[ $0 ] == rhs[ $0 ] }
        return b
    }
    
    
    // MARK: --- Fields unique to Machin DataMatrixes (MDMs)
    static let UPUCountryIDLen = 4
    static let productTypeLen = 1
    static let versionNumberLen = 1
    static let stampTypeLen = 1
    static let classLen = 1
    static let containerLen = 1
    static let supplyChainLen = 7
    static let itemLen = 5
    static let sheetPosLen = 3
    static let valueLen = 5
    static let dateLen = 6
    static let campaignLen = 2
    static let paddingLen = 15
    static let checksumLen = 18
    
    static let totalLen = 70
    
    static let UPUCountryIDDescr  = MachinDMElementDescriptor(
                                                dmElementType: MachinDMElementType.UPUCountryID,
                                                startPos:       0,
                                                length:         UPUCountryIDLen,
                                                description:    "UPU Country ID")
    
    static let productTypeDescr   = MachinDMElementDescriptor(
                                                dmElementType: MachinDMElementType.productType,
                                                startPos:       UPUCountryIDDescr.endPos + 1,
                                                length:         productTypeLen,
                                                description:    "Product Type"   )
    
    static let versionNumberDescr = MachinDMElementDescriptor(
                                                dmElementType: MachinDMElementType.versionNumber,
                                                startPos:       productTypeDescr.endPos + 1,
                                                length:         versionNumberLen,
                                                description:    "Version Number")
    
    static let stampTypeDescr     = MachinDMElementDescriptor(
                                                dmElementType: MachinDMElementType.stampType,
                                                startPos:       versionNumberDescr.endPos + 1,
                                                length:         stampTypeLen,
                                                description:    "Format / Stamp Type")
    
    static let classDescr         = MachinDMElementDescriptor(
                                                dmElementType: MachinDMElementType.classXXX,
                                                startPos:       stampTypeDescr.endPos + 1,
                                                length:         classLen,
                                                description:    "Class of Service")
    
    static let containerDescr     = MachinDMElementDescriptor(
                                                dmElementType: MachinDMElementType.container,
                                                startPos:       classDescr.endPos + 1,
                                                length:         containerLen,
                                                description:    "Container / Print Type")
    
    static let supplyChainDescr   = MachinDMElementDescriptor(
                                                dmElementType: MachinDMElementType.supplyChain,
                                                startPos:       containerDescr.endPos + 1,
                                                length:         supplyChainLen,
                                                description:    "Supply Chain ID")
    
    static let itemDescr          = MachinDMElementDescriptor(
                                                dmElementType: MachinDMElementType.item,
                                                startPos:       supplyChainDescr.endPos + 1,
                                                length:         itemLen,
                                                description:    "Item ID")
    
    static let sheetPosDescr      = MachinDMElementDescriptor(
                                                dmElementType: MachinDMElementType.sheetPos,
                                                startPos:       itemDescr.endPos + 1,
                                                length:         sheetPosLen,
                                                description:    "Sheet Position")
    
    static let valueDescr         = MachinDMElementDescriptor(
                                                dmElementType: MachinDMElementType.value,
                                                startPos:       sheetPosDescr.endPos + 1,
                                                length:         valueLen,
                                                description:    "Value")
    
    static let dateDescr          = MachinDMElementDescriptor(
                                                dmElementType: MachinDMElementType.date,
                                                startPos:       valueDescr.endPos + 1,
                                                length:         dateLen,
                                                description:    "Date Printed")
    
    static let campaignDescr      = MachinDMElementDescriptor(
                                                dmElementType: MachinDMElementType.campaign,
                                                startPos:       dateDescr.endPos + 1,
                                                length:         campaignLen,
                                                description:    "Campaign")
    
    
    static let checksumDescr      = MachinDMElementDescriptor(
                                                dmElementType: MachinDMElementType.checksum,
                                                startPos:       paddingLen + campaignDescr.endPos + 1,
                                                length:         checksumLen,
                                                description:    "Checksum")
}
