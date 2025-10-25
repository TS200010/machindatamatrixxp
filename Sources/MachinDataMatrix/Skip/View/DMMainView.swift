//
//  ContentView.swift
//  MachinDataMatrix
//
//  Created by Anthony Stanners on 29/08/2024.
//

import SwiftUI
import CoreData
import ItMkLibrary
//import CodeScanneriOS


// let persistenceController = PersistenceController.shared

struct DMMainView: View {
    
    // MARK: --- Environment
    @Environment(DMStore.self) private var dmStore
    @EnvironmentObject var router: Router
//    @EnvironmentObject var cameraModel: CameraDataModel
    @Environment( DMSettings.self ) private var dmSettings
    
    
    // MARK: --- Local State
//    @State var cameraIsShowing: Bool = false
    
    
    // MARK: --- CoreData
    @FetchRequest(
        sortDescriptors: []
    ) var dataMatrixes: FetchedResults<DataMatrixCD>
    
    
    // MARK: --- Helpers
    private func _generateCSVUKMachin( ouputtingRawValues: Bool ) -> URL {
        
        var fileURL: URL!
        var rows: [ String ] = []
        var firstRow = true
        var heading: String = ""
        for dmCD in dataMatrixes {
            let dm = MachinDM(rawData: dmCD.rawData ?? "" )
            let elems = dm.elementDescriptors as! [ MachinDMElementType : MachinDMElement ]
            
            if firstRow {
                for elem in MachinDMElementType.allCases {
                    if heading != "" {
                        heading += ", "
                    }
                    heading += elems[ elem ]?.elementDescriptor.description ?? "Error"
                }
                rows.append( heading )
                firstRow = false
            }

            var rowWIP: String = ""
            
            for elem in MachinDMElementType.allCases {
                if rowWIP != "" {
                    rowWIP += ", "
                }
                if ouputtingRawValues {
                    rowWIP += elems[ elem ]?.value ?? "Error"
                } else {
                    rowWIP += elems[ elem ]?.getBCElementDescripton() ?? "Error"
                }
            }
            
            rows.append( rowWIP )
        }
        
        print(rows)

        // rows to string data
        let stringData = rows.joined(separator: "\n")
        
        do {
            
            let filename = {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd_HH-mm-ss"
                let dateString = formatter.string(from: Date())
                if ouputtingRawValues {
                    return "DataMatrixUKMachinRaw_\(dateString).csv"
                } else {
                    return "DataMatrixUKMachin_\(dateString).csv"
                }
            }()
            
            let path = try FileManager.default.url(for: .documentDirectory,
                                                   in: .allDomainsMask,
                                                   appropriateFor: nil,
                                                   create: false)
            
//            fileURL = path.appendingPathComponent("DataMatrixUKMachin.csv")
            fileURL = path.appendingPathComponent( filename)
            
            // append string data to file
            try stringData.write(to: fileURL, atomically: true , encoding: .utf8)
            print(fileURL!)
            
        } catch {
            print("error generating csv file")
        }
        return fileURL
    }

    
    var body: some View {
        
        BaseNavigationView(title: String( localized: "Stamp DataMatrix Scanner (v\(ReleaseContents.currentRelease))" ) ) {
            
            VStack {
                
//                NavigationLink {
//                    PhotoCollectionView(photoCollection: cameraModel.photoCollection)
//                        .onAppear {
//                            cameraModel.camera.isPreviewPaused = true
//                        }
//                        .onDisappear {
//                            cameraModel.camera.isPreviewPaused = false
//                        }
//                } label: {
//                    Label {
//                        Text("Gallery")
//                    } icon: {
//                        ThumbnailView(image: cameraModel.thumbnailImage)
//                    }
//                }
                
                HStack {
                    
                    Button("Scan") {
                        router.navigate(to: .dmScanView)
                    }
                    .buttonStyle( ItMkButton() )
                    
                    if ReleaseContents.exportCSVs {
                        
                        Button("CSV") {
                            // TODO: --- Show Modal Dialog with the filename
                            let generatedGileURL = _generateCSVUKMachin(ouputtingRawValues: false)
                        }
                        .buttonStyle( ItMkButton() )
                            // TODO: Only enable when there is something to output
                            //                    .disabled(dataMatrixes.count == 0)
                        
                        Button("CSV Raw") {
                            // TODO: --- Show Modal Dialog with the filename
                            let generatedGileURL = _generateCSVUKMachin(ouputtingRawValues: true)
                        }
                        .buttonStyle( ItMkButton() )
                            // TODO: Only enable when there is something to output
                            //                    .disabled(dataMatrixes.count == 0)
                    }
                    
                }
                
                if ReleaseContents.listOfScans {
                    DMDetailView( )
                }
                
                if !gInMemoryCoreDataStore && dmSettings.developerMode {
                    
                    HStack {
                        
                        Button("Destroy Store") {
                            
//                            store.deleteEntity()
                            Task {
                                @MainActor in 
                                try? await dmStore.deleteAll()
                            }
//                            DataMatrixCD.nextSequenceNo = 1
//                            try! context.save()
                        }
                        .buttonStyle( DevButtonRed() )
                    }
                }
            }
        } 
    }
}
    

#Preview {
    DMMainView()
}
