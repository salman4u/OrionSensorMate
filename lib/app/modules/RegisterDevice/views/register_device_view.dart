import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sensor_mate/app/components/light_theme_colors.dart';

import '../controllers/register_device_controller.dart';

class RegisterDeviceView extends StatelessWidget {
  final RegisterDeviceController controller = Get.put(RegisterDeviceController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title:  Text('Register ${controller.deviceType.value}', style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        )),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
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
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Center(
                    child: Column(
                      children: [
                        // Simulated QR Code
                        Container(
                          width: 200,
                          height: 200,
                          child: Image.asset('assets/images/qr_code.png'), // Add QR code image to assets
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Scan the QR code to register the Device',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Expanded(
                      child: Divider(),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('or',style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      )),
                    ),
                    Expanded(
                      child: Divider(),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: controller.registerManually,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: LightThemeColors.loginBtnColor,
                  ),
                  child: const Text('Register Manually',  style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
