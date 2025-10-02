import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sensor_mate/app/components/light_theme_colors.dart';

import '../../../utility/Utility.dart';
import '../controllers/pair_sensor_device_controller.dart';

class PairSensorDeviceView extends StatelessWidget {
  final PairSensorDeviceController controller = Get.put(PairSensorDeviceController());
  List<String> levelNames = ['sffsfasdefdsfs', 'XCOM5G', 'XCOM5G-0043','AT&T','24 Nov 2024','Tracking Route 22 LA','123 Main St, MyCity, ST, Zip'];
  List<String> icons = ['serial_number.png', 'device_icon_small.png', 'device_id_icon.png','calender_icon_small.png','calender_icon_small.png','tracking_route.png','location_icon_small.png'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set black background as in the image
      appBar: AppBar(
        title: const Text("Pair XCOM5GC", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white)), // Adjust title as per your need
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.home,color:Colors.white),
            onPressed: () {
              // Action for home button
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list,color: Colors.white),
            onPressed: () {
              // Action for filter button
            },
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF08172E),  // Top dark blue color
              Color(0xFF12283C),  // Bottom gradient color
            ],
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tab buttons
            Row(
              children: [
                _buildTabButton("Pair XSEN5G", isActive: true),
                _buildTabButton("Current XSEN5G", isActive: false),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Select Device",
              style: TextStyle(
                color: Colors.white, // Set font color as white
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 10),
            // List of devices (example static content)
            Expanded(
              child: ListView(
                children: [
                  _buildDeviceTile(
                    deviceName: "Device Name-1",
                    isSelected: false,
                    isOnline: true,
                  ),
                  _buildDeviceTile(
                    deviceName: "Device Name-2",
                    isSelected: true,
                    isOnline: true,
                  ),
                  _buildDeviceTile(
                    deviceName: "Device Name-1",
                    isSelected: false,
                    isOnline: false,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            // Select Button
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: LightThemeColors.loginBtnColor, // Button color
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  Utility.showDeactivateDeviceAlert(Get.context as BuildContext,'pair_icon','Pairing Devices','you are about to pair XCOM5G-0025 with XSEN5G-1234. Do you want to pair:',true, isTextLeftAlign:true);
                  // Select action
                },
                child: const Text(
                  "PAIR",
                  style: TextStyle(
                    fontSize: 18,
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

  Widget _buildTabButton(String text, {required bool isActive}) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          // Tab click action
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isActive ? Color(0xFF617083) : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDeviceTile({
    required String deviceName,
    required bool isSelected,
    required bool isOnline,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? Color(0xFF617083) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Checkbox(
                value: isSelected,
                onChanged: (value) {
                  // Checkbox select action
                },
                activeColor: const Color(0xFF64C7DB),
                checkColor: Colors.white,
              ),
              Text(
                deviceName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Icon(
                Icons.circle,
                color: isOnline ? Colors.green : Colors.red,
                size: 12,
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            "sffsfasdefdsfs",
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 12,
            ),
          ),

          ...List.generate(levelNames.length, (index) {
            return IconTextRow(
              text: levelNames[index],  // Adjust text dynamically
              imageAsset: "assets/images/${icons[index]}",  // Replace with your image asset path
              fontSize: 12,
              textColor: Colors.grey[400]!,
              iconSize: 16,
            );
          }),
          // Add more fields here as per your data structure (similar to image)
        ],
      ),
    );
  }
}

class IconTextRow extends StatelessWidget {
  final String text;
  final IconData? icon;  // Optional icon if you're using Material Icons
  final String? imageAsset; // Optional image asset path
  final double iconSize;
  final double fontSize;
  final Color textColor;

  const IconTextRow({
    Key? key,
    required this.text,
    this.icon,
    this.imageAsset,
    this.iconSize = 16.0,
    this.fontSize = 12.0,
    this.textColor = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null) Icon(icon, size: iconSize, color: textColor),
        if (imageAsset != null)
          Image.asset(
            imageAsset!,
            width: iconSize,
            height: iconSize,
            color: textColor,  // Optional, if you want to colorize the image
          ),
        SizedBox(width: 6), // Space between icon/image and text
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            color: textColor,
          ),
        ),
      ],
    );
  }
}
