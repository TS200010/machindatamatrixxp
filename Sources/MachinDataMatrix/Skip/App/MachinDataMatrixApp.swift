import Foundation
import OSLog
import SwiftUI


/// A logger for the MachinDataMatrix module.
let logger: Logger = Logger(subsystem: "ItMk.MachinDataMatrixXP", category: "MachinDataMatrix")

/// The shared top-level view for the app, loaded from the platform-specific App delegates below.
///
/// The default implementation merely loads the `ContentView` for the app and logs a message.
public struct MachinDataMatrixRootView : View {
    
    // MARK: --- Environment
    let persistenceController: any PersistenceStore = PersistenceController.shared
    
    public init() {
    }

    public var body: some View {
        ContentView()
            .task {
                logger.info("Skip app logs are viewable in the Xcode console for iOS; Android logs can be viewed in Studio or using adb logcat")
            }
    }
}

/// Global application delegate functions.
///
/// These functions can update a shared observable object to communicate app state changes to interested views.
public final class MachinDataMatrixAppDelegate : Sendable {
    public static let shared = MachinDataMatrixAppDelegate()

    private init() {
    }

    public func onInit() {
        logger.debug("onInit")
    }

    public func onLaunch() {
        logger.debug("onLaunch")
    }

    public func onResume() {
        logger.debug("onResume")
    }

    public func onPause() {
        logger.debug("onPause")
    }

    public func onStop() {
        logger.debug("onStop")
    }

    public func onDestroy() {
        logger.debug("onDestroy")
    }

    public func onLowMemory() {
        logger.debug("onLowMemory")
    }
}
