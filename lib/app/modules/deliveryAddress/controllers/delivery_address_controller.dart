import 'package:get/get.dart';

class DeliveryAddressController extends GetxController {
  var selectedAddress = 0.obs;

  // Dummy addresses for demonstration purposes
  final List<Map<String, String>> addresses = [
    {
      'name': 'Kaydon Stanzione',
      'address': '123 Main St, MyCity, ST, Zip',
      'phone': '1234567890',
      'email': 'hello@gmail.com',
    },
    {
      'name': 'Kaydon Stanzione',
      'address': '123 Main St, MyCity, ST, Zip',
      'phone': '1234567890',
      'email': 'hello@gmail.com',
    },
  ];

  // Function to select an address
  void selectAddress(int index) {
    selectedAddress.value = index;
  }
}
