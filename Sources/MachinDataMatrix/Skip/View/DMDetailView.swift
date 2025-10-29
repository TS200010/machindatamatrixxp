//
//  DMDetailView.swift
//  MachinDataMatrix
//
//  Created by Anthony Stanners on 23/06/2025.
//

import SwiftUI
import CoreData
import ItMkLibrary

struct DMDetailView: View {
    
    // MARK: --- Environment
//    @Environment(DMStore.self) private var dmStore
    @EnvironmentObject var dmStore: DMStore

    // MARK: --- The View Body
    var body: some View {
           
        VStack {
            
            List(dmStore.allData, id:\.self) { dm in
                
                Section {
                    #if !SKIP
                    DMElementsView( dmIDToDisplay: dm.dmID )
                        .swipeActions( allowsFullSwipe: false) {
                            Button("Delete", role: .destructive){
                                Task {
                                    try? await dmStore.delete(dm)
                                }
                            }
                            .tint(.red)
                        }
                        .padding(.vertical, 4)
                        .if(gViewCheck) { view in view.border(Color.red) }
                    #else
                    // TODO: Could add a context menu here on Android if it looks better
                    HStack {
                        DMElementsView(dmIDToDisplay: dm.dmID)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Button(role: .destructive) {
                            Task {
                                try? await dmStore.delete(dm)
                            }
                        } label: {
                            Image(systemName: "trash")
                        }
                    }
                    .padding(.vertical, 4)
                    .if(gViewCheck) { view in view.border(Color.red) }
                    #endif
                    
                    Button("Add Photo") {
//                        CameraView(completion: <#T##(Result<PhotoResult, PhotoError>) -> Void#>)
                    }
                    .buttonStyle( ItMkButton( isEnabled: true ) )
                }
                .listStyle(.plain)
                .frame(maxWidth: .infinity, alignment: .center)
                .if( gViewCheck ) { view in view.border( Color.red )}

            }
            .scrollContentBackground(.hidden)

            
        }
        // TODO: Do we need this?
        .background( Color.clear )

        }
    }


#Preview {
    DMDetailView()
}
