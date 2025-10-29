//
//  MDMElementDescriptor.swift
//  MachinDataMatrix
//
//  Created by Anthony Stanners on 30/08/2024.
//

import Foundation

// MARK: --- BCEnum protocols
/// A type that defines BCEnumProtocol. Each flavour a BarCode is required to have an enum that conforms to this protocol
///
public protocol BCEnumProtocol: Hashable {
    
}

/// A type that requires conforming types to have a BCEnumProtocol as an AssociatedType
public protocol RequiresBCEnumProtocol {
    
    associatedtype DMEnum: BCEnumProtocol
}


/// A protocol that defines the structure of a Bar Code Element Descriptor
public protocol BCElementDescriptor {

    var startPos: Int { get set }
    var length: Int { get set }
    var description: String { get set }
    var endPos: Int { get }
}


/// An extension to provide a computed property for the end position of the element
extension BCElementDescriptor {
      
    var endPos: Int { get {
        return startPos + length - 1
    }}
}


