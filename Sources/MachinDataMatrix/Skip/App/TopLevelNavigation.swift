    //
    //  TopLevelNavigation.swift
    //  MachinDataMatrix
    //
    //  Created by Anthony Stanners on 19/07/2025.
    //

import Foundation
import SwiftUI


struct TopLevelNavigation: ViewModifier {
    
    func body( content: Content) -> some View {
        
        content
            .navigationDestination(for: Router.Destination.self) { destination in
                
                switch destination {
                        
                    case .dmScanView:
                        DMScanView( )
                        
                    case .dmCameraView:
                        Text("Show Camera here")
                            //                            .fullScreenCover(isPresented: $viewIsShown) {
                            //                                CameraView2( image: $cameraViewModel.currentFrame)
                            //                                    //                                        .ignoresSafeArea()
                            //                                    //                                DMCameraView( latestScannedObjectID: $latestScannedObjectID )
                            //                            }
                        
                    case .alreadyScannedView ( let dm ):
                        if let dm {
                            SingleRecordView( dmID: dm.dmID, type: .alreadySeen )
                        } else {
                            Text("ERROR-10: Restart the App please.")
                        }
                        
                    case .newlyScannedView ( let dm ):
                        if let dm {
                            SingleRecordView( dmID: dm.dmID, type: .newlySeen )
                        } else {
                            Text("ERROR-11: Restart the App please.")
                        }
                        
                    case .notSpecified:                         // Used in the navigateBack "Hack"
                        Text("ERROR-01: Restart the App please.")
                        
                    case .debugView:
                        Text("Implement Debug View Here")
                        
                    case .settingsView:
                        SettingsView()
                        
                }
                
            }
    }
}


extension View {
    
    func topLevelNavigation() -> some View {
        
        modifier( TopLevelNavigation() )
    }
}
