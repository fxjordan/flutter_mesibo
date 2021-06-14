//
//  DelegatingMesiboMessageListener.swift
//  flutter_mesibo
//
//  Created by Felix Jordan on 31.05.21.
//  Copyright © 2021 BUDDY Activities UG (haftungsbeschränkt). All rights reserved.
//

import os.log
import mesibo

class DelegatingMesiboMessageListener: NSObject, MesiboDelegate {
    
    let targetListener: MSBOMesiboMessageListener
    let modelMapper: BindingModelMapper
    
    init(targetListener: MSBOMesiboMessageListener, modelMapper: BindingModelMapper) {
        self.targetListener = targetListener
        self.modelMapper = modelMapper
    }
    
    func mesibo_(onMessage optParams: MesiboParams!, data: Data!) {
        if (optParams == nil) {
            os_log("recieved message with params=null!", log: OSLog.mesiboIosBinding, type: .error)
        }
        
        let params: MesiboParams = optParams
        
        os_log("onMessage [delegatingListener] (peer=%{public}@, mid=%{public}@, origin=%{public}@",
               log: OSLog.mesiboIosBinding,
               type: .info, "\(params.peer!)", "\(params.mid)", "\(params.origin)")
        
        let mappedMessage = MSBOMesiboMessage.init()
        mappedMessage.params = modelMapper.toBindingMessageParams(source: params)
        mappedMessage.data = FlutterStandardTypedData.init(bytes: data)
        
        targetListener.onMessage(mappedMessage) { (error: Error?) in
            // TODO handle result, if error
        }
    }
    
    func mesibo_(onMessageStatus optParams: MesiboParams!) {
        if (optParams == nil) {
            os_log("recieved message status with params=null!", log: OSLog.mesiboIosBinding, type: .error)
        }
        
        let params: MesiboParams = optParams
        
        os_log("onMessageStatus [delegatingListener] (peer=%{public}@, mid=%{public}@, origin=%{public}@",
               log: OSLog.mesiboIosBinding,
               type: .info, "\(params.peer!)", "\(params.mid)", "\(params.origin)")
        
        let mappedParams = modelMapper.toBindingMessageParams(source: params)
        
        targetListener.onMessageStatus(mappedParams) { (error: Error?) in
            // TODO handle result, if error
        }
    }
    
    func mesibo_(on message: MesiboMessage!) {
        /*
         * IMPORTANT: This method must be implemented by the listener to avoid the following error at runtime:
         *
         * > *** Terminating app due to uncaught exception 'NSInvalidArgumentException',
         * >       reason: '-[Runner.DelegatingMesiboMessageListener Mesibo_OnMessage:]:
         * >         unrecognized selector sent to instance 0x6000026c0620'
         *
         * It seems like Mesibo native code tries to call this method before the other 'onMessage(params, data)' listener method,
         * so we simply do nothing in this method unless required.
         */
        // remove the logging statemet when everything works fine
        os_log("on message (!strange listener method!) (id=%{public}@, type=%{public}@)",
               log: OSLog.mesiboIosBinding,
               type: .info, "\(message.mid)", "\(message.getType())")
    }
}
