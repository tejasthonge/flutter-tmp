import 'dart:developer';

import 'package:dio/dio.dart';

import '../models/index.dart';

class GolainApiService {
  final String _orgId = "8555f045-56b2-479c-8d17-1487600a2582";
  final Dio _dio = Dio();

  Future hitHi({required String authToken}) async {
    try {
      final headers = {
        'Authorization': 'Bearer $authToken',
        'ORG-ID': _orgId,
      };

      final response = await _dio.get(
        'https://api.golain.io/consumer/api/v1/48ba67b3-84ff-4894-b6c5-8491fc9bc95b/hi',
        options: Options(
          headers: headers,
        ),
      );
      log(response.data.toString());
      return response;
    } catch (e) {
      log(e.toString());

      return null;
    }
  }

  Future fetchDevices({required String authToken}) async {
    log("Fetching devices... authToken\n $authToken");
    try {
      final headers = {
        'Authorization': 'Bearer $authToken',
        'ORG-ID': _orgId,
      };

      final response = await _dio.get(
        'https://api.golain.io/consumer/api/v1/48ba67b3-84ff-4894-b6c5-8491fc9bc95b/devices',
        options: Options(
          headers: headers,
        ),
      );
      log(response.data["data"]["devices"]);
      return response.data["data"]["devices"];
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future getDeviceShadow({
    required String deviceId,
    required String authToken,
  }) async {
    try {
      final headers = {
        'Authorization': 'Bearer $authToken',
        'ORG-ID': _orgId,
      };

      final response = await _dio.get(
        'https://api.golain.io/consumer/api/v1/48ba67b3-84ff-4894-b6c5-8491fc9bc95b/devices/$deviceId/shadow',
        options: Options(
          headers: headers,
        ),
      );

      return response.data["data"]["shadow"];
    } catch (e) {
      return null;
    }
  }

  Future updateDeviceShadow({
    required String deviceId,
    required Map shadow,
    required String authToken,
  }) async {
    try {
      final headers = {
        'Authorization': 'Bearer $authToken',
        'ORG-ID': _orgId,
      };

      final response = await _dio.patch(
        'https://api.golain.io/consumer/api/v1/48ba67b3-84ff-4894-b6c5-8491fc9bc95b/devices/$deviceId/shadow',
        options: Options(headers: headers),
        data: shadow,
      );
      return response.data;
    } catch (e) {
      return null;
    }
  }

  Future getDeviceData(
      {required String authToken, required String deviceId}) async {
    try {
      final headers = {
        'Authorization': 'Bearer $authToken',
        'ORG-ID': _orgId,
      };

      final response = await _dio.get(
        'https://api.golain.io/48ba67b3-84ff-4894-b6c5-8491fc9bc95b/wke/devices/$deviceId/device_data/',
        options: Options(
          headers: headers,
        ),
      );
      OverallModel overallModel =
          OverallModel.fromjson(response.data["data"][0]);
      return overallModel;
    } catch (e) {
      return null;
    }
  }

  Future associateDevice(
      {required String authToken, required String deviceId}) async {
    try {
      final headers = {
        'Authorization': 'Bearer $authToken',
        'ORG-ID': _orgId,
      };

      final body = {"device_id": deviceId, "associate": true};

      final response = await _dio.post(
          "https://api.golain.io/48ba67b3-84ff-4894-b6c5-8491fc9bc95b/wke/association/",
          options: Options(headers: headers),
          data: body);
      return response.data;
    } catch (e) {
      return null;
    }
  }
}
