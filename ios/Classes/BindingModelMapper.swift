//
//  BindingModelMapper.swift
//  flutter_mesibo
//
//  Created by Felix Jordan on 14.06.21.
//

class BindingModelMapper {
    
    func toBindingMessageParams(source: MesiboParams) -> MSBOMessageParams {
        let params = MSBOMessageParams.init()
        
        // Map all properties
        params.mid = source.mid as NSNumber
        params.peer = source.peer
        params.groupId = source.groupid as NSNumber
        params.profile = toBindingUserProfile(source: source.profile)
        params.groupProfile = toBindingUserProfile(source: source.groupProfile)
        params.expiry = source.expiry as NSNumber
        params.type = source.type as NSNumber
        params.ts = source.ts as NSNumber
        params.flag = source.flag as NSNumber
        params.origin = source.origin as NSNumber
        params.status = source.status as NSNumber
        
        return params
    }
    
    func toBindingUserProfile(source: MesiboProfile!) -> MSBOUserProfile! {
        if (source == nil) {
            return nil
        }
        
        let profile = MSBOUserProfile.init()
        
        // Map all properties
        profile.name = source.getName()
        profile.address = source.getAddress()
        profile.groupId = source.getGroupId() as NSNumber
        profile.status = source.getStatus()
        profile.picturePath = source.getImagePath()
        profile.draft = source.getDraft()
        profile.unread = source.getUnreadCount() as NSNumber
        // TODO add 'other' property
        
        // note: 'flag' removed
        
        return profile
    }
    
    func toMesiboMessageParams(source: MSBOMessageParams) -> MesiboParams {
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
            params.flag = source.flag!.uint64Value
        }
        if (source.origin != nil) {
            params.origin = source.origin!.int32Value
        }
        if (source.status != nil) {
            params.status = source.status!.int32Value
        }

        return params
    }
    
    func toMesiboUserProfile(source: MSBOUserProfile) -> MesiboProfile {
        let profile = MesiboProfile.init()

        // Map all properties
        if (source.name != nil) {
            profile.setName(source.name)
        }
        if (source.address != nil) {
            profile.setAddress(source.address, gid: 0)
        }
        if (source.groupId != nil) {
            profile.setAddress(nil, gid: source.groupId!.uint32Value)
        }
        if (source.status != nil) {
            profile.setStatus(source.status)
        }
        if (source.picturePath != nil) {
            profile.setImageUrl(source.picturePath)
        }
        if (source.draft != nil) {
            profile.setDraft(source.draft)
        }
        // TODO add 'other' property
        
        // note: 'flag' and 'unread' were removed

        return profile
    }
}
