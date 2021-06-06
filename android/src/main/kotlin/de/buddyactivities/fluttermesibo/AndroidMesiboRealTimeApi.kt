/*
 * Copyright (c) BUDDY Activities UG (haftungsbeschränkt) - All Rights Reserved
 *
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 * Proprietary and confidential
 *
 * Written by Felix Jordan <felix.jordan@buddy-app.de>, May, 2021
 */

package de.buddyactivities.fluttermesibo

import android.content.Context
import android.util.Log
import com.mesibo.api.Mesibo
import java.lang.UnsupportedOperationException

/**
 * Android platform specific implementation of the MesiboRealTimeApi defined by the Flutter to
 * platform contract ({@link MesiboBinding}).
 *
 * The class accesses the Mesibo methods through the static {@link Mesibo} instance.
 *
 * @param messageListener the message listener that should handle messages requested through
 *  DB read sessions (e.g., chat summary).
 */
class AndroidMesiboRealTimeApi(private val messageListener: Mesibo.MessageListener, private val context: Context) : MesiboBinding.MesiboRealTimeApi {

    companion object {
        private const val TAG = "MesiboRTApiImpl"
    }

    override fun setAccessToken(cmd: MesiboBinding.SetAccessTokenCommand?) {
        if (BuildConfig.DEBUG && cmd!!.accessToken == null) {
            error("accessToken must not be null")
        }
        val setAccessTokenResult = Mesibo.setAccessToken(cmd!!.accessToken)
        Log.d(TAG, "setAccessToken result code: $setAccessTokenResult")


        /*
         * TODO Separate the setDatabase into an own method
         */
        Mesibo.setDatabase("mydb", 0)
    }

    override fun start() {
        val resultCode = Mesibo.start()
        Log.d(TAG, "mesibo start result code: $resultCode")
    }

    override fun loadChatHistory(cmd: MesiboBinding.LoadChatHistoryCommand?): MesiboBinding.ChatHistoryResult {
        // loads summary (latest messages in all chats)
        val session = Mesibo.ReadDbSession(cmd!!.peerAddress, 0, null, messageListener)

        val messagesReadCount = session.read(cmd.count.toInt())

        val result = MesiboBinding.ChatHistoryResult()
        result.readCount = messagesReadCount.toLong()
        return result
    }

    override fun loadChatSummary(cmd: MesiboBinding.LoadChatSummaryCommand?): MesiboBinding.ChatSummaryResult {
        // loads summary (latest messages in all chats)
        val session = Mesibo.ReadDbSession(null, 0, null, messageListener)
        session.enableSummary(true)

        val messagesReadCount = session.read(cmd!!.count.toInt())

        Log.d(TAG, "read() returned count: $messagesReadCount")

        val result = MesiboBinding.ChatSummaryResult()
        result.readCount = messagesReadCount.toLong()
        return result
    }

    override fun sendMessage(cmd: MesiboBinding.SendMessageCommand?): MesiboBinding.SendMessageResult {
        try {
            val params = toMesiboMessageParams(cmd!!.params)

            Log.d(TAG, "sending message: mid=${cmd.mid}")

            // actually send message
            val resultCode = Mesibo.sendMessage(params, cmd.mid, cmd.data)

            val result = MesiboBinding.SendMessageResult()
            result.result = resultCode.toLong()
            return result
        } catch (e: Exception) {
            Log.e(TAG, "Exception while sending message", e)
            throw e
        }
    }

    private fun toMesiboMessageParams(source: MesiboBinding.MessageParams): Mesibo.MessageParams {
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

    private fun toMesiboProfile(source: MesiboBinding.UserProfile): Mesibo.UserProfile {
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

    /*
     * TODO Remove! The UI launch method was only intended for debugging during first experiments.
     */
    @Deprecated(message = "UI support is dropped when refactoring into a plugin")
    override fun launchBuiltInChatUI() {
        throw UnsupportedOperationException()
    }

}
