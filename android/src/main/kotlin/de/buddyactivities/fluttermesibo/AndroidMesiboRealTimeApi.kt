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

/**
 * Android platform specific implementation of the MesiboRealTimeApi defined by the Flutter to
 * platform contract ({@link MesiboBinding}).
 *
 * The class accesses the Mesibo methods through the static {@link Mesibo} instance.
 *
 * @param messageListener the message listener that should handle messages requested through
 *  DB read sessions (e.g., chat summary).
 */
class AndroidMesiboRealTimeApi(
        private val messageListener: Mesibo.MessageListener,
        private val context: Context,
        private val modelMapper: BindingModelMapper) : MesiboBinding.MesiboRealTimeApi {

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

    override fun setPushToken(cmd: MesiboBinding.SetPushTokenCommand?): MesiboBinding.SetPushTokenResult {
        val success: Boolean = Mesibo.setPushToken(cmd!!.pushToken)
        Log.d(TAG, "setPushToken result: $success")

        val result = MesiboBinding.SetPushTokenResult()
        /*
         * Our assumption is that the result of the native method indicates success/fail. However,
         * on iOS we get an int32 result so we need some investigation on this and interpret
         * the common result type (int32) in the Flutter layer.
         */
        // TODO Check the assumption above
        result.result = if (success) 0 else -1
        return result
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
            val params = modelMapper.toMesiboMessageParams(cmd!!.params)

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

    override fun getSelfProfile(): MesiboBinding.UserProfile {
        val profile: Mesibo.UserProfile? = Mesibo.getSelfProfile()

        return modelMapper.toBindingProfile(profile);
    }
}
