//
//  ReleaseContents.swift
//  MachinDataMatrix
//
//  Created by Anthony Stanners on 24/06/2025.
//

import Foundation


//struct SingleReleaseContent {
//    
//    var content: [ Bool ]
//}

struct ReleaseContents {
    
//    var content: [ SingleReleaseContent ]
    
    static let currentRelease = 99
    
    // MARK: --- Release 0
    // Beta release
    
    // MARK: --- Release 1
    // Make a single scan and delete it when the next one is made
    static let singleScan =  currentRelease == 1 ? true : false
    
    //static let ABC = 
    
    // MARK: --- Release 2
    // Maintain a list of the scans made in a single session. All scans deleted when App exits
    static let listOfScans = currentRelease >= 2 ? true : false
    
    // MARK: --- Release 3
    // Export all scans in current session to CSV and CSV Raw
    static let exportCSVs = currentRelease >= 3 ? true : false
    
    // Allow Scans to be deleted
    static let allowScanDeletion = currentRelease >= 3 ? true : false
    
    // MARK: --- Release TBD
    // Allows user to add a photo of the item scanned
    static let addPhoto = currentRelease >= 4 ? true : false
    
    // Capture an image of the barcode scanned
    static let barCodeCapture = currentRelease >= 4 ? true : false
    
    // Submits the scan and the image to the master database if it is a new scan not seen before
    static let submitScan = currentRelease >= 4 ? true : false
    
    // Rarity calculations are performed based on number of stamps scanned from all users
    static let rarityCalculations = currentRelease >= 4 ? true : false
    
    // Images are processed by AI to extract the stamp and the code
    static let aiImageProcessing = currentRelease >= 4 ? true : false
    
    // User ranking for who has found the most different stamps
    static let userRanking = currentRelease >= 4 ? true : false
}
