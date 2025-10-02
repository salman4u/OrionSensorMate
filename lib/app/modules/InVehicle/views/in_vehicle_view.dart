import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sensor_mate/app/components/light_theme_colors.dart';
import '../../../utility/Utility.dart';
import '../../MyDevices/views/my_devices_view.dart';
import '../controllers/in_vehicle_controller.dart';

class InVehicleView extends StatelessWidget {
  final InVehicleController controller = Get.put(InVehicleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("In Vehicle ECU", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white)), // Adjust title as per your need
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline,color:Colors.white),
            onPressed: () {
              showBlurryAlert(Get.context as BuildContext);
              // Add action if needed
            },
          ),
        ],
        backgroundColor: Colors.black,
        elevation: 0,
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
            padding: const EdgeInsets.only(left: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Vehicle Name',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Make: Mercedes',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                const Text(
                  'Model: E500',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    showDiagnosticDialog(context);
                    // Add diagnostics button action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: LightThemeColors.loginBtnColor, // Button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    minimumSize: Size.zero,
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  ),
                  child: const Text('Diagnostics', style: TextStyle(color: Colors.white)),
                ),
                Divider(
                  color: Colors.grey.shade800,
                  thickness: 1,
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
  void showDiagnosticDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              // Blurry background effect
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              // Main content
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color(0xFF2C3844), // Dark gray color for the dialog
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.directions_car, color: Colors.white, size: 40),
                        SizedBox(width: 10),
                        Text(
                          'Diagnostics',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Your device default settings will pull the following PGN information from your vehicle ECU computer:',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '65520, 65265, 65132, 65215, 65256, 65267,\n65262, 65266, 65263, 65253, 65217, 65263,\n65265, 65260, 65248, 60416, 60160, 65210,\n64914, 65134, 65206, 65269, 65279, 65271, 65268',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                     Text(
                      'If you need additional information,\nplease contact',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Text(
                      'support@logistiwerx.com',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: LightThemeColors.loginBtnColor,
                        color: LightThemeColors.loginBtnColor,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:LightThemeColors.loginBtnColor, // Button color
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'OK',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }


