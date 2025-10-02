import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../components/light_theme_colors.dart';
import '../controllers/register_x_c_o_m5_g_c_controller.dart';

class RegisterXCOM5GCView extends StatelessWidget {
  final RegisterXCOM5GCController controller = Get.put(RegisterXCOM5GCController());
  RegisterXCOM5GCView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Register XCOM5GC', style: TextStyle(fontSize: 24, color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Name Field with background image
                  buildField('XSEN5G',"my_devices", controller.updateDeviceName),
                  const SizedBox(height: 10),
                  buildField('Name',"name_icon", controller.updateDeviceName),
                  const SizedBox(height: 10),
                  buildField('S/N Number', "serial_number", controller.updateDeviceName),
                  const SizedBox(height: 10),
                  buildField('Device ID', "device_id_icon", controller.updateDeviceName),
                  const SizedBox(height: 10),
                  buildField('Select Provider', "sim_icon", controller.updateDeviceName),
                  const SizedBox(height: 10),
                  buildField('Gateway', "gate_way", controller.updateDeviceName),
                  const SizedBox(height: 10),
                  buildField('Password', "password_icon", controller.updateDeviceName),
                  const SizedBox(height: 10),
                  buildField('Data Plan (max MB / month)', "data_plan", controller.updateDeviceName),
                  const SizedBox(height: 10),

                  // Date Field
                  Obx(() => Container(
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
                        labelStyle: const TextStyle(color: LightThemeColors.prefixIconColor),
                        labelText: DateFormat('dd MMM yyyy').format(controller.date.value),
                        prefixIcon: const Icon(Icons.calendar_today, color: LightThemeColors.prefixIconColor),
                        border: InputBorder.none,
                      ),
                    ),
                  )),
                  const SizedBox(height: 10),
                  // Use Field
                  buildField('Use', "in_use_icon_small", controller.updateDeviceName),
                  const SizedBox(height: 10),
                  buildField('Location', "location_icon_small", controller.updateDeviceName),
                  const SizedBox(height: 20),
                  // Cancel and Save Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildButton('Cancel', controller.cancel),
                      ElevatedButton(
                        onPressed: controller.saveDevice,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: LightThemeColors.loginBtnColor,
                        ),
                        child: const Text('Save', style: TextStyle(fontSize: 24, color: Colors.white)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to create text fields
  Widget buildField(String label, String iconName, Function(String) onChanged) {
    return Container(
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/images/bg_sensor_list_item.png'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: TextField(
          cursorColor: Colors.white,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: label,

            labelStyle: const TextStyle(color: LightThemeColors.prefixIconColor),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12.0), // Adjust padding to fit the image
              child: Image.asset(
                'assets/images/$iconName.png',
                width: 24,
                height: 24,
                color: LightThemeColors.prefixIconColor, // Optional: To apply a tint
              ),
            ),
            border: InputBorder.none,
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }

  // Helper method to create buttons
  Widget buildButton(String text, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/images/bg_sensor_list_item.png'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 5,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent.withOpacity(0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onPressed,
        child: Text(text, style: const TextStyle(fontSize: 24, color: Colors.white)),
      ),
    );
  }
}
