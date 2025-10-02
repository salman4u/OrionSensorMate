import 'package:get/get.dart';

import '../controllers/in_vehicle_controller.dart';

class InVehicleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InVehicleController>(
      () => InVehicleController(),
    );
  }
}
