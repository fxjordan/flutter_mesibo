//
//  DelegatingMesiboConnectionListener.swift
//  flutter_mesibo
//
//  Created by Felix Jordan on 31.05.21.
//  Copyright © 2021 BUDDY Activities UG (haftungsbeschränkt). All rights reserved.
//

import os.log
import mesibo

class DelegatingMesiboConnectionListener: NSObject, MesiboDelegate {
    
    let targetListener: MSBOMesiboConnectionListener
    
    init(targetListener: MSBOMesiboConnectionListener) {
        self.targetListener = targetListener
    }
    
    func mesibo_(onConnectionStatus statusCode: Int32) {
        os_log("onConnectionStatus [connectionListener]  (status=%{public}@", log: OSLog.mesiboIosBinding, type: .info, "\(statusCode)")
        
        let status = MSBOConnectionStatus.init()
        status.code = statusCode as NSNumber
        
        targetListener.onConnectionStatus(status) { (error: Error?) in
            //completion
            if (error != nil) {
                os_log("error in Flutter connection listener onStatus: %{public}@", log: OSLog.mesiboIosBinding, type: .error, "\(error)")
            }
        }
    }
}
