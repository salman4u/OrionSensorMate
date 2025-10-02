import 'package:get/get.dart';

class AddAddressController extends GetxController {
  // Variables to store form input
  var fullName = ''.obs;
  var email = ''.obs;
  var phone = ''.obs;
  var address1 = ''.obs;
  var address2 = ''.obs;
  var city = ''.obs;
  var zipCode = ''.obs;

  // Method to handle the add button click
  void onAddPressed() {
    // Perform form validation or saving logic here
    print('Address Added');
  }
}
