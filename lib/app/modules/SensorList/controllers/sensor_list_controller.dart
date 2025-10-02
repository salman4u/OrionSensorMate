import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sensor_mate/app/routes/app_pages.dart';

import '../views/sensor_list_view.dart';

class SensorListController extends GetxController {
  // Add any logic or state management here if needed
  final sensors = ['XCOM5G', 'XCOM5GC', 'XSEN5G'].obs;
  void onSensorSelected(String sensor) {
    Get.toNamed(AppPages.MY_DEVICES, arguments: {'sensor': sensor});
    print("Selected sensor: $sensor");
  }

  void onFilterPressed() {
    // Handle filter action
    showFilterDialog(Get.context as BuildContext);
    print("Filter button pressed");
  }
}
