//
//  IosMesiboRealTimeApi.swift
//  flutter_mesibo
//
//  Created by Felix Jordan on 30.05.21.
//  Copyright © 2021 BUDDY Activities UG (haftungsbeschränkt). All rights reserved.
//

import os.log
import mesibo

class IosMesiboRealTimeApi: MSBOMesiboRealTimeApi {
    
    /// The listener that receives messages of read sessions
    let messageListener: MesiboDelegate
    let modelMapper: BindingModelMapper
    
    init(messageListener: MesiboDelegate, modelMapper: BindingModelMapper) {
        self.messageListener = messageListener
        self.modelMapper = modelMapper
    }
    
    func setAccessToken(_ cmd: MSBOSetAccessTokenCommand, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        os_log("setAccessToken called", log: OSLog.mesiboIosBinding, type: .info)
        
        let result = Mesibo.getInstance()!.setAccessToken(cmd.accessToken)
        os_log("setAccessToken result: %{public}@", log: OSLog.mesiboIosBinding, type: .info, "\(result)")
        
        /*
         * IMPORTANT! We MUST set the database. Otherwise read sesion do NOT work on iOS (read function returns -1)
         */
        let setDbResult = Mesibo.getInstance()!.setDatabase("mydb", resetTables: 0)
        os_log("setDatabaseResult result: %{public}@", log: OSLog.mesiboIosBinding, type: .info, "\(setDbResult)")
    }
    
    func setPushToken(_ cmd: MSBOSetPushTokenCommand, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) ->
            MSBOSetPushTokenResult? {
        os_log("setPushToken called", log: OSLog.mesiboIosBinding, type: .info)
        
        let resultCode = Mesibo.getInstance()!.setPushToken(cmd.pushToken, voip: false)
        os_log("setPushToken result: %{public}@", log: OSLog.mesiboIosBinding, type: .info, "\(resultCode)")
        
        let result = MSBOSetPushTokenResult.init()
        result.result = resultCode as NSNumber
        return result
    }
    
    func start(_ error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        os_log("start called", log: OSLog.mesiboIosBinding, type: .info)
        
        let resultCode: Int32 = Mesibo.getInstance()!.start()
        os_log("Mesibo start result code: %{public}@", log: OSLog.mesiboIosBinding, type: .info, "\(resultCode)")
    }
    
    func stop(_ error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        os_log("stop called", log: OSLog.mesiboIosBinding, type: .info)
        
        let resultCode: Int32 = Mesibo.getInstance()!.stop()
        os_log("Mesibo stop result code: %{public}@", log: OSLog.mesiboIosBinding, type: .info, "\(resultCode)")
    }
    
    func loadChatHistory(_ cmd: MSBOLoadChatHistoryCommand, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) -> MSBOChatHistoryResult? {
        os_log("loadChatHistory called", log: OSLog.mesiboIosBinding, type: .info)
        
        let session: MesiboReadSession = MesiboReadSession.init()
        session.initSession(cmd.peerAddress, groupid: 0, query: nil, delegate: self.messageListener)
        let messageReadCount: Int32 = session.read(cmd.count!.int32Value)
        
        os_log("chatHistoryReadCount: %{public}@", log: OSLog.mesiboIosBinding, type: .info, "\(messageReadCount)")
        
        let result : MSBOChatHistoryResult = MSBOChatHistoryResult.init()
        result.readCount = messageReadCount as NSNumber
        return result
    }
    
    func loadChatSummary(_ cmd: MSBOLoadChatSummaryCommand, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) -> MSBOChatSummaryResult? {
        os_log("loadChatSummary called", log: OSLog.mesiboIosBinding, type: .info)
        
        let session: MesiboReadSession = MesiboReadSession.init()
        session.initSession(nil, groupid: 0, query: nil, delegate: self.messageListener)
        session.enableSummary(true)
        let messageReadCount: Int32 = session.read(cmd.count!.int32Value)
        
        os_log("summaryReadCount: %{public}@", log: OSLog.mesiboIosBinding, type: .info, "\(messageReadCount)")
        
        let result : MSBOChatSummaryResult = MSBOChatSummaryResult.init()
        result.readCount = messageReadCount as NSNumber
        return result
    }
    
    func sendMessage(_ cmd: MSBOSendMessageCommand, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) -> MSBOSendMessageResult? {
        os_log("sendMessage called", log: OSLog.mesiboIosBinding, type: .info)
        
        let params = modelMapper.toMesiboMessageParams(source: cmd.params!)
        let data = cmd.data?.data
        let mid = cmd.mid!.uint32Value
        
        let resultCode = Mesibo.getInstance()!.sendMessage(params, msgid: mid, data: data)
        
        let result : MSBOSendMessageResult = MSBOSendMessageResult.init()
        result.result = resultCode as NSNumber
        return result
    }
    
    func getSelfProfile(_ error: AutoreleasingUnsafeMutablePointer<FlutterError?>) -> MSBOUserProfile? {
        let profile = Mesibo.getInstance()!.getSelfProfile()
        
        // TODO fix return type
        return modelMapper.toBindingUserProfile(source: profile)
    }
    
    func getRecentProfiles(_ error: AutoreleasingUnsafeMutablePointer<FlutterError?>) -> MSBOGetRecentProfilesResult? {
        
        let profiles: [MesiboUserProfile] = Mesibo.getInstance()!.getRecentProfiles() as! [MesiboUserProfile]
        
        let mappedProfiles: [MSBOUserProfile] = profiles.map { modelMapper.toBindingUserProfile(source: $0)}.compactMap {$0}
        let result = MSBOGetRecentProfilesResult.init()
        result.profiles = mappedProfiles
        return result
    }
}
