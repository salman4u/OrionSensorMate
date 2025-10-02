import 'package:get/get.dart';

class ProfileController extends GetxController {
  var firstName = ''.obs;
  var lastName = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
  var reEnterPassword = ''.obs;

  void updateProfile() {
    // Logic for updating the profile
    if (password.value == reEnterPassword.value) {
      // Call API or perform update
      print("Profile updated successfully!");
    } else {
      print("Passwords do not match!");
    }
  }
}
