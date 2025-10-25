//
//  BCElement.swift
//  BarCode Element
//
//  Created by Anthony Stanners on 16/06/2025.
//

import Foundation
import ItMkLibrary


/// A type that represents a single Element of a BarCode.
protocol BCElement : Equatable {
    
    /// The type of the Descriptor that defines the properties this Element.
    associatedtype T: BCElementDescriptor
    
    /// A unique identifier for this Element.
    var id: UUID { get }
    
    /// The Descriptor that defines the properties of this Element.
    var elementDescriptor: T { get }
    
    /// The value contained of this Element as a String as it appears in the raw data of the BarCode.
    var value: String { get }
    
    /// A method that returns a description of the BarCode Element.
    func getBCElementDescripton() -> String

}


// MARK: --- Equatable Conformance
extension BCElement {
    
    /// Default implementation of the Equatable protocol for BCElement.
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.value == rhs.value
    }
}

