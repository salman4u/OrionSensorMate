import 'package:get/get.dart';

import '../controllers/devices_details_list_controller.dart';

class DevicesDetailsListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DevicesDetailsListController>(
      () => DevicesDetailsListController(),
    );
  }
}
