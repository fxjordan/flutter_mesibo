import Flutter
import UIKit
import os.log
import mesibo

/// OSLog extension to add a logger specific for the Mesibo iOS binding
extension OSLog {
    private static var subsystem = Bundle.main.bundleIdentifier!
    
    static let mesiboIosBinding = OSLog(subsystem: subsystem, category: "mesiboIosBinding")
}

public class SwiftFlutterMesiboPlugin: NSObject, FlutterPlugin {
    
    var delegatingConnectionListener: DelegatingMesiboConnectionListener!
    var delegatingMessageListener: DelegatingMesiboMessageListener!
    var realTimeApiImpl: IosMesiboRealTimeApi!
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let instance = SwiftFlutterMesiboPlugin()
        instance.setupMesiboPlatformBinding(registrar: registrar)
    }
    
    /// Creates the platform specific API implementations and registers them with the Flutter.
    private func setupMesiboPlatformBinding(registrar: FlutterPluginRegistrar) {
        let targetConnectionListener = MSBOMesiboConnectionListener.init(binaryMessenger: registrar.messenger())
        self.delegatingConnectionListener = DelegatingMesiboConnectionListener.init(targetListener: targetConnectionListener)
        Mesibo.getInstance()!.addListener(self.delegatingConnectionListener)
        
        let targetMessageListener = MSBOMesiboMessageListener.init(binaryMessenger: registrar.messenger())
        self.delegatingMessageListener = DelegatingMesiboMessageListener.init(targetListener: targetMessageListener)
        Mesibo.getInstance()!.addListener(self.delegatingMessageListener)
        
        self.realTimeApiImpl = IosMesiboRealTimeApi.init(messageListener: self.delegatingMessageListener)
        MSBOMesiboRealTimeApiSetup(registrar.messenger(), realTimeApiImpl)
        
        // General Mesibo configuration
        // TODO maybe refactor into own initMesibo method as we do on Android
        Mesibo.getInstance()!.setSecureConnection(true)
    }
}
