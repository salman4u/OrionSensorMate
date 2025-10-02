import 'dart:async';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:sensor_mate/app/data/local/my_shared_pref.dart';

import '../../../components/MqttController.dart';
import '../../../components/api_service.dart';
import '../../../components/background_service.dart';
import '../../../data/models/login_response.dart';
import '../../DevicesDetailsList/controllers/devices_details_list_controller.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  final ApiService api = ApiService();
  var deviceList = <Device>[].obs;
   final BackgroundService backgroundService = BackgroundService();
  final count = 0.obs;
  Timer? _repeatingTimer; // Declare a nullable Timer variable to hold the timer instance
  var connectionStatus = 'Disconnected'.obs;
  final MqttController mqttController = Get.put(MqttController());

  @override
  void onInit() {
    super.onInit();
    loadDevicesFromApi();
    startRepeatingTimer();
    startMQTTService();
  }
  void startRepeatingTimer() {
    _repeatingTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      MySharedPref.reloadPreferences();
      String status = MySharedPref.getEldConnectionStatus();
        connectionStatus.value = status;
    });
  }
  void startMQTTService() {
    final MqttController mqttController = Get.find<MqttController>();

    mqttController.onConnectedCallback = (reconnect) {
      print('Connected to MQTT broker (reconnect: $reconnect)');
    };
    mqttController.onDisconnectedCallback = (cause) {
      print('Disconnected from MQTT broker: $cause');
    };
    mqttController.onMessageCallback = (topic, payload) {
      print('Received message on $topic: $payload');
    };
    mqttController.onErrorCallback = (stage, error) {
      print('Error in $stage: $error');
    };
  }
  Future<void> loadDevicesFromApi() async {
    const orgName = "OFE";
    LoginResponse? savedData = await api.getSavedLoginData();
    final guid = savedData!.guid;
    final vehicleId = savedData!.vehicleId;
    final devices =
    await api.getCradlesCanHubList(orgName: orgName, guid: guid, vehicleId: vehicleId);
    deviceList.value = devices;
  }
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
