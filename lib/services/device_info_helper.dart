/*
import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';

class DeviceInfoHelper {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  static Future<String> _getPublicIp() async {

    // 1. Primary IP service
    try {
      final response = await http
          .get(Uri.parse('https://api.ipify.org?format=json'))
          .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final ip = data['ip']?.toString().trim() ?? '';

        if (InternetAddress.tryParse(ip) != null) {
          return ip;
        }
      }
    } catch (e) {
      print('Primary IP service failed: $e');
    }

    // 2. Fallback IP service
    try {
      final response = await http
          .get(Uri.parse('https://api64.ipify.org?format=json'))
          .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final ip = data['ip']?.toString().trim() ?? '';

        if (InternetAddress.tryParse(ip) != null) {
          return ip;
        }
      }
    } catch (e) {
      print('Fallback IP service failed: $e');
    }

    // Don't break API requests if IP cannot be obtained
    return 'unknown';
  }

  static Future<Map<String, String>> getDeviceInfo() async {
    String deviceName = "";
    String deviceModel = "";
    String deviceOS = "";
    String appVersion = "";
    String platform = Platform.isAndroid ? "Android" : "iOS";

    final PackageInfo packageInfo =
    await PackageInfo.fromPlatform();

    appVersion = packageInfo.version;

    // Public IP
    final ipAddress = await _getPublicIp();

    // Device Info
    if (Platform.isAndroid) {
      final AndroidDeviceInfo android =
      await deviceInfoPlugin.androidInfo;

      deviceName = android.brand;
      deviceModel = android.model;
      deviceOS = "Android ${android.version.release}";
    } else if (Platform.isIOS) {
      final IosDeviceInfo ios =
      await deviceInfoPlugin.iosInfo;

      deviceName = ios.name;
      deviceModel = ios.model;
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
}*/


import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';

class DeviceInfoHelper {
  static final DeviceInfoPlugin _deviceInfoPlugin =
  DeviceInfoPlugin();

  static final Connectivity _connectivity =
  Connectivity();

  static Map<String, String>? _cachedDeviceInfo;

  static Future<Map<String, String>>? _deviceInfoFuture;

  static StreamSubscription<List<ConnectivityResult>>?
  _connectivitySubscription;

  // ---------------------------------------------------------------------------
  // INITIALIZE
  // ---------------------------------------------------------------------------

  static void initialize() {
    _connectivitySubscription?.cancel();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(
              (results) {
            _handleNetworkChange(results);
          },
        );
  }

  // ---------------------------------------------------------------------------
  // NETWORK CHANGE
  // ---------------------------------------------------------------------------

  static void _handleNetworkChange(
      List<ConnectivityResult> results,
      ) {
    final hasConnection =
    results.any((result) =>
    result != ConnectivityResult.none);

    if (!hasConnection) {
      return;
    }

    // Network changed.
    // Clear only the cached IP.
    if (_cachedDeviceInfo != null) {
      _cachedDeviceInfo!['ip_address'] = 'unknown';
    }

    // Force next getDeviceInfo() to fetch a new IP.
    _cachedDeviceInfo = null;

    print(
      'Network changed → Device info cache cleared',
    );
  }

  // ---------------------------------------------------------------------------
  // PUBLIC IP
  // ---------------------------------------------------------------------------

  static Future<String> _getPublicIp() async {
    // Primary service
    try {
      final response = await http
          .get(
        Uri.parse(
          'https://api.ipify.org?format=json',
        ),
      )
          .timeout(
        const Duration(seconds: 5),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final ip =
            data['ip']?.toString().trim() ?? '';

        if (InternetAddress.tryParse(ip) != null) {
          print('Public IP: $ip');
          return ip;
        }
      }
    } catch (e) {
      print(
        'Primary IP service failed: $e',
      );
    }

    // Fallback service
    try {
      final response = await http
          .get(
        Uri.parse(
          'https://api64.ipify.org?format=json',
        ),
      )
          .timeout(
        const Duration(seconds: 5),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final ip =
            data['ip']?.toString().trim() ?? '';

        if (InternetAddress.tryParse(ip) != null) {
          print('Public IP (fallback): $ip');
          return ip;
        }
      }
    } catch (e) {
      print(
        'Fallback IP service failed: $e',
      );
    }

    return 'unknown';
  }

  // ---------------------------------------------------------------------------
  // GET DEVICE INFO
  // ---------------------------------------------------------------------------

  static Future<Map<String, String>>
  getDeviceInfo() async {

    // Return cache
    if (_cachedDeviceInfo != null) {
      return _cachedDeviceInfo!;
    }

    // Already loading
    if (_deviceInfoFuture != null) {
      return _deviceInfoFuture!;
    }

    _deviceInfoFuture = _loadDeviceInfo();

    try {
      _cachedDeviceInfo =
      await _deviceInfoFuture!;

      return _cachedDeviceInfo!;
    } finally {
      _deviceInfoFuture = null;
    }
  }

  // ---------------------------------------------------------------------------
  // LOAD DEVICE INFO
  // ---------------------------------------------------------------------------

  static Future<Map<String, String>>
  _loadDeviceInfo() async {

    String deviceName = '';
    String deviceModel = '';
    String deviceOS = '';

    final platform =
    Platform.isAndroid
        ? 'Android'
        : 'iOS';

    // App info
    final packageInfo =
    await PackageInfo.fromPlatform();

    final appVersion =
        packageInfo.version;

    // Public IP
    final ipAddress =
    await _getPublicIp();

    // Device info
    if (Platform.isAndroid) {
      final androidInfo =
      await _deviceInfoPlugin.androidInfo;

      deviceName =
          androidInfo.brand;

      deviceModel =
          androidInfo.model;

      deviceOS =
      'Android ${androidInfo.version.release}';
    } else if (Platform.isIOS) {
      final iosInfo =
      await _deviceInfoPlugin.iosInfo;

      deviceName =
          iosInfo.name;

      deviceModel =
          iosInfo.model;

      deviceOS =
      '${iosInfo.systemName} '
          '${iosInfo.systemVersion}';
    }

    return {
      'device_name': deviceName,
      'device_model': deviceModel,
      'device_os': deviceOS,
      'platform': platform,
      'app_version': appVersion,
      'ip_address': ipAddress,
    };
  }

  // ---------------------------------------------------------------------------
  // CLEAR CACHE
  // ---------------------------------------------------------------------------

  static void clearCache() {
    _cachedDeviceInfo = null;
    _deviceInfoFuture = null;
  }

  // ---------------------------------------------------------------------------
  // DISPOSE
  // ---------------------------------------------------------------------------

  static Future<void> dispose() async {
    await _connectivitySubscription?.cancel();
    _connectivitySubscription = null;
  }
}