package io.appback.app_back.storage

import android.os.Environment
import android.os.StatFs
import io.flutter.plugin.common.MethodChannel.Result

object StorageUtils {

    fun invokeAvailableStorage(result: Result) {
        val availableStorage = getAvailableStorage()
        if (availableStorage >= 0) result.success(availableStorage)
        else result.error("UNAVAILABLE", "Available storage not available.", null)
    }

    fun invokeTotalStorage(result: Result) {
        val totalStorage = getTotalStorage()
        if (totalStorage >= 0) result.success(totalStorage)
        else result.error("UNAVAILABLE", "Total storage not available.", null)
    }

    private fun getAvailableStorage(): Double {
        return if (hasExternalMemoryAvailable()) {
            val path = Environment.getExternalStorageDirectory()
            val stat = StatFs(path.path)
            String.format("%.2f", (stat.blockSizeLong * stat.availableBlocksLong) / 1000000000.0).toDouble()
        } else 0.0
    }

    private fun getTotalStorage(): Double {
        return if (hasExternalMemoryAvailable()) {
            val path = Environment.getExternalStorageDirectory()
            val stat = StatFs(path.path)
            String.format("%.2f", (stat.blockCountLong * stat.blockSizeLong) / 1000000000.0).toDouble()
        } else 0.0
    }

    private fun hasExternalMemoryAvailable() = Environment.getExternalStorageState() == Environment.MEDIA_MOUNTED
}