//
//  Settings.swift
//  MachinDataMatrix
//
//  Created by Anthony Stanners on 15/06/2025.
//

import Foundation
import Observation

class DMSettings: ObservableObject {
    
    @Published var showStatusBar: Bool = true
    @Published var developerMode: Bool = true
    
    func resetSettings() -> Void {
        showStatusBar = true
        developerMode = true
    }
    
}
