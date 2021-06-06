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
import androidx.annotation.NonNull
import com.mesibo.api.Mesibo
import io.flutter.embedding.engine.plugins.FlutterPlugin

/** FlutterMesiboPlugin */
class FlutterMesiboPlugin: FlutterPlugin {

  companion object {
    private const val TAG = "FlutterMesiboPlugin"
  }

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    initMesibo(flutterPluginBinding.applicationContext)
    setupMesiboPlatformBinding(flutterPluginBinding)
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    /*
     * TODO Cleanup stop Mesibo and cleanup resources on detach
     */
  }

  /**
   * Initializes the Mesibo platform library and does some initial configuration.
   *
   * This initialization does not require an authenticated user and should be done on
   * application startup.
   * More setup (access token, actual startup of real time connection) is done from the Flutter
   * application through the platform binding implementation (see {@link AndroidMesiboRealTimeAPI}.
   */
  private fun initMesibo(applicationContext: Context) {
    Log.d(TAG, "Initializing Mesibo")

    val api: Mesibo = Mesibo.getInstance()
    val result = api.init(applicationContext)

    Log.d(TAG, "Mesibo initialized: $result")
    if (!result) {
      Log.w(TAG, "Mesibo 'init' returned false! Is this a problem?!")
    }

    // Other default configurations
    Mesibo.setSecureConnection(true)
  }

  /**
   * Creates the platform specific API implementations and registers them with the Flutter.
   */
  private fun setupMesiboPlatformBinding(pluginBinding: FlutterPlugin.FlutterPluginBinding) {
    // 1. Connection listener, delegating to Flutter target listener

    // the listener that calls Flutter methods using platform channels
    val targetConnectionListener = MesiboBinding.MesiboConnectionListener(pluginBinding.binaryMessenger)
    // the native Mesibo listener that delegates to the platform channel implementation
    val delegatingConnectionListener = DelegatingConnectionListener(targetConnectionListener)
    Mesibo.addListener(delegatingConnectionListener)
    Log.i(TAG, "DelegatingConnectionListener initialized")

    // 2. Message listener, delegating to Flutter target listener
    val targetMessageListener = MesiboBinding.MesiboMessageListener(pluginBinding.binaryMessenger)
    val delegatingMessageListener = DelegatingMessageListener(targetMessageListener)
    Mesibo.addListener(delegatingMessageListener)
    Log.i(TAG, "DelegatingMessageListener initialized")

    // 3. Setup real-time API implementation
    /*
     * NOTE: It's important that the MesiboRealTimeApi implementation uses the delegating MessageListener
     * from above so the Flutter side receives the requested messages!
     */
    MesiboBinding.MesiboRealTimeApi.setup(
            pluginBinding.binaryMessenger,
            AndroidMesiboRealTimeApi(delegatingMessageListener, pluginBinding.applicationContext))
  }
}
