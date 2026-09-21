import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../constraints/api_endpoints.dart';
import '../constraints/app_strings.dart';
import 'device_info_helper.dart';
import 'local_services.dart';

class RemoteServices {
  static final http.Client client = http.Client();
  static String baseURL = APIEndPoints.baseUrl;
  static String token = "";

  // 🔥 Unified Device + IP Header
  static Future<Map<String, String>> _commonHeaders() async {
    token = await LocalServices.getToken() ?? "";
    final deviceInfo = await DeviceInfoHelper.getDeviceInfo();

   print(deviceInfo.toString());

    return {
      "Authorization": "Bearer $token",
      "Device-Name": deviceInfo["device_name"] ?? "",
      "Device-Model": deviceInfo["device_model"] ?? "",
      "Device-OS": deviceInfo["device_os"] ?? "",
      "Platform": deviceInfo["platform"] ?? "",
      "App-Version": deviceInfo["app_version"] ?? "",
      "Device-IP": deviceInfo["ip_address"] ?? "",
    };
  }

  // ---------------- POST ----------------
  static Future<dynamic> postRequest({
    required String endPoint,
    Map<dynamic, dynamic>? body,
    Map<String, dynamic>? parameters,
  }) async {
    AppStrings.httpErrorMSG.value = "";

    final Uri uri = Uri.parse(baseURL + endPoint).replace(queryParameters: parameters);
    final headers = await _commonHeaders();

    if (kDebugMode) {
      print("POST URL: $uri");
      print("POST Body: $body");

    }
    try {
      final http.Response response = await http.post(
        uri,
        body: body,
        headers: headers,
      );

      return handleResponse(response);
    } catch (e) {

      print(e);
      AppStrings.httpErrorMSG.value = AppStrings.generalHttpErrorMSG;
      return null;
    }
  }

  // ---------------- POST JSON ----------------
  static Future<dynamic> postRequestWithJsonData({
    required String endPoint,
    Map<dynamic, dynamic>? body,
    Map<String, dynamic>? parameters,
  }) async {
    AppStrings.httpErrorMSG.value = "";

    final Uri uri = Uri.parse(baseURL + endPoint).replace(queryParameters: parameters);
    final headers = await _commonHeaders()
      ..addAll({"Content-Type": "application/json"});

    if (kDebugMode) {
      print("POST JSON URL: $uri");
      print("Data: $body");
    }

    try {
      final response = await http.post(
        uri,
        body: json.encode(body),
        headers: headers,
      );
      return handleResponse(response);
    } catch (e) {
      AppStrings.httpErrorMSG.value = AppStrings.generalHttpErrorMSG;
      return null;
    }
  }

  // ---------------- GET ----------------
  static Future<dynamic> getRequest({
    required String endPoint,
    Map<String, dynamic>? parameters,
  }) async {
    AppStrings.httpErrorMSG.value = "";

    final Uri uri = Uri.parse(baseURL + endPoint).replace(queryParameters: parameters);
    final headers = await _commonHeaders();

    if (kDebugMode) print("GET: $uri");
    if (kDebugMode) print("Headers: $headers");

    try {
      final response = await client.get(uri, headers: headers);
      return handleResponse(response);
    } catch (e) {
      AppStrings.httpErrorMSG.value = AppStrings.generalHttpErrorMSG;
      return null;
    }
  }

  // --------------- GET (Load More) ---------------
  static Future<dynamic> getRequestLoadMore({
    required String url,
    Map<String, dynamic>? parameters,
  }) async {
    AppStrings.httpErrorMSG.value = "";

    final Uri uri = Uri.parse(url).replace(queryParameters: parameters);
    final headers = await _commonHeaders();

    if (kDebugMode) {
      print("GET LOAD MORE URL: $uri");
      print("Params: $parameters");
    }

    try {
      final response = await client.get(uri, headers: headers);
      return handleResponse(response);
    } catch (e) {
      if (kDebugMode) print("Error in GET LOAD MORE: $e");
      AppStrings.httpErrorMSG.value = AppStrings.generalHttpErrorMSG;
      return null;
    }
  }

  // ---------------- PUT JSON ----------------
  static Future<dynamic> putRequestWithJson({
    required String endPoint,
    Map<dynamic, dynamic>? body,
    Map<String, dynamic>? parameters,
  }) async {
    AppStrings.httpErrorMSG.value = "";

    final Uri uri = Uri.parse(baseURL + endPoint).replace(queryParameters: parameters);
    final headers = await _commonHeaders()
      ..addAll({"Content-Type": "application/json"});

    try {
      final response = await http.put(
        uri,
        body: json.encode(body),
        headers: headers,
      );
      return handleResponse(response);
    } catch (e) {
      AppStrings.httpErrorMSG.value = AppStrings.generalHttpErrorMSG;
      return null;
    }
  }

  // ---------------- DELETE ----------------
  static Future<dynamic> deleteRequest({
    required String endPoint,
    Map<dynamic, dynamic>? body,
  }) async {
    AppStrings.httpErrorMSG.value = "";

    final Uri uri = Uri.parse(baseURL + endPoint);
    final headers = await _commonHeaders();

    try {
      final response = await http.delete(uri, body: body, headers: headers);
      return handleResponse(response);
    } catch (e) {
      AppStrings.httpErrorMSG.value = AppStrings.generalHttpErrorMSG;
      return null;
    }
  }

  // ---------------- Multipart Upload ----------------
  static Future<dynamic> multipartRequest({
    required String filePath,
    required String fieldName,
    required String endPoint,
    required String requestType,
    Map<String, String>? body,
    Map<String, String>? parameters,
  }) async {
    final Uri uri = Uri.parse(baseURL + endPoint).replace(queryParameters: parameters);
    final headers = await _commonHeaders();

    if (kDebugMode) {
      print(uri);
      print(body);
      print(filePath);
    }

    try {
      final request = http.MultipartRequest(requestType, uri);
      request.headers.addAll(headers);
      request.fields.addAll(body ?? {});

      if (filePath.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath(fieldName, filePath));
      }

      final response = await http.Response.fromStream(await request.send());
      return handleResponse(response);
    } catch (e) {
      AppStrings.httpErrorMSG.value = AppStrings.generalHttpErrorMSG;
      return null;
    }
  }

  // ---------------- Response Handler ----------------
  static dynamic handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(response.body);
    }

    try {
      final data = json.decode(response.body);
      AppStrings.httpErrorMSG.value =
          data["msg"] ?? data["message"] ?? AppStrings.generalHttpErrorMSG;
    } catch (_) {
      AppStrings.httpErrorMSG.value = AppStrings.generalHttpErrorMSG;
    }

    return null;
  }
}
