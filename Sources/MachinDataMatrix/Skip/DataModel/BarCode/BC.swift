//
//  BC.swift
//  BarCode
//
//  Created by Anthony Stanners on 20/07/2025.
//

import Foundation

// MARK: --- BCType
enum BCType {
    case MachinDM
    case undefined
}

// MARK: --- BCInitializable
protocol BCInitializable: BC {
    init(rawData: String)
}

// MARK: --- MakeBC
func makeBC<T: BCInitializable>(type: T.Type, rawData: String) -> T {
    return T(rawData: rawData)
}

// MARK: --- BC 
    /// A type that represents a generic BarCode
protocol BC: Equatable {
    
    /// The length of the first field in the BarCode. This identifieds the type of BarCode
//    static var UPUCountryIDLen: Int { get }
    
    /// The raw data read from the BarCode
    var rawData: String { get set }
    
    /// The BarCode Type, which is the first field in the BarCode and determined during initialisation from the rawData
    var BCType: BCType { get set }
    
    /// The UPU Country ID, which is the first field in the BarCode
//    var UPUCountryID: (any DMElement)? { get set }
    
    /// The elements of the BarCode, keyed by their identifier. Note the values are not stored.
    var elementDescriptors: [ AnyHashable : any BCElement ] { get set }
    
    /// A method to initialise the BarCode with raw data read in.
    init()
//    init( rawData: String )
    
    /// A method that returns true if the BarCode is visibly identical to another BarCode.
    func isVisiblyIdentical( to dmIn: any BC ) -> Bool
    
    /// A meethd that returns the value of a BarCode Element using its Descriptor.
    func getElementValue( using: BCElementDescriptor ) -> String
}

// MARK: --- Default Implementations
extension BC {
    
    /// Default implementation of the UPUCountryIDLen property
//    static var UPUCountryIDLen: Int { gUPUCountryIDLen }
    
    /// Default implementation of the BC initializer
//    init( rawData: String ) {
//        
//        self.init()
//        self.rawData = rawData
//        self.BCType = _determinBCType( from: rawData )
//    }

    // MARK: --- Init Helpers
    /// Private method to determine the BarCode Type from the raw data.
    private func _determinBCType( from rawData: String ) -> BCType {
        
        return .MachinDM
    }

    
    /// A method that returns the raw data value of the Element defined by the supplied BCElementDescriptor
    /// - Parameter from: BCElementDescriptor that defines the element to get the value from.
    /// - Returns: The raw data value of the element as a String.
    func getElementValue( using: BCElementDescriptor ) -> String {
        
        let startIndex = rawData.startIndex
        let firstCharIndex = rawData.index(startIndex, offsetBy: using.startPos )
        let lastCharIndex =  rawData.index(firstCharIndex, offsetBy: using.length-1 )
        return String( rawData [ firstCharIndex ... lastCharIndex ] )
    }
}


// MARK: --- Equatable Conformance
extension BC {
    
    /// Default implementation of the Equatable protocol for DM.
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.rawData == rhs.rawData
    }

}
