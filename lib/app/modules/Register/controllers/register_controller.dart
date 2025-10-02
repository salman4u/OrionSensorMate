import 'package:get/get.dart';

class RegisterController extends GetxController {
  // Form fields for registration
  var firstName = ''.obs;
  var lastName = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
  var confirmPassword = ''.obs;

  // Example method for registering a user
  void registerUser() {
    if (password.value == confirmPassword.value) {
      // Proceed with registration logic
    } else {
      Get.snackbar('Error', 'Passwords do not match');
    }
  }
}
