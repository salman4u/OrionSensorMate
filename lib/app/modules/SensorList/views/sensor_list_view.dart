import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sensor_mate/app/components/light_theme_colors.dart';
import '../controllers/sensor_list_controller.dart';
class SensorListView extends GetView<SensorListController> {
  const SensorListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Sensors',  style: TextStyle(color: Colors.white, fontSize: 30)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back(); // Go back to the previous screen
          },
        ),
        iconTheme: const IconThemeData(
            color: Colors.white
        ),
      ),
      body: Obx(() => Container(
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
          child: ListView.builder(
            itemCount: controller.sensors.length,
            itemBuilder: (context, index) {
              final sensor = controller.sensors[index];
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/images/bg_sensor_list_item.png'),
                    ),
                  ),
                  child: ListTile(
                    title: Text(
                      sensor,
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                    onTap: () => controller.onSensorSelected(sensor),
                    tileColor: Colors.black45,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    // Adjust padding as necessary
                  ),
                ),
              );
            },
            padding: const EdgeInsets.all(16),
          ),
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.onFilterPressed,
        backgroundColor: LightThemeColors.loginBtnColor,
        child: const Icon(Icons.filter_alt, color: Colors.white),
      ),
      backgroundColor: Colors.black, // To match the background in the screenshot
    );
  }
}


  void showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(

          insetPadding: const EdgeInsets.all(10),
          backgroundColor: const Color(0xFF35363A), // Background color of alert dialog
          contentPadding: const EdgeInsets.all(16.0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(0.0)),
          ),
          content:  Builder(
            builder: (context) {
          // Get available height and width of the build area of this widget. Make a choice depending on the size.
          var height = MediaQuery.of(context).size.height;
          var width = MediaQuery.of(context).size.width;

          return SizedBox(
            width: width - 50,
              child:Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.filter_list, color: Colors.white), // Filter icon
                      SizedBox(width: 10),
                      Text('Filters', style: TextStyle(color: Colors.white, fontSize: 18)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildTextField('S/N', context),
                  _buildTextField('Type', context),
                  _buildTextField('Device ID', context),
                  _buildTextField('SIM ID', context),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 15),
                      SizedBox(
                        width: 150,
                        height: 45,// Adjust the width as per your need
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF3F4044), // Button background color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        height: 45,// Adjust the width as per your need
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(30, 156, 176, 1), // OK button color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          onPressed: () {
                            // Handle OK button action
                          },
                          child: const Text('OK', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      const SizedBox(width: 15)
                    ],
                  )
                ],
              )

          );
        },
        ),
        );
      },
    );
  }

  Widget _buildTextField(String label, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        style: const TextStyle(color: Colors.white), // Font color similar to the image
        decoration: InputDecoration(
          labelText: label,
          fillColor: LightThemeColors.textFieldBgColor3,
          labelStyle: const TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white24),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
        ),
      ),
    );
  }
