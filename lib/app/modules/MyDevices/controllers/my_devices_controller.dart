import 'package:get/get.dart';

class MyDevicesController extends GetxController {
  final count = 0.obs;
  String? selectedSensor;
  final title = "".obs;
  @override
  void onInit() {
    super.onInit();
    try {
      if (Get.arguments != null && Get.arguments['sensor'] != null) {
        selectedSensor = Get.arguments['sensor'];
        print("Received sensor: $selectedSensor");
        title.value = selectedSensor!;
      } else {
        print("No sensor passed.");
      }
    }
    catch(e){
      e.printError();
    }
    print("Received sensor: $selectedSensor");
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
