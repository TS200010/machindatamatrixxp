//
//  Router.swift
//
//
//  Created by Anthony Stanners on 19/06/2025.
//

import SwiftUI
import Observation

// TODO: *** This seems totally ridiculous to have to wrap NavigationStack in Router with functionality that tracks the stack. We do need to ensure that SettingsView is not permitted twice on the stack but NavigationStack does not offer this functiomnality. Attemptimg to implement this requirement and we have ended up having to mirror some of the NavigtionStack functionality.

//protocol DestinationEnumProtocol {
//    
//}
//
//protocol RequiresDestinationEnumProtocol {
//    associatedtype Destination: DestinationEnumProtocol
//}

// TODO: Why is this not @Observable?

@available(iOS 16.0, *)
public final class Router: ObservableObject {
//    
//    init<T: RawRepresentable>(_ destination2: T.Type ) where T.RawValue == Int {
//        
//    }
//    
    
    // TODO: *** We need to pass in the list of destinations. This code is currently un-reusable
    
    public enum Destination: /*Codable,*/ Hashable {
        
        case debugView
        case settingsView
        case dmScanView
        case dmCameraView
        case alreadyScannedView ( Int32 )
        case newlyScannedView ( Int32 )
//        case alreadyScannedView ( DataMatrixCD? )
//        case newlyScannedView ( DataMatrixCD? )
        case notSpecified           // Used in the navigateBack Hack
    }
    
    @Published public var navPath = NavigationPath()
    
    public var showSettingsButton: Bool { get {
        _settingsViewDepth == 0
    }}
    
    public init(){}
    
    private var _settingsViewDepth: Int = 0
    
    public func navigate( to destination: Destination ) {
        
        print( destination )
        print(navPath.count)
        navPath.append( destination )
        
        // The code below tracks how deep Settings and Trainer Views are on the NavigationStack. We do this to prevent these Views being shown if they are on the stack already. I tried doing this with Bool's but now I forget why it didn't work!
        switch destination {
            
        case .settingsView:
            _settingsViewDepth += 1
            
        default:
            // Only increment the depths if they are already on the stack (ie not zero)
            if _settingsViewDepth != 0 {
                _settingsViewDepth += 1
            }
        }
    }
    
    
    public func navigateBack( from source: Destination = .notSpecified ) {
        
        // TODO: --- This is pretty ugly having to pass in where we came from. But if we could pop the stack rather than just remove the last item we would then know where we came from and act accordingly.
        print(navPath.count)
        switch source {
            
        case .settingsView:
            _settingsViewDepth -= 1

            
        default:
            // Only decrement the depths if they are already on the stack (ie not zero)
            if _settingsViewDepth != 0 {
                _settingsViewDepth -= 1
            }
            break
        }
        
        navPath.removeLast()
    }
    
    
    func navigateToRoot() {
        
        navPath.removeLast( navPath.count )
    }
}
