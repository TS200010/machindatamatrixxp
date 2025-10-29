    //
    //  DMScanView.swift
    //  MachinDataMatrix
    //
    //  Created by Anthony Stanners on 15/06/2025.
    //

import SwiftUI
import CoreData
import ItMkLibrary
import CodeScanneriOS

    // MARK: --- Try again when we get to XCode 16.2
/*
 import MLKitBarcodeScanning
 import MLKitVision
 import AVFoundation
 
 class ScannerViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
 
 var previewLayer: AVCaptureVideoPreviewLayer!
 
 override func viewDidLoad() {
 super.viewDidLoad()
 setupCamera()
 }
 
 func setupCamera() {
 let session = AVCaptureSession()
 guard let camera = AVCaptureDevice.default(for: .video),
 let input = try? AVCaptureDeviceInput(device: camera) else { return }
 
 session.addInput(input)
 
 let output = AVCaptureVideoDataOutput()
 output.setSampleBufferDelegate(self, queue: DispatchQueue(label: "barcodeQueue"))
 session.addOutput(output)
 
 previewLayer = AVCaptureVideoPreviewLayer(session: session)
 previewLayer.frame = view.bounds
 view.layer.addSublayer(previewLayer)
 
 session.startRunning()
 }
 
 func captureOutput(_ output: AVCaptureOutput,
 didOutput sampleBuffer: CMSampleBuffer,
 from connection: AVCaptureConnection) {
 
 let visionImage = VisionImage(buffer: sampleBuffer)
 visionImage.orientation = .right // adjust based on your device orientation
 
 let options = BarcodeScannerOptions(formats: .dataMatrix)
 let scanner = BarcodeScanner.barcodeScanner(options: options)
 
 scanner.process(visionImage) { barcodes, error in
 guard error == nil, let barcodes = barcodes else { return }
 
 for barcode in barcodes {
 if let rawBytes = barcode.rawBytes {
 let hexString = rawBytes.map { String(format: "%02X", $0) }.joined(separator: " ")
 print("🧾 Raw Hex: \(hexString)")
 } else if let value = barcode.rawValue {
 print("📄 Raw String: \(value)")
 }
 }
 }
 }
 }
 
 */


struct DMScanView: View {
    
    
        // MARK: --- Environment
//    @Environment(DMStore.self) private var dmStore
//    @Environment( \.dismiss ) var dismiss
    @EnvironmentObject var dmStore: DMStore
    @EnvironmentObject var router: Router
    
        // MARK: --- Global State
    @State private var globalState = GlobalState.shared
    
        // MARK: --- Local State
    @State private var isShowingScanner = true
    
    
        // MARK: --- CoreData
//    @FetchRequest(
//        // TODO: --- Sort in ascending sequence order
//        sortDescriptors: [NSSortDescriptor(keyPath: \DataMatrixCD.dmCDid, ascending: false) ]
//    ) var dmRecords: FetchedResults<DataMatrixCD>
//    
//    
    var body: some View {
        
        ZStack {
            
            BackGround()
            
            if ( isShowingScanner ) {
                #if !SKIP
                CodeScanneriOSView(codeTypes: [.dataMatrix], showViewfinder: true, simulatedData: "JGB S11221017031747295130006618032201               BA4953A5854820B601", completion: _scanCompletionHandler)
                #else
                // TODO: --- Add CodeScannerAndroidView
                #endif
            }
        }
    }
    
    
    private func _scanCompletionHandler(result: Result<ScanResult, ScanError>) {
        
        isShowingScanner = false
        
        globalState.stampsScanned += 1
        
        switch result {
            
        case .success(let result):
            
            let details = result.string.components(separatedBy: "\n")
//            let image = result.image
//            let corners = result.corners
//            let bounds = result.bounds
            
            // TODO: Handle the Try? properly
            // If there is more than one result, we ignore all but the first
            let result = try? dmStore.newDataMatrix(
                rawData: details[ 0 ],
                imageData: Data())
            //            let result = dmStore.newDataMatrix(
            //                rawData: details[ 0 ],
            //                imageData: image,
            //                corners: corners,
            //                bounds: bounds )
            
//            print(details[0]._guts)
//            let a:_StringGuts = details[0]._guts
//            print(a)
//            print(details[0].count)
            
            switch result {
                
            case .success( let newDataMatrix ):
                if let newDataMatrix {
                    router.navigateBack() // Pops DMScanView (which is now blank as the camera has gone)
                    router.navigate(to: .newlyScannedView( newDataMatrix.dmID ))
                }
                
            case .failure( let error ):
                switch error {
                    
                case .alreadyScanned (let dm):
                    router.navigateBack() // Pops DMScanView (which is now blank as the camera has gone)
                    router.navigate(to: .alreadyScannedView( dm ))
                    break
//                    
//                case .ERROR_07:
//                    assert( false )
//                    break
//                    
//                case .ERROR_09:
//                    assert( false )
//                    break
                    
                }
            case nil:
                // nil returned should never happen
                assertionFailure("Unexpected nil result in switch")
            }
            
        case .failure(_):
            assert(false)
            break
        }
        
    }
    
}

#Preview {
    DMScanView()
}
