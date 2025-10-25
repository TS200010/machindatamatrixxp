//
//  ViewModifiers.swift
//  MachinDataMatrix
//
//  Created by Anthony Stanners on 15/06/2025.
//
//
//import Foundation
//import SwiftUI
//import ItMkLibrary
//
//
//// MARK: --- petToolbar
//
//struct ItMkToolbarTools: ToolbarContent {
//    
//    @EnvironmentObject var router: Router
//    
//    var title: String
//    
//    var body: some ToolbarContent {
//        
//        ToolbarItem( placement: .principal ) {
//            Text( title )
//                .foregroundColor(.textBlue)
//        }
//    
////        if router.showTrainerButton {
////            
////            ToolbarItem (placement: .topBarTrailing) {
////                
////                Button( action: { router.navigate(to: .trainerView) },
////                        label:  { Image( systemName: "person.fill")
////                        .resizable()
////                        .frame( width:25, height: 25)
////                    }
////                )
////                .foregroundColor(.textBlue )
////            }
////        }
//        
//        if router.showSettingsButton {
//            ToolbarItem (placement: .topBarTrailing) {
//                
//                Button( action: { router.navigate(to: .settingsView) },
//                        label:  { Image( systemName: "gearshape")
//                        .resizable()
//                        .frame( width:25, height: 25)
//                    }
//                )
//                .foregroundColor(.textBlue )
//            }
//        }
//    }
//}
//
//
//struct ItMkToolbarVM: ViewModifier {
//    
//    let title: String
//    
//    func body( content: Content ) -> some View {
//        content
//            .toolbar {
//                ItMkToolbarTools( title: title )
//            }
//            .toolbarBackground( .visible )
//            .toolbarBackground( .ultraThinMaterial )
//    }
//}
//
//extension View {
//    func ItMkToolbar( title: String ) -> some View {
//        self.modifier( ItMkToolbarVM( title: title ) )
//    }
//}
