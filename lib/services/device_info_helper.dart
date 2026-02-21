import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:public_ip_address/public_ip_address.dart';

class DeviceInfoHelper {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  static Future<Map<String, String>> getDeviceInfo() async {
    String deviceName = "";
    String deviceModel = "";
    String deviceOS = "";
    String appVersion = "";
    String platform = Platform.isAndroid ? "Android" : "iOS";
    String ipAddress = "unknown";

    // App Version
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;

    // Public IP
    try {
      IpAddress ipAddress0 = IpAddress();
       ipAddress = await ipAddress0.getIp();

   //   ipAddress = await IpAddress().getPublicIPAddress();
    } catch (e) {
      ipAddress = "unknown";
    }

    // Device Info
    if (Platform.isAndroid) {
      AndroidDeviceInfo android = await deviceInfoPlugin.androidInfo;
      deviceName = android.brand ?? "";
      deviceModel = android.model ?? "";
      deviceOS = "Android ${android.version.release}";
    } else if (Platform.isIOS) {
      IosDeviceInfo ios = await deviceInfoPlugin.iosInfo;
      deviceName = ios.name ?? "";
      deviceModel = ios.model ?? "";
      deviceOS = "${ios.systemName} ${ios.systemVersion}";
    }

    return {
      "device_name": deviceName,
      "device_model": deviceModel,
      "device_os": deviceOS,
      "platform": platform,
      "app_version": appVersion,
      "ip_address": ipAddress,
    };
  }
}
