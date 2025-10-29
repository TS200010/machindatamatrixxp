//
//  BaseNavigationView.swift
//  MachinDataMatrix
//
//  Created by Anthony Stanners on 15/06/2025.
//

import SwiftUI
import ItMkLibrary

struct BaseNavigationView<Content: View> : View {
    
    // MARK: --- Injected
    let title: String
    let content: Content
    
    // MARK: --- Environment
//    @EnvironmentObject var router: Router
    
    // MARK: Initialiser
    init( title: String, @ViewBuilder content: () -> Content ) {
        self.content = content()
        self.title = title
    }
    
    // MARK: --- Body
    var body: some View {
        
            ZStack {
                
                BackGround()
                
                content
                
                StatusBarView()
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .ignoresSafeArea()
                
            }
            .if( gViewCheck ) { view in view.border( Color.green ) }
            .foregroundColor( Color(UIColor.textBlue) )
            .ItMkToolbar( title: title )

    }
}

