//
//  SettingsView.swift
//  MachinDataMatrix
//
//  Created by Anthony Stanners on 15/06/2025.
//


import SwiftUI
import ItMkLibrary
import CoreData

struct SettingsView: View {
    
    @Environment(\.managedObjectContext) var context
    @Environment(\.isPresented) var isPresented
    @Environment( DMSettings.self ) var dmSettings
    @EnvironmentObject var router: Router
    
    let homePageURL = URL(string: "https://www.ncr.com")!
    let defaultURL  = URL(string: "https://www.google.com")!
    
    var body: some View {
        
        ZStack {
            
            BackGround()
            
            List {
                
                applicationDescription
                settings
                boilerPlate
                if dmSettings.developerMode {
                    debugActions
                }
                
                applicationInformation
            }
            .foregroundColor(.textBlue)
            .scrollContentBackground(.hidden)
            .navigationTitle("Settings")
        } .onChange(of: isPresented) {
            if !isPresented {
                router.navigateBack( from: .settingsView )
            }
        }
//        .navigationBarHidden(true)
        // TODO: Why do we need our own back button here?
//        .navigationBarBackButtonHidden( true )
//        .toolbar {
//            ToolbarItem (placement: .topBarLeading) {
//                Button("<Back") {
//                    router.navigateBack( from: .settingsView )
//                } .foregroundColor(.textBlue )
//            }
//        }
    }
}

extension SettingsView {
    
    @ViewBuilder private var settings: some View {
        
        @Bindable var dmSettings = dmSettings
        
        Section( header: Text("Adjustable Settings")) {
            
            settingLineView(systemImageName: "square.and.arrow.up.circle", color: .green, title: "Show Status Bar", setting: $dmSettings.showStatusBar )
            
            settingLineView(systemImageName: "display", color: .black, title: "Developer Mode", setting: $dmSettings.developerMode )
            

            Button("Reset Adjustable Settings"){
                dmSettings.resetSettings()
            }
            .buttonStyle(BorderlessButtonStyle())
            .foregroundColor( .red )
    
        }
    }

    
    private var applicationDescription: some View {
        
        Section( header: Text("Machin DataMatrix Barcode Scanner")) {

            HStack {
                Image("Logo")
                    .resizable()
                    .frame(width: 80, height: 80 )
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                
                Text("A program to scan and interpret DataMatrix barcodes on stamps. Currently British Machin Stamps are supported.")
                    .font(.caption2)
                    .fontWeight(.medium)
                    .foregroundColor( .textBlue )
            }
            .padding( .vertical )

        }
    }
    
    private var boilerPlate: some View {
        
        Section( header: Text("The Boiler Plate")) {
            Link("Terms of Service", destination: defaultURL)
            Link("Privacy Policy", destination: defaultURL)
            Link("Company Website", destination: defaultURL)
            Link("Learn more...", destination: defaultURL)
        }
    }
    
    private var debugActions: some View {
        
        Section( header: Text("Debug Actions")) {
            
            Button("Show CoreData Summary") {
                router.navigate(to: .debugView)
            }
            
            Button("Delete all CoreData (Not Implemented)") {
//                let deleteRequest = NSBatchDeleteRequest(fetchRequest: flashCardStores)
//                do {
//                try context!.execute(deleteRequest, with: context)
//                }
//                catch {
//                print(error.localizedDescription)
//                }
           }
            
        }
    }
    
    private var applicationInformation: some View {
        
        Section( header: Text("Application Information")) {
            Text("Release Version Number: \(gReleaseVersionNumber) \nBuild Version Number: \(gBuildVersionNumber)")
                .font(.caption)
        }
    }
}


struct settingLineView: View {

    var systemImageName: String
    var color: Color
    var title: String
    @Binding var setting: Bool
    var action: ()->() = {}
    
    var body: some View {
        
        ZStack{
            
            HStack {
                
                    Image(systemName: systemImageName )
                        .foregroundColor( color )
                    Text( title )
                        .font(.callout)
                        .foregroundColor( .textBlue )
                
                Spacer()
                
                Toggle("", isOn: $setting )
                    .onChange(of: setting) { setting in
                        action()
                    }
                
            }.frame(width: 310 )
        }
    }
}
