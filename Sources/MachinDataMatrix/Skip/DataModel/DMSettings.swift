//
//  Settings.swift
//  MachinDataMatrix
//
//  Created by Anthony Stanners on 15/06/2025.
//

import Foundation
import Observation

@Observable
class DMSettings {
    
    var showStatusBar: Bool = true
    var developerMode: Bool = true
    
    func resetSettings() -> Void {
        showStatusBar = true
        developerMode = true
    }
    
}
