package com.example.hello_example

import android.content.Context
import io.appback.app_back.AppBackPlugin
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterJNI
import io.flutter.embedding.engine.loader.FlutterLoader

class MainActivity: FlutterActivity() {

    override fun provideFlutterEngine(context: Context): FlutterEngine? {
        val flutterEngine = FlutterEngine(context, FlutterLoader.getInstance(), FlutterJNI(), emptyArray(), false)
        flutterEngine.plugins.add(AppBackPlugin())
        return flutterEngine
    }

}
