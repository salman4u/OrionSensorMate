import 'package:get/get.dart';

import 'package:get/get.dart';
import 'package:sensor_mate/app/routes/app_pages.dart';

import '../../../components/api_service.dart';
import '../../../data/models/login_response.dart';
import '../../login/views/login_view.dart';
import 'package:permission_handler/permission_handler.dart';

class WelcomeController extends GetxController {
  final ApiService api = ApiService();
  @override
  void onReady() {
    super.onReady();
    _checkLoginStatus();
    _checkAndRequestPermissions();
  }
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

  Future<void> _checkLoginStatus() async {
    LoginResponse? savedData = await api.getSavedLoginData();
    if (savedData != null) {
      Get.offAllNamed(AppPages.HOME);
    }
  }

  Future<void> onLoginPressed() async {
    LoginResponse? savedData = await api.getSavedLoginData();
    if (savedData != null) {
      Get.toNamed(AppPages.HOME);
      return;
    }
    Get.toNamed(AppPages.LOGIN) ;// Handle login button pressed
    print("Login button pressed");
  }

  void onRegisterPressed() {
    Get.toNamed(AppPages.REGISTER);
  }
  void onForgotPasswordPressed() {
    showForgotPasswordDialog();
    print("Forgot password pressed");
  }
}
