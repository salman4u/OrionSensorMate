import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:flutter/material.dart';
import 'package:sensor_mate/app/data/local/my_shared_pref.dart';
import 'dart:typed_data';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../components/background_service.dart';

enum SensorId {
  general,      // Transmission Timer, Battery min
  motion,
  humidity,
  temperature,
  movement,
  sound,
  light,
  analog1,
  analog2,
  digital1,
  digital2,
}

class SensorSettingsController extends GetxController {
  // Transmission Timer
  var transmissionTimer = 30.obs;

  // With limits
  var vBatMin = 0.obs;
  var vBatMax = 4200.obs;

  var temperatureMin = 0.obs;
  var temperatureMax = 125.obs;

  var humidityMin = 0.obs;
  var humidityMax = 100.obs;

  var motionMin = 0.obs;
  var motionMax = 16000.obs;

  var soundMin = 0.obs;
  var soundMax = 1.obs;

  var lightMin = 0.obs;
  var lightMax = 65000.obs;

  var analog1Min = 0.obs;
  var analog1Max = 24000.obs;

  var analog2Min = 0.obs;
  var analog2Max = 24000.obs;

  // Without limits
  var movement = false.obs;
  var digital1 = false.obs;
  var digital2 = false.obs;

  /// Builds a BLE/MQTT config packet according to sensor_limits_msg_t
  Uint8List buildLimitPacket({
    required SensorId sensorId,
    required int uLimit,
    required int lLimit,
    required bool triggerEnable,
  }) {
    final buffer = BytesBuilder();

    // sensor_serial = 0 → apply to ALL sensors
    buffer.add([0, 0, 0, 0]);

    // sensor_id
    buffer.add([sensorId.index]);

    // u_limit (uint16_t, little endian)
    buffer.add([uLimit & 0xFF, (uLimit >> 8) & 0xFF]);

    // l_limit (uint16_t, little endian)
    buffer.add([lLimit & 0xFF, (lLimit >> 8) & 0xFF]);

    // trigger_enable
    buffer.add([triggerEnable ? 1 : 0]);

    return buffer.toBytes();
  }

  /// Collects one packet per sensor type
  List<Uint8List> buildAllPackets() {
    MySharedPref.setTransmissionTimer(transmissionTimer.value);
    return [
      buildLimitPacket(
        sensorId: SensorId.general,
        uLimit: transmissionTimer.value, // interval
        lLimit: vBatMin.value,           // min battery
        triggerEnable: true,
      ),
      buildLimitPacket(
        sensorId: SensorId.temperature,
        uLimit: temperatureMax.value,
        lLimit: temperatureMin.value,
        triggerEnable: true,
      ),
      buildLimitPacket(
        sensorId: SensorId.humidity,
        uLimit: humidityMax.value,
        lLimit: humidityMin.value,
        triggerEnable: true,
      ),
      buildLimitPacket(
        sensorId: SensorId.motion,
        uLimit: motionMax.value,
        lLimit: motionMin.value,
        triggerEnable: true,
      ),
      buildLimitPacket(
        sensorId: SensorId.sound,
        uLimit: soundMax.value,
        lLimit: soundMin.value,
        triggerEnable: true,
      ),
      buildLimitPacket(
        sensorId: SensorId.light,
        uLimit: lightMax.value,
        lLimit: lightMin.value,
        triggerEnable: true,
      ),
      buildLimitPacket(
        sensorId: SensorId.analog1,
        uLimit: analog1Max.value,
        lLimit: analog1Min.value,
        triggerEnable: true,
      ),
      buildLimitPacket(
        sensorId: SensorId.analog2,
        uLimit: analog2Max.value,
        lLimit: analog2Min.value,
        triggerEnable: true,
      ),
    ];
  }
  Future<void> savePacketsToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final packets = buildAllPackets();
    // Convert each Uint8List to a base64 string
    final encoded = packets.map((pkt) => base64Encode(pkt)).toList();
    await prefs.setStringList("sensor_packets", encoded);
    prefs.reload();
    debugPrint("✅ Saved ${encoded.length} packets to SharedPreferences");
    for (var pkt in packets) {
      debugPrint("Built Packet: ${pkt.map((b) => b.toRadixString(16).padLeft(2, '0')).join(' ')}");
    }
  }

  /// Load packets from SharedPreferences

  void saveSettings() {
    savePacketsToPrefs();
    BackgroundService().onSensorSettingUpdated();
    Get.back();

    // TODO: Send packets via BLE write or MQTT publish

  }
}
