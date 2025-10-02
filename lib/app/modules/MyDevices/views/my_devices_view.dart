import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sensor_mate/app/components/light_theme_colors.dart';

import '../../../routes/app_pages.dart';
import '../../../utility/Utility.dart';
import '../../home/views/home_view.dart';
import '../controllers/my_devices_controller.dart';

class MyDevicesView extends GetView<MyDevicesController> {
  final MyDevicesController controller = Get.put(MyDevicesController());
  MyDevicesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title:  Obx(
              () => Text(
         controller.title.value ,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),),
        leading: IconButton(
          icon: Image.asset(
            'assets/images/back_icon.png',  // Replace with your image path
            width: 30,  // Adjust the width
            height: 30,  // Adjust the height
          ),
          onPressed: () {
            Get.back();
          },
        ),
        iconTheme: const IconThemeData(
            color: Colors.white
        ),
      ),
      body: Container(
        color: Colors.black,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/images/bg.png'),
            ),
          ),

          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildGridItem(1, 'Register',controller, () {
                  // Add navigation or action
                }),
                _buildGridItem(2, 'My Devices',controller, () {
                  // Add navigation or action
                }),
                _buildGridItem(3, 'Firmware Update',controller, () {
                  // Add navigation or action
                }),
              Obx(() => Visibility(
                visible: controller.title.value == 'XSEN5G' ? false : true,
                child: _buildGridItem(4, 'Pair Device', controller, () {
                  // Add navigation or action
                }),
              )),
            Obx(() => Visibility(
              visible: controller.title.value == 'XSEN5G' ? false : true,
                child: _buildGridItem(5, 'In vehicleECU',controller, () {
                    // Add navigation or action
                  }),
            ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGridItem(int index, String title,MyDevicesController controller, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('assets/images/bg_home_icon.png'),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Obx(() => Image.asset(
                getImageName(index, controller.title.value),  // Replace with your image path
                width: 65,  // Adjust the width
                height: 65,  // Adjust the height
              )),
              onPressed: () {
                navigate(index,controller.title.value);
                // Add menu action here
              },
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getImageName(int index,String sensor) {
    if(index == 1) {
      return 'assets/images/register_device.png';
    }
    else if(index == 2) {
      return 'assets/images/my_devices.png';
    }
    else if(index == 3 && sensor=="XCOM5G") {
      return 'assets/images/firmware_update_ac.png';
    }
    else if(index == 3) {
      return 'assets/images/firmware_inactive.png';
    }
    else if(index == 4) {
      return 'assets/images/pair_device.png';
    }
    else if(index == 5) {
      return 'assets/images/in_vehicle.png';
    }
    return 'assets/images/register_device.png';
  }

  void navigate(int index,String title) {
    if(index == 1){
      Get.toNamed(AppPages.REGISTER_DEVICE, arguments: {'sensor': controller.selectedSensor});
    }
    else if(index == 2){
      Get.toNamed(AppPages.DEVICES_DETAILS_LIST, arguments: {'sensor': controller.selectedSensor});
    }
    else if(index == 3 && title == "XCOM5G"){
      Utility.showDeactivateDeviceAlert(Get.context as BuildContext,'firmware_update','Firmware Update Available','Name: Device Name-1\nDevice ID: XCOM5G-0043\nS/N: easjsbkdfska\nCurrent Firmware version: v11\nNew Firmware version: v12',true);
    }
    else if(index == 4){
      Get.toNamed(AppPages.PAIR_SENSOR_DEVICE);
    }
    else if(index == 5){
      showBlurryAlert(Get.context as BuildContext);
    }
  }
}

class BlurryAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF2E323A), Color(0xFF1C1C1E)], // Gradient background
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.menu_book, color: Colors.white, size: 28),
                SizedBox(width: 10),
                Text(
                  'Instructions',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            const Text(
              'You can use your device to either obtain vehicle diagnostic and monitoring data or as an approved FMCSA ELD (you will need a different app for this use).',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            const SizedBox(height: 10),
            const SizedBox(
              height: 250,
              child: Text(
                '\nFor vehicle diagnostic data, you will need to connect your device to any vehicle that supports the J1939 vehicle diagnostic data protocol which is the most common from 1996. You will need a cable that supports a 9-pin circular or 16-pin D connector at one end (based on your vehicle) and a DB-9 connector at the other. You connect the cable to the vehicle connector that is on the left side underneath your vehicle dashboard and the DB-9 into your device.',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Make sure your phone or tablet Bluetooth is on and you are paired to your device.',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Checkbox(
                  value: true,
                  onChanged: (bool? value) {
                    // Handle checkbox logic
                  },
                  activeColor: const Color(0xFF4FC3F7),
                ),
                const Text(
                  'And do not show this again',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  Get.toNamed(AppPages.IN_VEHICLE);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: LightThemeColors.loginBtnColor, // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showBlurryAlert(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true, // User can dismiss the dialog by tapping outside
    builder: (BuildContext context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: BlurryAlert(),
      );
    },
  );
}


