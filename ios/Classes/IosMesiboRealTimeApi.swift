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
    
    init(messageListener: MesiboDelegate) {
        self.messageListener = messageListener
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
        
        let params = toMesiboMessageParams(source: cmd.params!)
        let data = cmd.data?.data
        let mid = cmd.mid!.uint32Value
        
        let resultCode = Mesibo.getInstance()!.sendMessage(params, msgid: mid, data: data)
        
        let result : MSBOSendMessageResult = MSBOSendMessageResult.init()
        result.result = resultCode as NSNumber
        return result
    }
    
    private func toMesiboMessageParams(source: MSBOMessageParams) -> MesiboParams {
        let params = MesiboParams.init()
        
        // Map all properties
        if (source.mid != nil) {
            params.mid = source.mid!.uint64Value
        }
        if (source.peer != nil) {
            params.peer = source.peer
        }
        if (source.groupId != nil) {
            params.groupid = source.groupId!.uint32Value
        }
        if (source.profile != nil && source.profile?.do_not_use_in_app_code_isProfileNull != true) {
            /*
             * BUG WORKAROUND: Check docs on UserProfile in pigeons/mesibo.dart template.
             */
            params.profile = toMesiboUserProfile(source: source.profile!)
        }
        if (source.groupProfile != nil && source.groupProfile?.do_not_use_in_app_code_isProfileNull != true) {
            /*
             * BUG WORKAROUND: Check docs on UserProfile in pigeons/mesibo.dart template.
             */
            params.groupProfile = toMesiboUserProfile(source: source.groupProfile!)
        }
        if (source.expiry != nil) {
            params.expiry = source.expiry!.int32Value
        }
        if (source.type != nil) {
            params.type = source.type!.int32Value
        }
        if (source.ts != nil) {
            params.ts = source.ts!.uint64Value
        }
        if (source.flag != nil) {
            params.flag = source.flag!.uint32Value
        }
        if (source.origin != nil) {
            params.origin = source.origin!.int32Value
        }
        if (source.status != nil) {
            params.status = source.status!.int32Value
        }

        return params
    }
    
    private func toMesiboUserProfile(source: MSBOUserProfile) -> MesiboUserProfile {
        let profile = MesiboUserProfile.init()

        // Map all properties
        if (source.name != nil) {
            profile.name = source.name
        }
        if (source.address != nil) {
            profile.address = source.address
        }
        if (source.groupId != nil) {
            profile.groupid = source.groupId!.uint32Value
        }
        if (source.status != nil) {
            profile.status = source.status
        }
        if (source.picturePath != nil) {
            profile.picturePath = source.picturePath
        }
        if (source.draft != nil) {
            profile.draft = source.draft
        }
        if (source.unread != nil) {
            profile.unread = source.unread!.int32Value
        }
        // TODO add 'other' property
        if (source.flag != nil) {
            profile.flag = source.flag!.uint32Value
        }

        return profile
    }
}
