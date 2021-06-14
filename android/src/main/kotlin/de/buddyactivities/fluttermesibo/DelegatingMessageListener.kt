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
class DelegatingMessageListener(
        private val targetListener: MesiboBinding.MesiboMessageListener,
        private val modelMapper: BindingModelMapper) : Mesibo.MessageListener {

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
        mappedMessage.params = modelMapper.toBindingMessageParams(params)
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

        val mappedParams = modelMapper.toBindingMessageParams(params)
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
}