import 'package:get/get.dart';

import '../../../components/MqttController.dart';
import '../../../components/api_service.dart';
import '../../../routes/app_pages.dart';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class LoginController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var isLoading = false.obs;

  final ApiService _apiService = ApiService();
  final MqttController mqttController = Get.put(MqttController());

  @override
  Future<void> onInit() async {
    super.onInit();
    bool granted = await _checkAndRequestPermissions();

  }

  Future<void> login() async {
    isLoading.value = true;

    try {
      // ✅ Ensure required permissions first
      bool granted = await _checkAndRequestPermissions();
      if (!granted) {
        Get.snackbar("Permission Required",
            "Please allow Location, Nearby devices, and Notification permissions to continue.");
        isLoading.value = false;
        return;
      }

    //  startMQTTService();

      final loginResponse = await _apiService.login(
        loginId: email.value,
        password: password.value,
        appType: "Android",
        mscId: "7ba1ea4e7c20d500",
        appVersion: "2.0.548",
        orgName: "OFE",
      );

      if (loginResponse != null) {
        Get.offAllNamed(AppPages.HOME);
      } else {
        Get.snackbar("Error", "Login failed");
      }
    } finally {
      isLoading.value = false;
    }
  }

  /// ✅ Permission handling
  Future<bool> _checkAndRequestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.bluetoothScan, // Nearby devices scan (Android 12+)
      Permission.bluetoothConnect, // Nearby devices connect (Android 12+)
      Permission.notification,
    ].request();

    bool allGranted = statuses.values.every((status) => status.isGranted);

    return allGranted;
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
}
