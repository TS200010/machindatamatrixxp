//
//  DMElementsView.swift
//  MachinDataMatrix
//
//  Created by Anthony Stanners on 21/06/2025.
//

import SwiftUI

struct DMElementsView_UKMachin_S: View {
    
    // MARK: --- Injected
    let elements: [ MachinDMElementType : MachinDMElement ]
    
    var body: some View {
        
        VStack {
            
            // TODO: Check all the forced unwrapping below is OK
            ForEach( Array( elements.keys.sorted() ), id: \.self ) { key in
                
                HStack {
                    
                    Text((elements[key]?.elementDescriptor.description)!)
                        //                                .fontWeight(.bold)
                        .font(.caption)
                    
                    let desc = elements[key]?.elementDescriptor.description
                    
                    if desc != "" {
                        
                        let value = elements[key]?.value
                        let elementDesc = elements[key]?.getBCElementDescripton()
                        
                        if value != "" {
                            Text(": ")
                            Text(value!)
                                .fontWeight(.bold)
                                .font(.caption)
                            
                            if (elementDesc != "") && (elementDesc != value) {
                                Text("(")
                                Text((elements[key]?.getBCElementDescripton())!)
                                    .fontWeight(.bold)
                                    .font(.caption)
                                Text(")")
                                
                            }
                        }
                    }
                    else {
                        Text(elements[key]!.value)
                            .fontWeight(.bold)
                            .font(.caption)
                    }
                }
            }
        }
    }
}

struct DMElementsView: View {
    
    // MARK: --- Injected
    let dmIDToDisplay: Int32
    
    // MARK: --- Environment
    @Environment(DMStore.self) private var dmStore
    
    // MARK: --- State
    @State private var dmToDisplay: MachinDM? = nil

    var body: some View {
        
//        let dmCDToDisplay = dmStore.fetch(dmID: dmIDToDisplay )
        
        HStack {
            
            VStack {
                
                if let dmToDisplay {
                    // Pass the upuCountryID field from the BarCode and turn it into a UPUCountrID enum value
                    let upuCountryID = UPUCountryIDs.fromString( dmCDToDisplay.upuCountryID ?? "ERROR-02" )
                    
                    Text("\(upuCountryID.asString())")
                        .fontWeight(.bold)
                    
                    
                    if let rawData = dmCDToDisplay.rawData {
                        let d = dmCDToDisplay.dateScanned
                        let s = dmCDToDisplay.dmID
                        let dateFormatter = Date.FormatStyle(date: .abbreviated, time: .standard)
                        
                        HStack {
                            Text("Scanned:")
                                .font(.caption)
                            Text( d!, format: dateFormatter )
                                .font(.caption)
                            Text("ID: \(s)")
                                .font(.caption)
                        }
                        
                        Text("\(rawData) (\(rawData.count) chs)")
                            .fontWeight(.bold)
                            .font(.caption)
                    }
                    
                    switch upuCountryID {
                        
                    case .UK :
                        let ukMachin = MachinDM(rawData: dmCDToDisplay.rawData ?? "JGB ERROR-03" )
                        let elements = ukMachin.elementDescriptors as!  [ MachinDMElementType : MachinDMElement ]
                        
                        // TODO: Check that the elements are not nil before unwrapping
                        // TODO: Need to account for different Product Types
                        
                        if let p = elements[ .productType ]?.value {
                            
                            switch p {
                                
                            case "S":
                                DMElementsView_UKMachin_S(elements: elements)
                                
                            default:
                                Text("No identifiable fields")
                            }
                        }
                        //                        if elements[ .productType ]?.value == "S" {
                        //
                        //                            DMElementsView_UKMachin_S(elements: elements)
                        //                        } else {
                        //                            Text("No identifiable fields")
                        //                        }
                        
                    case .Generic:
                        Text("No identifiable fields")
                        
                    case .noUPUCountryID:
                        Text("noUPUCountryID")
                    }
                }
                
                
                // TODO: Display image of datamatrix captured
//                let data = dmCDToDisplay.imageData
//                if let data {
//                    if let image = UIImage(data: data ) {
//                        //                   Image( uiImage: image )
//                        //                        .frame(width: 10,height: 10)
//                        //                        .resizable()
//                        //                        .ignoresSafeArea()
//                        //                        .scaledToFit()
//                    }
//                }
            }
        }
        .task {
            do {
                if let fetchedDM = try await dmStore.fetch(dmID: dmIDToDisplay) {
                    dmToDisplay = fetchedDM
                }
            } catch {
                print("Failed to fetch DM:", error)
                // handle error as needed
            }
        }
    }
//        }
//    }
}

//#Preview {
//    DMElementsView( dmToDisplay: MachinDM(input: "") )
//}
