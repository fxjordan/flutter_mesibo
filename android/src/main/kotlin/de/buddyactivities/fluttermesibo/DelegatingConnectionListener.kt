/*
 * Copyright (c) BUDDY Activities UG (haftungsbeschränkt) - All Rights Reserved
 *
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 * Proprietary and confidential
 *
 * Written by Felix Jordan <felix.jordan@buddy-app.de>, March, 2021
 */

package de.buddyactivities.fluttermesibo

import android.util.Log
import com.mesibo.api.Mesibo

/**
 * A {@link Mesibo.ConnectionListener} that delegates to the corresponding method of a given
 * {@link MesiboBinding.MesiboConnectionListener} that manages platform channel layer.
 */
class DelegatingConnectionListener(private val targetListener: MesiboBinding.MesiboConnectionListener): Mesibo.ConnectionListener {

    companion object {
        private const val TAG = "MesiboConnListnr"
    }

    override fun Mesibo_onConnectionStatus(statusCode: Int) {

        val status = MesiboBinding.ConnectionStatus()
        status.code = statusCode.toLong()

        // Pass status to Flutter
        targetListener.onConnectionStatus(status) {}

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