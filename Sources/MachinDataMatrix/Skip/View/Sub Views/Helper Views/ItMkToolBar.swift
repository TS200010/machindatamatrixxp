//
//  ItMkToolBar.swift
//
//
//  Created by Anthony Stanners on 19/06/2025.
//

import Foundation
import SwiftUI

// MARK: --- ItMkToolbar

@available(iOS 16.0, *)
struct ItMkToolbarTools: ToolbarContent {
    
    @EnvironmentObject var router: Router
    
    var title: String
    
    var body: some ToolbarContent {

        ToolbarItem( placement: .principal ) {
            Text( title )
                .foregroundColor( Color(UIColor.textBlue) )

        }

    
//        if router.showTrainerButton {
//
//            ToolbarItem (placement: .topBarTrailing) {
//
//                Button( action: { router.navigate(to: .trainerView) },
//                        label:  { Image( systemName: "person.fill")
//                        .resizable()
//                        .frame( width:25, height: 25)
//                    }
//                )
//                .foregroundColor(.textBlue )
//            }
//        }
        
        if router.showSettingsButton {
            ToolbarItem (placement: .topBarTrailing) {
                
                Button( action: { router.navigate(to: .settingsView) },
                        label:  { Image( systemName: "gearshape")
                        .resizable()
                        .frame( width:25, height: 25)
                    }
                )
                .foregroundColor( Color(UIColor.textBlue) )
                .if( true ) { view in view.border( .red ) }
            }
        }
 
    }
}


@available(iOS 16.0, *)
struct ItMkToolbarVM: ViewModifier {
    
    let title: String
    
    func body( content: Content ) -> some View {
        content
            .toolbar {
                ItMkToolbarTools( title: title )
            }
//            .toolbarBackground( .visible )
            .toolbarBackground( .ultraThinMaterial )

    }
}


@available(iOS 16.0, *)
extension View {
    public func ItMkToolbar( title: String ) -> some View {
        self.modifier( ItMkToolbarVM( title: title ) )
    }
}
