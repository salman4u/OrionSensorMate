import 'package:get/get.dart';

class RegisterXCOM5GCController extends GetxController {
  var deviceName = ''.obs;
  var serialNumber = ''.obs;
  var deviceId = ''.obs;
  var date = DateTime.now().obs;
  var useDescription = ''.obs;
  var location = ''.obs;

  // Functions to update the values from input fields
  void updateDeviceName(String value) => deviceName.value = value;
  void updateSerialNumber(String value) => serialNumber.value = value;
  void updateDeviceId(String value) => deviceId.value = value;
  void updateUseDescription(String value) => useDescription.value = value;
  void updateLocation(String value) => location.value = value;

  // Function to save the device information
  void saveDevice() {
    // Implement your save logic here
    print('Device saved');
  }

  // Function to cancel the operation
  void cancel() {
    // Implement your cancel logic here
    Get.back();
  }
}
