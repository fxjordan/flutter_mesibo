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
    
    let modelMapper: BindingModelMapper = BindingModelMapper.init()
    var delegatingMesiboListener: DelegatingMesiboListener!
    var realTimeApiImpl: IosMesiboRealTimeApi!
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let instance = SwiftFlutterMesiboPlugin()
        instance.setupMesiboPlatformBinding(registrar: registrar)
    }
    
    /// Creates the platform specific API implementations and registers them with the Flutter.
    private func setupMesiboPlatformBinding(registrar: FlutterPluginRegistrar) {
        let targetConnectionListener = MSBOMesiboConnectionListener.init(binaryMessenger: registrar.messenger())
        let targetMessageListener = MSBOMesiboMessageListener.init(binaryMessenger: registrar.messenger())
        
        self.delegatingMesiboListener = DelegatingMesiboListener.init(
            targetMessageListener: targetMessageListener,
            targetConnectionListener: targetConnectionListener,
            modelMapper: modelMapper)
        Mesibo.getInstance()!.addListener(self.delegatingMesiboListener)
        
        self.realTimeApiImpl = IosMesiboRealTimeApi.init(messageListener: self.delegatingMesiboListener, modelMapper: self.modelMapper)
        MSBOMesiboRealTimeApiSetup(registrar.messenger(), realTimeApiImpl)
        
        // General Mesibo configuration
        // TODO maybe refactor into own initMesibo method as we do on Android
        Mesibo.getInstance()!.setSecureConnection(true)
    }
}
