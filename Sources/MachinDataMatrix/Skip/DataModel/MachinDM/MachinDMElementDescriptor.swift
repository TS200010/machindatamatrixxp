//
//  MachinDMElementDescriptor.swift
//  MachinDataMatrix
//
//  Created by Anthony Stanners on 20/07/2025.
//

import Foundation


struct MachinDMElementDescriptor: BCElementDescriptor, RequiresBCEnumProtocol {
    
    typealias DMEnum = MachinDMElementType
    
    var dmElementType: MachinDMElementType
    
    var startPos: Int
    var length: Int
    var description: String = ""
    
}
