import 'package:get/get.dart';

import '../controllers/cart_details_controller.dart';

class CartDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartDetailsController>(
      () => CartDetailsController(),
    );
  }
}
