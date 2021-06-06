/*
 * Copyright (c) BUDDY Activities UG (haftungsbeschränkt) - All Rights Reserved
 *
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 * Proprietary and confidential
 *
 * Written by Felix Jordan <felix.jordan@buddy-app.de>, May, 2021
 */

package de.buddyactivities.fluttermesibo

import android.util.Log
import com.mesibo.api.Mesibo

/**
 * A {@link Mesibo.MessageListener} that delegates to the corresponding method of a given
 * {@link MesiboBinding.MesiboMessageListener} that manages platform channel layer.
 */
class DelegatingMessageListener(private val targetListener: MesiboBinding.MesiboMessageListener): Mesibo.MessageListener {

    companion object {
        private const val TAG = "MesiboMsgListnr"
    }

    override fun Mesibo_onMessage(params: Mesibo.MessageParams?, data: ByteArray?): Boolean {

        if (params == null) {
            Log.e(TAG, "recieved message with params=null!")
            return true
        }

        Log.d(TAG, "onMessage (mid=${params.mid} peer=${params.peer}, origin=${params.origin})")

        val mappedMessage = MesiboBinding.MesiboMessage()
        mappedMessage.params = toBindingMessageParams(params)
        mappedMessage.data = data
        // Pass message to Flutter
        targetListener.onMessage(mappedMessage) {}

        return true
    }

    override fun Mesibo_onMessageStatus(params: Mesibo.MessageParams?) {
        if (params == null) {
            Log.e(TAG, "recieved message status with params=null!")
            return
        }

        Log.d(TAG, "onMessageStatus (mid=${params.mid} status=${params.status})")

        val mappedParams = toBindingMessageParams(params)
        // Pass message status to Flutter
        targetListener.onMessageStatus(mappedParams) {}
    }

    override fun Mesibo_onActivity(p0: Mesibo.MessageParams?, p1: Int) {
        TODO("Not yet implemented")
    }

    override fun Mesibo_onLocation(p0: Mesibo.MessageParams?, p1: Mesibo.Location?) {
        TODO("Not yet implemented")
    }

    override fun Mesibo_onFile(p0: Mesibo.MessageParams?, p1: Mesibo.FileInfo?) {
        TODO("Not yet implemented")
    }

    private fun toBindingMessageParams(source: Mesibo.MessageParams): MesiboBinding.MessageParams {
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

    private fun toBindingProfile(source: Mesibo.UserProfile?): MesiboBinding.UserProfile {
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
}