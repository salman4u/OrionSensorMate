import 'package:get/get.dart';

import '../controllers/edit_pgn_controller.dart';

class EditPgnBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditPgnController>(
      () => EditPgnController(),
    );
  }
}
