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
 * An implementation for {@link Mesibo.MessageListener} and {@link Mesibo.ConnectionListener} that
 * delegates to the corresponding method of a given {@link MesiboBinding.MesiboMessageListener}
 * which manages platform channel layer.
 *
 * NOTE: For some reason we can only add a single listener instance through 'Mesibo.addListener(listener)'.
 * Otherwise one of the listeners won't be called. Therefore, we need to implement all listeners in the
 * same class and delegate to the different target listeners that bridge to Flutter.
 */
class DelegatingMessageListener(
        private val targetMessageListener: MesiboBinding.MesiboMessageListener,
        private val targetConnectionListener: MesiboBinding.MesiboConnectionListener,
        private val modelMapper: BindingModelMapper) : Mesibo.MessageListener, Mesibo.ConnectionListener {

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
        targetMessageListener.onMessage(mappedMessage) {}

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
        targetMessageListener.onMessageStatus(mappedParams) {}
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

    override fun Mesibo_onConnectionStatus(statusCode: Int) {

        val status = MesiboBinding.ConnectionStatus()
        status.code = statusCode.toLong()

        // Pass status to Flutter
        targetConnectionListener.onConnectionStatus(status) {}

        // log status change
        val statusName = getConnectionStatusStr(statusCode)
        Log.i(TAG, "Mesibo connection status: $statusName ($statusCode)")
    }

    private fun getConnectionStatusStr(statusCode: Int): String {
        return when (statusCode) {
            Mesibo.STATUS_ACTIVITY -> "activity"
            Mesibo.STATUS_AUTHFAIL -> "auth fail"
            Mesibo.STATUS_CONNECTFAILURE -> "connection failure"
            Mesibo.STATUS_CONNECTING -> "connecting"
            Mesibo.STATUS_MANDUPDATE -> "mandupdate"
            Mesibo.STATUS_NONETWORK -> "no network"
            Mesibo.STATUS_OFFLINE -> "offline"
            Mesibo.STATUS_ONLINE -> "online"
            Mesibo.STATUS_SHUTDOWN -> "shutdown"
            Mesibo.STATUS_SIGNOUT -> "signout"
            Mesibo.STATUS_STOPPED -> "stopped"
            Mesibo.STATUS_UNKNOWN -> "unknown"
            else -> "unexpected status"
        }
    }
}