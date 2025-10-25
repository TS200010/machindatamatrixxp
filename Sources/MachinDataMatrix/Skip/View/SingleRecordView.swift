    //
    //  alreadyScannedView.swift
    //  MachinDataMatrix
    //
    //  Created by Anthony Stanners on 05/07/2025.
    //

import SwiftUI
import ItMkLibrary


@objc enum singleRecordViewType: Int32, HasStringRepresentation {
    
    func rawValueAsString() -> String {
        return "Need to implement this"
    }
    
    case newlySeen = 1
    case alreadySeen = 2
    
    func asString() -> String {
        
        switch self {
                
            case .newlySeen:
                return "This is the first time this code has been seen in the current session."
                
            case .alreadySeen:
                return "This code has already been seen in the current session."
                
        }
    }
    
    
    func displayColor() -> Color {
        
        switch self {
                
            case .newlySeen:
                return Color.green
                
            case .alreadySeen:
                return Color.red
        }
    }
}
        

struct SingleRecordView: View {
    
    // MARK: --- Injected
    var dmID: Int32
    var type: singleRecordViewType
    
    
    // MARK: --- Environment
    @Environment(DMStore.self) private var dmStore
    @EnvironmentObject var router: Router
    @Environment(\.dismiss) var dismiss
    
    // MARK: ---
    @State private var dm: DataMatrix?
    
    var body: some View {
//        let dm = store.fetch( dmCDid: dmID)
        
        ZStack {
            
            BackGround()
            
            VStack {
                
                Spacer()
                
                Text( type.asString() )
                    .multilineTextAlignment(.center)
                    .fontWeight( .bold )
                    .foregroundColor( type.displayColor() )
                
                if let dm = dm {
                    List( [dm] , id:\.self) { dm in
                        Section {
                            if ReleaseContents.allowScanDeletion {
                                DMElementsView( dmIDToDisplay: dm.dmID )
                                    .swipeActions( allowsFullSwipe: false) {
                                        Button("Delete", role: .destructive){
                                            // TODO: --- Sort the try here
                                            Task { try await dmStore.delete( dm ) }
                                            //                                        try? context.save()
                                        }
                                        .tint(.red)
                                    }
                            } else {
                                DMElementsView( dmIDToDisplay: dm.dmID )
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)  // Allows background to show right through
                }
                
            }
            .foregroundColor( Color(UIColor.textBlue) )
        }
        .task {
            // run once when the view appears
            dm = await dmStore.fetch(dmCDid: dmID)
        }
    }
    
}
        
        
