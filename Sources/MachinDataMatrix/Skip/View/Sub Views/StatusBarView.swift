//
//  StatusBarView.swift
//  MachinDataMatrix
//
//  Created by Anthony Stanners on 15/06/2025.
//

import Foundation
import CoreData

import SwiftUI

struct StatusBarView: View {
    
    // MARK: --- Environment
    @Environment( DMSettings.self ) private var dmSettings
    
    // MARK: --- Global State
    @State private var globalState = GlobalState.shared
    
    
    // MARK: --- CoreData
    @FetchRequest(
        sortDescriptors: []
    ) var dmRecords: FetchedResults<DataMatrixCD>
      
    
    // MARK: --- The View Body
    var body: some View {
        
        if dmSettings.showStatusBar {
            
            VStack {
    
                HStack {
                    
                    if ReleaseContents.listOfScans {
                        Text( "\(dmRecords.count) Stamps saved. " )
                    }
                    
                    Text( "\(globalState.stampsScanned) Stamps scanned." )
                }
                .font( .caption2 )
                .foregroundColor( .black )
                
                Text(" ")   // To create a small safe area at the bottom
                    .font( .caption2 )
            }
        }
    }
}
