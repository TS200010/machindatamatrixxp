//
//  BackGround.swift
//  machindatamatrixxp
//
//  Created by Anthony Stanners on 23/10/2025.
//

import Foundation
import SwiftUI
import ItMkLibrary

struct BackGround: View {
    
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [.white, Color(UIColor.backgroundBlue)]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
}
