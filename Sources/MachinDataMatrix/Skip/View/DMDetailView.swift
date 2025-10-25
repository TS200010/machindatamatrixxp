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
    @Environment( \.managedObjectContext ) private var context
    
    
    // MARK: --- CoreData
    @FetchRequest(
        sortDescriptors: [ NSSortDescriptor(key: "dmCDid", ascending: false) ]
    ) var dataMatrixes: FetchedResults<DataMatrixCD>

    // MARK: --- The View Body
    var body: some View {
           
        VStack {
            
            List(dataMatrixes, id:\.self) { dmCD in
                
                Section {
                    DMElementsView( dmCDToDisplay: dmCD )
                        .swipeActions( allowsFullSwipe: false) {
                            Button("Delete", role: .destructive){
                                context.delete( dmCD )
                                try? context.save()
                            }
                            .tint(.red)
                        }
                    
                    Button("Add Photo") {
//                        CameraView(completion: <#T##(Result<PhotoResult, PhotoError>) -> Void#>)
                    }
                    .buttonStyle( ItMkButton() )
                }
                .listStyle(.plain)
                .frame(maxWidth: .infinity, alignment: .center)
                .if( gViewCheck ) { view in view.border( .red )}

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
