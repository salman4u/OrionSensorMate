import 'package:get/get.dart';

class RegisterDeviceManuallyController extends GetxController {
  var deviceName = ''.obs;
  var serialNumber = ''.obs;
  var deviceId = ''.obs;
  var date = DateTime.now().obs;
  var useDescription = ''.obs;
  var location = ''.obs;
  var deviceType = ''.obs;

  @override
  void onInit() {
    super.onInit();

    // Get the passed arguments
    var argumentData = Get.arguments;

    // Set the values based on the arguments if they exist
    if (argumentData != null) {
      deviceType.value = argumentData['selectedSensor'] ?? '';
    }
  }

  // Functions to update the values from input fields
  void updateDeviceName(String value) => deviceName.value = value;
  void updateSerialNumber(String value) => serialNumber.value = value;
  void updateDeviceId(String value) => deviceId.value = value;
  void updateUseDescription(String value) => useDescription.value = value;
  void updateLocation(String value) => location.value = value;

  // Function to save the device information
  void saveDevice() {
    print('Device saved');
  }

  // Function to cancel the operation
  void cancel() {
    // Implement your cancel logic here
    Get.back();
  }
}

