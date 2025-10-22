    //
    //  Globals.swift
    //  MachinDataMatrix
    //
    //  Created by Anthony Stanners on 15/06/2025.
    //

import Foundation
import SwiftUI

    // MARK: --- Globals that track Global State and affect views

@MainActor
@Observable
public class GlobalState {
    static let shared = GlobalState()
    var stampsScanned: Int32 = 0
}

// Helper to access global state easily
extension View {
    var globalState: GlobalState {
        GlobalState.shared
    }
}

    // MARK: --- Globals that do not affect Global State and do not affect views

let gInMemoryCoreDataStore = false
let gUseJSONStoreOnIOS = true
let gViewCheck = true
let gReleaseVersionNumber = 0
let gBuildVersionNumber = 0
let gUPUCountryIDLen = 4


