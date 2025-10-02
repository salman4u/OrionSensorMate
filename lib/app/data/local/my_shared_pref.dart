import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/ApiUtils.dart';
import '../../utility/Utility.dart';


class MySharedPref {
  // prevent making instance
  MySharedPref._();

  // get storage
  static SharedPreferences? _sharedPreferences;

  // STORING KEYS
  static const String _fcmTokenKey = 'fcm_token';
  static const String _currentLocalKey = 'current_local';
  static const String _lightThemeKey = 'is_theme_light';
  static const String _apiTokenKey = 'app_token';
  static const String _eldStatus = "eldStatus";
  static const String _isPCStart = "isPCStart";
  static const String _isYardMoveStart = "isYardMoveStart";

  /// init get storage services
  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }


  static setStorage(SharedPreferences sharedPreferences) {
    _sharedPreferences = sharedPreferences;
  }

  /// set theme current type as light theme
  static Future<void> setThemeIsLight(bool lightTheme) async {
    _checkInitialization();
    await _sharedPreferences!.setBool(_lightThemeKey, lightTheme);
  }

  static String getVehicleNumber() {
    _checkInitialization();
    String? vehicleNumber = _sharedPreferences!.getString("vehicleNumber");
    return vehicleNumber ?? '';
  }

  static Future<void> setVehicleNumber(String vehicleNumber) async {
    _checkInitialization();
    await _sharedPreferences!.setString("vehicleNumber", vehicleNumber);
  }
  static Future<void> setTrailerNuber(String vehicleNumber) async {
    _checkInitialization();
    await _sharedPreferences!.setString("trailerNumber", vehicleNumber);
  }
  static String getVehicleId() {
    _checkInitialization();
    String? vehicleId = _sharedPreferences!.getString("vehicleId");
    return vehicleId ?? '';
  }
  static String getTrailerNumber() {
    _checkInitialization();
    String? vehicleId = _sharedPreferences!.getString("trailerNumber");
    return vehicleId ?? '';
  }
  static Future<void> setVehicleId(String vehicleId) async {
    _checkInitialization();
    await _sharedPreferences!.setString("vehicleId", vehicleId);
  }
  static Future<void> setTrailerId(String vehicleId) async {
    _checkInitialization();
    await _sharedPreferences!.setString("trailerId", vehicleId);
  }
  static String getUserName() {
    _checkInitialization();
    String? userName = _sharedPreferences!.getString("username");
    return userName ?? '';
  }
  static String getTrailerId() {
    _checkInitialization();
    String? userName = _sharedPreferences!.getString("trailerId");
    return userName ?? '';
  }
  static Future<void> setUserName(String userName) async {
    _checkInitialization();
    await _sharedPreferences!.setString("username", userName);
  }
  static Future<void> setLicence(String userName) async {
    _checkInitialization();
    await _sharedPreferences!.setString("licence", userName);
  }
  static String getLicence() {
    _checkInitialization();
    String? licence = _sharedPreferences!.getString("licence");
    return licence ?? 'N/A';
  }
  static int? getDriverId() {
    _checkInitialization();
    return _sharedPreferences!.getInt("driverid");
  }

  static Future<void> setDriverId(int driverId) async {
    _checkInitialization();
    await _sharedPreferences!.setInt("driverid", driverId);
  }

  static Future<void> setVehicleType(bool value) async {
    _checkInitialization();
    await _sharedPreferences!.setBool("isTruck", value);
  }

  /// get if the current theme type is light
  static bool getThemeIsLight() {
    _checkInitialization();
    return _sharedPreferences!.getBool(_lightThemeKey) ?? true; // default theme is light
  }

  static bool isTruck() {
    _checkInitialization();
    return _sharedPreferences!.getBool("isTruck") ?? true;
  }

  /// save current locale
  static Future<void> setCurrentLanguage(String languageCode) async {
    _checkInitialization();
    await _sharedPreferences!.setString(_currentLocalKey, languageCode);
  }



  /// save generated fcm token
  static Future<void> setFcmToken(String token) async {
    _checkInitialization();
    await _sharedPreferences!.setString(_fcmTokenKey, token);
  }

  /// get authorization token
  static String? getFcmToken() {
    _checkInitialization();
    return _sharedPreferences!.getString(_fcmTokenKey);
  }

  static Future<void> setAPIToken(String token) async {
    _checkInitialization();
    await _sharedPreferences!.setString(_apiTokenKey, token);
  }

  /// get authorization token
  static String? getAPIToken() {
    _checkInitialization();
    return _sharedPreferences!.getString(_apiTokenKey);
  }

  static void removeAllData() {
    _checkInitialization();
    _sharedPreferences!.clear();
  }

  static String? getUserName1() {
    _checkInitialization();
    return _sharedPreferences!.getString("username1");
  }

  /// clear all data from shared pref
  static Future<void> clear() async {
    _checkInitialization();
    await _sharedPreferences!.clear();
  }


  static void setDutyStatusNow(int status) {
    _checkInitialization();
    if(status == 1){
      _sharedPreferences!.remove("lastOdometerInput");
    }
    _sharedPreferences!.setInt("currentDutyStatus", status);
  }
  // Method to save both location and position
  static void saveLastLocation(String location, Position position) {
    _checkInitialization();
    _sharedPreferences!.setString("lastLocation", location);
    _sharedPreferences!.setString("lastPosition", jsonEncode({
      'latitude': position.latitude,
      'longitude': position.longitude,
      'timestamp': position.timestamp?.toIso8601String(),
    }));
  }
  static Map<String, dynamic>? getLastLocationAndPosition() {
    _checkInitialization();
    String lastLocation = _sharedPreferences!.getString("lastLocation") ?? "";
    String? positionString = _sharedPreferences!.getString("lastPosition");
    Map<String, dynamic>? positionMap;
    if (positionString != null) {
      positionMap = jsonDecode(positionString);
    }
    return {
      'location': lastLocation,
      'position': positionMap
    };
  }

  static String getLastLocation() {
    _checkInitialization();
    return _sharedPreferences!.getString("lastLocation") ?? "";
  }
  static void removeLastLocationAndOdometer() {
    _checkInitialization();
     _sharedPreferences!.remove("lastLocation");
    _sharedPreferences!.remove("lastOdometerInput");

  }
  static void saveDutyStatus(int status) {
    _checkInitialization();
    _sharedPreferences!.setInt("currentDutyStatus", status);
  }

  static int? getDutyStatus() {
    _checkInitialization();
    return _sharedPreferences!.getInt("currentDutyStatus");
  }


  static void setNotChargingSoundStatus(bool status) {
    _checkInitialization();
    _sharedPreferences!.setBool("disableNotCharging", status);
  }
  static bool? getNotChargingStatus() {
    _checkInitialization();
    return _sharedPreferences!.getBool("disableNotCharging")?? false;
  }

  static Future<void> setEnableMultipleBluetoothDevices(bool value) async {
    await _sharedPreferences!.setBool('enableMultipleBluetoothDevices', value);
  }
  static bool? getEnableMultipleBluetoothDevices()  {
    return _sharedPreferences!.getBool('enableMultipleBluetoothDevices')?? false;;
  }
  static Future<void> setDisableOpeningGoogleMap(bool value) async {
    await _sharedPreferences!.setBool('googlemapOpening', value);
  }
  static bool? getDisableOpeningGoogleMap()  {
    return _sharedPreferences!.getBool('googlemapOpening')?? true;
  }
  static Future<void> setOpeningELogAppAutomatically(bool value) async {
    await _sharedPreferences!.setBool('eLogAppOpening', value);
  }
  static bool? getOpeningELogAppAutomatically()  {
    return _sharedPreferences!.getBool('eLogAppOpening')?? true;
  }
  static Future<void> setDisplayOptionToAutoConvert15MinOnDutyToOffDuty(bool value) async {
    await _sharedPreferences!.setBool('15minAutoConvert', value);
  }
  static bool? getDisplayOptionToAutoConvert15MinOnDutyToOffDuty()  {
    return _sharedPreferences!.getBool('15minAutoConvert')?? true;
  }
  static Future<void> setDisplayOptionToAutoConvert4HrOnDutyToOffDuty(bool value) async {
    await _sharedPreferences!.setBool('4hrAutoConvert', value);
  }
  static bool? getDisplayOptionToAutoConvert4HrOnDutyToOffDuty()  {
    return _sharedPreferences!.getBool('4hrAutoConvert')?? true;
  }

  static void saveLastEngineHours(double engineHours) {
    _checkInitialization();
    _sharedPreferences!.setDouble("engineHours",engineHours);
  }
  static double? getLastEngineHours() {
    _checkInitialization();
    return _sharedPreferences!.getDouble("engineHours");
  }

  static void saveEldConnectionStatus(bool isConnected)  {
    _checkInitialization();
     _sharedPreferences!.setBool(_eldStatus, isConnected);
  }
  static String  getEldStatus() {
    _checkInitialization();
    bool? eldStatus = _sharedPreferences!.getBool(_eldStatus);
    return eldStatus == true ? 'XCOM5G connected':'XCOM5G not connected';
  }

  static void setPCStatus(bool isPCStart) {
      _checkInitialization();
      _sharedPreferences!.setBool(_isPCStart, isPCStart);
  }
  static void setYardMoveStatus(bool isYardMoveStart) {
    var checkInitialization = _checkInitialization();
    _sharedPreferences!.setBool(_isYardMoveStart, isYardMoveStart);
  }
  static bool? isPCStarted() {
    _checkInitialization();
   return _sharedPreferences!.getBool(_isPCStart);
  }
  static bool isYardMoveStarted() {
    _checkInitialization();
    return _sharedPreferences!.getBool(_isYardMoveStart)?? false;
  }

  static void setLastDutyStatusToPortal(int shift) {
     _checkInitialization();
    _sharedPreferences!.setInt(_isYardMoveStart, shift);
  }
  static int getLastDutyStatusToPortal() {
    _checkInitialization();
    return _sharedPreferences!.getInt(_isYardMoveStart) ?? 0;
  }

  static void setLastNote(String note) {
    _checkInitialization();
    int timestamp = (DateTime.now().millisecondsSinceEpoch / 1000).truncate();
    _sharedPreferences!.setInt("noteTime", timestamp);
    _sharedPreferences!.setString("lastNote", note);
  }
  static Map<String, dynamic> getLastNote(String note) {
    _checkInitialization();
    int timeStamp = _sharedPreferences!.getInt("noteTime") ?? 0;
    int timePassed = (DateTime.now().millisecondsSinceEpoch - timeStamp) ~/ 1000;
    bool shouldAddNote = timePassed < 100;
    String lastNote = _sharedPreferences!.getString("lastNote") ?? "";
    return {
      'shouldAddNote': shouldAddNote,
      'lastNote': lastNote
    };
  }

  static Future<void> _checkInitialization() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
  }

  static Future<String> getEldSerialNumber() async {
    await _checkInitialization();
    return _sharedPreferences?.getString("serialNumber") ?? "";
  }

  static Future<void> setEldSerialNumber(String serialNumber) async {
    await _checkInitialization();
    await _sharedPreferences?.setString("serialNumber", serialNumber);
    reloadPreferences();
  }
  static void setEldName(String eldName) {
    _checkInitialization();
    _sharedPreferences!.setString("eldName", eldName);
  }

  static String getEldName() {
    _checkInitialization();
    return _sharedPreferences!.getString("eldName")! ?? "";
  }

  static getLastViolation(String s) {
    _checkInitialization();
   return _sharedPreferences!.getInt(s);
  }


  static void setEldUpdateStart(bool update) {
    _checkInitialization();
    _sharedPreferences!.setBool("updateXcom", update);
  }
  static bool isUpdateXcom() {
    _checkInitialization();
    return _sharedPreferences!.getBool("updateXcom")?? false;
  }
  static void reloadPreferences()  {
    _checkInitialization();
     _sharedPreferences?.reload();
  }

  static void setWifiUserName(String userName) {
    _checkInitialization();
    _sharedPreferences!.setString("wifiName", userName);
  }
  static String getWifiNetworkName() {
    _checkInitialization();
    return _sharedPreferences!.getString("wifiName")??"";
  }
  static void setWifiNetworkPassword(String userName) {
    _checkInitialization();
    _sharedPreferences!.setString("wifiPassword", userName);
  }
  static String getWifiNetworkPassword() {
    _checkInitialization();
    return _sharedPreferences!.getString("wifiPassword")??"";
  }

  static void setHubFirmwareVersion(int espFirmwareVersion) {
    _checkInitialization();
    _sharedPreferences!.setInt("hubVersion", espFirmwareVersion);
  }
  static int getHubFirmwareVersion() {
    _checkInitialization();
    return _sharedPreferences!.getInt("hubVersion")?? 0;
  }

  static void setLastCanbusDataTime(int lastCanbusData) {
    _checkInitialization();
    _sharedPreferences!.setInt("lastCanbusData", lastCanbusData);
  }
  static bool isGettingCanbusData() {
    _checkInitialization();
    int timeStamp = _sharedPreferences!.getInt("lastCanbusData") ?? 0;
    int timePassed = (DateTime.now().millisecondsSinceEpoch - timeStamp) ~/ 1000;
    bool isGettingData = timePassed < 600;
    return isGettingData;
  }

  static void saveTruckOdometer(double odometerNow) {
    _checkInitialization();
    int timestamp = (DateTime.now().millisecondsSinceEpoch / 1000).truncate();
    _sharedPreferences!.setInt("truckOdometerNow", timestamp);
    _sharedPreferences!.setDouble("truckOdometer", odometerNow);
  }
  static bool isGettingTruckOdometer() {
    _checkInitialization();
    int timeStamp = _sharedPreferences!.getInt("truckOdometerNow") ?? 0;
    int timePassed = (DateTime.now().millisecondsSinceEpoch - timeStamp) ~/ 1000;
    bool isGettingData = timePassed < 1200;
    return isGettingData;
  }
  static double getTruckECUOdometer() {
    _checkInitialization();
    return _sharedPreferences!.getDouble("truckOdometer")?? 0;
  }

  static Future<void> removeEldSerialNumber(String hubTD) async {
    String serilaNumber = await getEldSerialNumber();
    if(serilaNumber == hubTD){
      setEldSerialNumber("");
    }

  }

  static void setEldConnectionStatus(String connection) {
    _checkInitialization();
    _sharedPreferences?.setString("eldConnectionStatus", connection);
  }
  static String getEldConnectionStatus() {
    _checkInitialization();
    return _sharedPreferences?.getString("eldConnectionStatus")?? "Disconnected";
  }

  static void setTransmissionTimer(int value) {
    _checkInitialization();
    _sharedPreferences?.setInt("transmissionTimer", value);
  }
  static int? getTransmissionTimer() {
    _checkInitialization();
   return _sharedPreferences?.getInt("transmissionTimer")??60;

  }
}
