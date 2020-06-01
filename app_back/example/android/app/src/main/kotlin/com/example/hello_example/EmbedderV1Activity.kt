package com.example.hello_example

import android.os.Bundle
import io.appback.app_back.AppBackPlugin
import io.flutter.app.FlutterActivity
import io.flutter.view.FlutterMain

class EmbedderV1Activity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        FlutterMain.startInitialization(this)
        super.onCreate(savedInstanceState)
        AppBackPlugin.registerWith(registrarFor("io.appback.AppBackPlugin"))
    }
}
