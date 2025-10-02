import 'package:get/get.dart';

import '../controllers/register_device_controller.dart';

class RegisterDeviceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterDeviceController>(
      () => RegisterDeviceController(),
    );
  }
}
