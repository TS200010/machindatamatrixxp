//
//  BC.swift
//  BarCode
//
//  Created by Anthony Stanners on 20/07/2025.
//

import Foundation

// MARK: --- BCType
public enum BCType {
    case MachinDM
    case undefined
}

// MARK: --- BCInitializable
public protocol BCInitializable: BC {
    static func from(rawData: String) -> Self
//    init(rawData: String)
}

//// MARK: --- BCFactory
///// Thread-safe, SKIP-compatible registry for barcode types
//public final class BCFactory {
//
//    private var registry: [BCType: (String) -> any BC] = [:]
//    private let queue = DispatchQueue(label: "BCFactory.registry.queue")
//
//    public init() {} // allow multiple instances if needed
//
//    /// Register a concrete BC type with its creator closure
//    public func register(typeIdentifier: BCType, creator: @escaping (String) -> any BC) {
//        queue.sync {
//            registry[typeIdentifier] = creator
//        }
//    }
//
//    /// Create a BC instance for a given type and raw data
//    public func makeBC(type: BCType, rawData: String) -> (any BC)? {
//        return queue.sync {
//            registry[type]?(rawData)
//        }
//    }
//}


// MARK: --- MakeBC
//func makeBC<T: BCInitializable>(type: T.Type, rawData: String) -> T {
//    return T(rawData: rawData)
//}

// TODO: --- Probably incorrect but we need things to compile
public func makeBC(rawData: String) -> MachinDM {
    return MachinDM(rawData: rawData, dateScanned: Date())
}

// MARK: --- BC
    /// A type that represents a generic BarCode
public protocol BC: Equatable {
    
    /// A link to the DataMatrix representing this BarCode
    var dmID: Int32? { get }
    
    /// A copy of the rawData backing up the BC
    var rawDataCopy: String { get }
    
    /// A copy if the date the rawData scan was made
    var dateScannedCopy: Date? { get }
    
    /// The BarCode  Logical Type, which is the first field in the BarCode and determined during initialisation from the rawData
    var bcType: BCType { get }
    
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

//extension BC {
//    
//    @MainActor
//    func dateScanned(from store: DMStore) -> Date? {
//        guard let id = dmID else { return nil }
//        return store.allData.first(where: { $0.dmID == id })?.dateScanned
//    }
//    
//    @MainActor
//    func rawData(from store: DMStore) -> String {
//        guard let id = dmID else { return "" }
//        return store.allData.first(where: { $0.dmID == id })?.rawData ?? ""
//    }
//    
//    @MainActor
//    func getElementValue(using descriptor: BCElementDescriptor, from store: DMStore) -> String {
//        let data = rawData(from: store)
//        guard !data.isEmpty else { return "" }
//        let startIndex = data.index(data.startIndex, offsetBy: descriptor.startPos)
//        let endIndex = data.index(startIndex, offsetBy: descriptor.length)
//        return String(data[startIndex..<endIndex])
//    }
//}

extension BC {

    // MARK: --- Init Helpers
    /// Private method to determine the BarCode Type from the raw data.
    private func _determinBCType( from rawData: String ) -> BCType {
        
        return .MachinDM
    }

    
    /// A method that returns the raw data value of the Element defined by the supplied BCElementDescriptor
    /// - Parameter from: BCElementDescriptor that defines the element to get the value from.
    /// - Returns: The raw data value of the element as a String.
    public func getElementValue( using: BCElementDescriptor ) -> String {
        
        let startIndex = rawDataCopy.startIndex
        let firstCharIndex = rawDataCopy.index(startIndex, offsetBy: using.startPos )
        let lastCharIndex =  rawDataCopy.index(firstCharIndex, offsetBy: using.length-1 )
        return String( rawDataCopy [ firstCharIndex ... lastCharIndex ] )
    }
}


// MARK: --- Equatable Conformance
//extension BC {
//    
//    /// Default implementation of the Equatable protocol for DM.
//    public static func == (lhs: Self, rhs: Self) -> Bool {
//        lhs.rawDataCopy == rhs.rawDataCopy
//    }
//
//}

// MARK: --- UPUCountryCode
extension BC {
    /// Returns the UPU country code for this barcode
    var UPUCountryCode: UPUCountryIDs {
        switch bcType {
        case .MachinDM:
            // Only MachinDM has upuCountryID
            if let machin = self as? MachinDM {
                return machin.UPUCountryID ?? .noUPUCountryID
            } else {
                return .noUPUCountryID
            }
        case .undefined:
            return .noUPUCountryID
        }
    }
}
