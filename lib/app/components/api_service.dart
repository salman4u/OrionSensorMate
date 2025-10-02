import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sensor_mate/app/data/local/my_shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/models/login_response.dart';
import '../modules/DevicesDetailsList/controllers/devices_details_list_controller.dart';
import '../routes/app_pages.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: "https://elog.alwaysaware.org/api/",
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
    headers: {"Content-Type": "application/json"},
  ));

  Future<LoginResponse?> login({
    required String loginId,
    required String password,
    required String appType,
    required String mscId,
    required String appVersion,
    required String orgName,
  }) async {
    try {
      final response = await _dio.post(
        "login",
        data: {
          "LoginId": loginId,
          "Password": password,
          "AppType": appType,
          "MSCId": mscId,
          "AppVersion": appVersion,
          "OrgName": orgName,
        },
      );

      if (response.statusCode == 200 && response.data["Data"] != null) {
        final json = response.data["Data"][0];
        final loginResponse = LoginResponse.fromJson(json);

        // Save into SharedPreferences as JSON string
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("login_data", jsonEncode(loginResponse.toJson()));

        return loginResponse;
      }
      return null;
    } catch (e) {
      print("Login error: $e");
      return null;
    }
  }
  Future<List<Device>> getCradlesCanHubList({
    required String orgName,
    required String guid,
    required String vehicleId,
  }) async {
    try {
      final response = await _dio.post(
        "CradlesCanHubList",
        data: {
          "OrgName": orgName,
          "Guid": guid,
          "VehicleId": vehicleId,
        },
      );

      if (response.statusCode == 200 &&
          response.data["Result"] == true &&
          response.data["Data"] != null) {
        final List<dynamic> list = response.data["Data"];
        return list.map((json) => Device.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      print("Error in CradlesCanHubList: $e");
      if(e.toString().contains('405')){
        MySharedPref.clear();
        MySharedPref.reloadPreferences();
        Get.toNamed(AppPages.LOGIN);
      }
      return [];
    }
  }

  Future<String> addDevice({
    required String orgName,
    required String guid,
    required int driverId,
    required String hubName,
    required String hubTD,
    required String hubType,
    required String description,
    required String imei,
    required String did,
  }) async {
    try {
      final response = await _dio.post(
        "https://elog.alwaysaware.org/api/AddCradleCan",
        data: {
          "OrgName": orgName,
          "Guid": guid,
          "DriverId": driverId,
          "HubName": hubName,
          "HubTD": hubTD,
          "HubType": hubType,
          "Description": description,
          "IMEI": imei,
          "DID": did,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final bool result = data["Result"] ?? false;
        final String message = data["Message"] ?? "Unknown error";

        if (result) {
          print("✅ Device added successfully");
          return "success";
        } else {
          print("⚠️ Failed: $message");
          return message; // e.g. "HubTD already exists"
        }
      } else {
        return "Server error: ${response.statusCode}";
      }
    } catch (e) {
      print("❌ Error in addDevice: $e");
      return "Exception: $e";
    }
  }



  /// Retrieve saved login data
  Future<LoginResponse?> getSavedLoginData() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString("login_data");
    if (raw != null) {
      final Map<String, dynamic> map = jsonDecode(raw);
      return LoginResponse.fromJson(map);
    }
    return null;
  }
}
