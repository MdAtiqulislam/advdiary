package com.lawsuitbd.advdiary

import android.content.ContentValues
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.provider.MediaStore
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.advocatesdiary/files"

    // Prefix for all saved files
    private val ADVOCATES_DIARY_PREFIX = "AdvocatesDiary_"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when(call.method) {
                    "saveFile" -> {
                        var fileName = call.argument<String>("fileName") ?: "file.pdf"
                        val bytes = call.argument<ByteArray>("bytes") ?: ByteArray(0)

                        // Add prefix if not already present
                        if (!fileName.startsWith(ADVOCATES_DIARY_PREFIX)) {
                            fileName = ADVOCATES_DIARY_PREFIX + fileName
                        }

                        val fileUri = saveFileToDownloads(fileName, bytes)
                        if(fileUri != null) {
                            result.success(fileUri.toString())
                        } else {
                            result.success(null)
                        }
                    }
                    "openFile" -> {
                        val uriStr = call.argument<String>("fileUri")
                        if(uriStr != null){
                            openFile(uriStr)
                            result.success(true)
                        } else {
                            result.success(false)
                        }
                    }
                    else -> result.notImplemented()
                }
            }
    }

    private fun saveFileToDownloads(fileName: String, bytes: ByteArray): Uri? {
        return try {
            val resolver = contentResolver
            val contentValues = ContentValues().apply {
                put(MediaStore.Downloads.DISPLAY_NAME, fileName)
                put(MediaStore.Downloads.MIME_TYPE, getMimeType(fileName))
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                    put(MediaStore.Downloads.IS_PENDING, 1)
                }
            }

            val collection = MediaStore.Downloads.getContentUri(MediaStore.VOLUME_EXTERNAL_PRIMARY)
            val fileUri = resolver.insert(collection, contentValues) ?: return null

            resolver.openOutputStream(fileUri)?.use { it.write(bytes) }

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                contentValues.clear()
                contentValues.put(MediaStore.Downloads.IS_PENDING, 0)
                resolver.update(fileUri, contentValues, null, null)
            }
            fileUri
        } catch (e: Exception) {
            e.printStackTrace()
            null
        }
    }

    private fun openFile(fileUriString: String) {
        try {
            val uri = Uri.parse(fileUriString)
            val intent = Intent(Intent.ACTION_VIEW)
            intent.setDataAndType(uri, contentResolver.getType(uri))
            intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
            startActivity(intent)
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    private fun getMimeType(fileName: String): String {
        return when {
            fileName.endsWith(".pdf", ignoreCase = true) -> "application/pdf"
            fileName.endsWith(".png", ignoreCase = true) -> "image/png"
            fileName.endsWith(".jpg", ignoreCase = true) || fileName.endsWith(".jpeg", ignoreCase = true) -> "image/jpeg"
            else -> "*/*"
        }
    }
}
