import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/utils/utility.dart';
import 'package:get/get.dart';
import 'package:sensor_mate/app/routes/app_pages.dart';

import '../../../components/api_service.dart';
import '../../../components/custom_snackbar.dart';
import '../../../data/database/HubDatabase.dart';
import '../../../data/models/Hub.dart';
import '../../../data/models/login_response.dart';

class RegisterDeviceController extends GetxController {
  // You can add your logic and variables here.
  // For now, we are just mocking QR scan and manual register functionalities.
  String? selectedSensor;
  final deviceType = "".obs;
  final manNumberController = TextEditingController();
  final hubNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final didController = TextEditingController();
  final hubTypeController = TextEditingController();
  String? selectedHubType; // put this at state level (or in controller)
  final ApiService api = ApiService();

  @override
  void onInit() {
    super.onInit();
    try {
      if (Get.arguments != null && Get.arguments['sensor'] != null) {
        selectedSensor = Get.arguments['sensor'];
        deviceType.value = selectedSensor!;
        print("Received sensor: $selectedSensor");
      } else {
        print("No sensor passed.");
      }
    }
    catch(e){
      e.printError();
    }
    print("Received sensor: $selectedSensor");
  }
  void scanQrCode() {
    // Add logic to scan QR code
    print('QR Code Scanned');
  }

  void registerManually() {
    _showAddHubDialog(Get.context! as BuildContext);
    // if(selectedSensor == "XCOM5GC"){
    //   Get.toNamed(AppPages.REGISTER_X_C_O_M5_G_C);
    // }
    // else {
    //   Get.toNamed(AppPages.REGISTER_DEVICE_MNUALLY, arguments: {
    //     'selectedSensor': selectedSensor, // Add more key-value pairs as needed
    //   });
    // }
    print('Manual Registration');
  }
  void _showAddHubDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Hub"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: manNumberController,
                  decoration: InputDecoration(labelText: "MAN Number (TD)"),
                ),
                TextField(
                  controller: hubNameController,
                  decoration: InputDecoration(labelText: "Hub Name"),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: "Description"),
                ),
                TextField(
                  controller: didController,
                  decoration: InputDecoration(labelText: "DID"),
                ),
                DropdownButtonFormField<String>(
                  value: selectedHubType,
                  decoration: const InputDecoration(labelText: "Hub Type"),
                  items: const [
                    DropdownMenuItem(value: "XCOM5G", child: Text("XCOM5G")),
                    DropdownMenuItem(value: "XCOM5GC", child: Text("XCOM5GC")),
                    DropdownMenuItem(value: "XSEN5G", child: Text("XSEN5G")),
                  ],
                  onChanged: (value) {
                    selectedHubType = value;
                  },
                ),

              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                final hub = Hub(
                  manNumber: manNumberController.text,
                  hubName: hubNameController.text,
                  description: descriptionController.text,
                  did: didController.text,
                  hubType: selectedHubType!, // ✅ use dropdown value
                );
                LoginResponse? savedData = await api.getSavedLoginData();
                const orgName = "OFE";
                final guid = savedData!.guid;
                final driverId = savedData!.driverId;
                final sucess = await api.addDevice(orgName: orgName, guid: guid, driverId: driverId,hubName: hubNameController.text, hubTD: manNumberController.text, hubType: selectedHubType!, description: descriptionController.text, imei: didController.text, did: didController.text);
                await HubDatabase.instance.insertHub(hub);
                CustomSnackBar.showCustomToast(
                  message: 'Device added successfully',
                  title: 'Notice!',
                );
                // refresh hub list

                Navigator.pop(context); // close dialog
                Navigator.pop(context); // close dialog

              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

}
