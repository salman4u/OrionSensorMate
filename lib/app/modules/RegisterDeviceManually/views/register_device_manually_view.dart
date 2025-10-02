import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sensor_mate/app/components/light_theme_colors.dart';

import '../controllers/register_device_manually_controller.dart';

class RegisterDeviceManuallyView extends StatelessWidget {
  final RegisterDeviceManuallyController controller = Get.put(RegisterDeviceManuallyController());
   RegisterDeviceManuallyView({super.key});
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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Name Field with background image
                Container(
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/images/bg_sensor_list_item.png'), // Add your image path
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10), // Optional: Add corner radius
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child:TextField(style: const TextStyle(color: Colors.white),
                      decoration:  InputDecoration(
                        labelText: 'XSEN5G',
                        labelStyle: const TextStyle(
                            color:  Colors.white
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12.0), // Adjust padding to fit the image
                          child: Image.asset(
                            'assets/images/my_devices.png',
                            width: 24,
                            height: 24,
                            color: LightThemeColors.prefixIconColor, // Optional: To apply a tint
                          ),
                        ),
                        border: InputBorder.none, // Remove border
                      ),
                      onChanged: controller.updateDeviceName,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Serial Number Field
                Container(
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/images/bg_sensor_list_item.png'), // Add your image path
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10), // Optional: Add corner radius
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child:TextField(style: const TextStyle(color: Colors.white),
                      decoration:  InputDecoration(
                        labelText: 'Name.',
                        labelStyle: const TextStyle(
                            color:  Colors.white
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12.0), // Adjust padding to fit the image
                          child: Image.asset(
                            'assets/images/name_icon.png',
                            width: 24,
                            height: 24,
                            color: LightThemeColors.prefixIconColor, // Optional: To apply a tint
                          ),
                        ),
                        border: InputBorder.none, // Remove border
                      ),
                      onChanged: controller.updateDeviceName,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Device ID Field
                Container(
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/images/bg_sensor_list_item.png'), // Add your image path
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10), // Optional: Add corner radius
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child:TextField(style: const TextStyle(color: Colors.white),
                      decoration:  InputDecoration(
                        labelText: 'S/N Number',
                        labelStyle: const TextStyle(
                            color:  Colors.white
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12.0), // Adjust padding to fit the image
                          child: Image.asset(
                            'assets/images/serial_number.png',
                            width: 24,
                            height: 24,
                            color: LightThemeColors.prefixIconColor, // Optional: To apply a tint
                          ),
                        ),
                        border: InputBorder.none, // Remove border
                      ),
                      onChanged: controller.updateDeviceName,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/images/bg_sensor_list_item.png'), // Add your image path
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10), // Optional: Add corner radius
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child:TextField(style: const TextStyle(color: Colors.white),
                      decoration:  InputDecoration(
                        labelText: 'Device ID',
                        labelStyle: const TextStyle(
                            color:  Colors.white
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12.0), // Adjust padding to fit the image
                          child: Image.asset(
                            'assets/images/device_id_icon.png',
                            width: 24,
                            height: 24,
                            color: LightThemeColors.prefixIconColor, // Optional: To apply a tint
                          ),
                        ),
                        border: InputBorder.none, // Remove border
                      ),
                      onChanged: controller.updateDeviceName,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Date Field (Static Date in Screenshot)
                 Container(
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/images/bg_sensor_list_item.png'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(
                          color:  Colors.white
                      ),
                      labelText: DateFormat('dd MMM yyyy').format(controller.date.value),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0), // Adjust padding to fit the image
                        child: Image.asset(
                          'assets/images/calender_icon_small.png',
                          width: 24,
                          height: 24,
                          color: LightThemeColors.prefixIconColor, // Optional: To apply a tint
                        ),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Use Field// Location Field
                Container(
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/images/bg_sensor_list_item.png'), // Add your image path
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10), // Optional: Add corner radius
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child:TextField(style: const TextStyle(color: Colors.white),
                      decoration:  InputDecoration(
                        labelText: 'Use',
                        labelStyle: const TextStyle(
                            color:  Colors.white
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12.0), // Adjust padding to fit the image
                          child: Image.asset(
                            'assets/images/in_use_icon_small.png',
                            width: 24,
                            height: 24,
                            color: LightThemeColors.prefixIconColor, // Optional: To apply a tint
                          ),
                        ),
                        border: InputBorder.none, // Remove border
                      ),
                      onChanged: controller.updateDeviceName,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                Container(
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/images/bg_sensor_list_item.png'), // Add your image path
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10), // Optional: Add corner radius
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child:TextField(style: const TextStyle(color: Colors.white),
                      decoration:  InputDecoration(
                        labelText: 'Location',
                        labelStyle: const TextStyle(
                            color:  Colors.white
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12.0), // Adjust padding to fit the image
                          child: Image.asset(
                            'assets/images/location_icon_small.png',
                            width: 24,
                            height: 24,
                            color: LightThemeColors.prefixIconColor, // Optional: To apply a tint
                          ),
                        ),
                        border: InputBorder.none, // Remove border
                      ),
                      onChanged: controller.updateDeviceName,
                    ),
                  ),
                ),

                const Spacer(),
                // Cancel and Save Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: LightThemeColors.inactiveColor,
                        shadowColor: Colors.transparent.withOpacity(0.1),
                        minimumSize: const Size(120, 45), // Increased width by 20 and height by 10
                      ),
                      onPressed: controller.cancel,
                      child: const Text(
                        '  Cancel  ',
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: controller.saveDevice,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: LightThemeColors.loginBtnColor,
                        minimumSize: const Size(120, 45), // Increased width by 20 and height by 10
                      ),
                      child: const Text(
                        '   Save   ',
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 30),
                  ],
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
