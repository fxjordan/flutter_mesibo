import Flutter
import UIKit
import os.log
import mesibo

/// OSLog extension to add a logger specific for the Mesibo iOS binding
extension OSLog {
    private static var subsystem = Bundle.main.bundleIdentifier!
    
    static let mesiboIosBinding = OSLog(subsystem: subsystem, category: "mesiboIosBinding")
}

public class SwiftFlutterMesiboPlugin: NSObject, FlutterPlugin, FlutterApplicationLifeCycleDelegate {
    
    public static let staticInstance = SwiftFlutterMesiboPlugin();
    
    let modelMapper: BindingModelMapper = BindingModelMapper.init()
    var delegatingMesiboListener: DelegatingMesiboListener!
    var realTimeApiImpl: IosMesiboRealTimeApi!
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let instance = SwiftFlutterMesiboPlugin.staticInstance
        
        // listen for life cycle changes
        registrar.addApplicationDelegate(instance)
        os_log("registered", log: OSLog.mesiboIosBinding, type: .info)
        
        // setup Mesibo
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
    
    public func applicationDidBecomeActive(_ application: UIApplication) {
        os_log("applicationDidBecomeActive", log: OSLog.mesiboIosBinding, type: .info)
    }
    
    public func applicationWillTerminate(_ application: UIApplication) {
        os_log("applicationWillTerminate", log: OSLog.mesiboIosBinding, type: .info)
        
        Mesibo.getInstance()!.stop()
    }
    
    public func applicationWillResignActive(_ application: UIApplication) {
        os_log("applicationWillResignActive", log: OSLog.mesiboIosBinding, type: .info)
    }
    
    public func applicationDidEnterBackground(_ application: UIApplication) {
        os_log("applicationDidEnterBackground", log: OSLog.mesiboIosBinding, type: .info)
        
        Mesibo.getInstance()!.stop()
    }
    
    public func applicationWillEnterForeground(_ application: UIApplication) {
        os_log("applicationWillEnterForeground", log: OSLog.mesiboIosBinding, type: .info)
        
        Mesibo.getInstance()!.start()
    }
}
