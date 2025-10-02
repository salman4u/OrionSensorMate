import 'package:get/get.dart';

import '../controllers/register_x_c_o_m5_g_c_controller.dart';

class RegisterXCOM5GCBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterXCOM5GCController>(
      () => RegisterXCOM5GCController(),
    );
  }
}
