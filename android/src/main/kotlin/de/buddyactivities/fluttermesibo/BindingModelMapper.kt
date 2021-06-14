package de.buddyactivities.fluttermesibo

import com.mesibo.api.Mesibo

/// Mapper from Binding models to native Mesibo models and back.
class BindingModelMapper {

    fun toBindingMessageParams(source: Mesibo.MessageParams): MesiboBinding.MessageParams {
        val params = MesiboBinding.MessageParams()

        // Map all properties
        params.mid = source.mid
        params.peer = source.peer
        params.groupId = source.groupid
        params.profile = toBindingProfile(source.profile)
        params.groupProfile = toBindingProfile(source.groupProfile)
        params.expiry = source.expiry.toLong()
        params.type = source.type.toLong()
        params.ts = source.ts
        params.flag = source.flag.toLong()
        params.origin = source.origin.toLong()
        params.status = source.status.toLong()

        return params
    }

    fun toBindingProfile(source: Mesibo.UserProfile?): MesiboBinding.UserProfile {
        if (source == null) {
            /*
             * BUG WORKAROUND: Check docs on UserProfile in pigeons/mesibo.dart template.
             */
            val nullProfile = MesiboBinding.UserProfile()
            nullProfile.do_not_use_in_app_code_isProfileNull = true
            // Flutter code will transform this back to 'null'
            return nullProfile
        }

        val profile = MesiboBinding.UserProfile()

        // Map all properties
        profile.name = source.name
        profile.address = source.address
        profile.groupId = source.groupid
        profile.status = source.status
        profile.picturePath = source.picturePath
        profile.draft = source.draft
        profile.unread = source.unread.toLong()
        // TODO add 'other' property
        profile.flag = source.flag

        return profile
    }

    fun toMesiboMessageParams(source: MesiboBinding.MessageParams): Mesibo.MessageParams {
        val params = Mesibo.MessageParams()

        // Map all properties
        if (source.mid != null) {
            params.mid = source.mid
        }
        if (source.peer != null) {
            params.peer = source.peer
        }
        if (source.groupId != null) {
            params.groupid = source.groupId
        }
        if (source.profile != null && source.profile.do_not_use_in_app_code_isProfileNull != true) {
            /*
             * BUG WORKAROUND: Check docs on UserProfile in pigeons/mesibo.dart template.
             */
            params.profile = toMesiboProfile(source.profile)
        }
        if (source.groupProfile != null && source.groupProfile.do_not_use_in_app_code_isProfileNull != true) {
            /*
             * BUG WORKAROUND: Check docs on UserProfile in pigeons/mesibo.dart template.
             */
            params.groupProfile = toMesiboProfile(source.groupProfile)
        }
        if (source.expiry != null) {
            params.expiry = source.expiry.toInt()
        }
        if (source.type != null) {
            params.type = source.type.toInt()
        }
        if (source.ts != null) {
            params.ts = source.ts
        }
        if (source.flag != null) {
            params.flag = source.flag.toInt()
        }
        if (source.origin != null) {
            params.origin = source.origin.toInt()
        }
        if (source.status != null) {
            params.status = source.status.toInt()
        }

        return params
    }

    fun toMesiboProfile(source: MesiboBinding.UserProfile): Mesibo.UserProfile {
        val profile = Mesibo.UserProfile()

        // Map all properties
        if (source.name != null) {
            profile.name = source.name
        }
        if (source.address != null) {
            profile.address = source.address
        }
        if (source.groupId != null) {
            profile.groupid = source.groupId
        }
        if (source.status != null) {
            profile.status = source.status
        }
        if (source.picturePath != null) {
            profile.picturePath = source.picturePath
        }
        if (source.draft != null) {
            profile.draft = source.draft
        }
        if (source.unread != null) {
            profile.unread = source.unread.toInt()
        }
        // TODO add 'other' property
        if (source.flag != null) {
            profile.flag = source.flag
        }

        return profile
    }
}