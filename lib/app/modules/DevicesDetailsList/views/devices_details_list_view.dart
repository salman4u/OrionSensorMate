import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sensor_mate/app/components/light_theme_colors.dart';
import 'package:sensor_mate/app/data/local/my_shared_pref.dart';
import 'package:sensor_mate/app/routes/app_pages.dart';
import 'package:sensor_mate/app/utility/Utility.dart';

import '../../../data/models/Hub.dart';
import '../controllers/devices_details_list_controller.dart';

class DevicesDetailsListView extends StatelessWidget {
  final DevicesDetailsListController controller = Get.put(DevicesDetailsListController());
  DevicesDetailsListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title:  Text('My Devices ${controller.deviceType.value}', style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        )),
        actions: [
          IconButton(
            icon: const Icon(Icons.home_outlined,color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.filter_alt_sharp,color: Colors.white),
            onPressed: () {},
          ),
        ],
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
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildFilterButton('All'),
                    // _buildFilterButton('Active'),
                    // _buildFilterButton('Inactive'),
                  ],
                ),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Devices List
                        Obx(() {
                          var filteredDevices = controller.deviceList.where((device) {
                            if (controller.selectedFilter.value == 'All') return true;
                            return device.status == controller.selectedFilter.value;
                          }).toList();

                          return ListView.builder(
                            shrinkWrap: true,   // ✅ Important
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: filteredDevices.length,
                            itemBuilder: (context, index) {
                              var device = filteredDevices[index];
                              return _buildHubCardPortalDevices(device);
                            },
                          );
                        }),

                        const SizedBox(height: 16),

                        // Hubs List (from DB)
                        Obx(() {
                          return ListView.builder(
                            shrinkWrap: true,   // ✅ Important
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: controller.hubList.length,
                            itemBuilder: (context, index) {
                              var hub = controller.hubList[index];
                              return _buildHubCard(hub);
                            },
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Add new device action
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }
  Widget _buildHubCard(Hub hub) {
    Device device = Device(hubId: hub.manNumber, hubTD: hub.manNumber, hubName: hub.hubName, hubType: hub.hubType);

    return Card(
      color: Colors.white.withOpacity(0.9),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(hub.hubName, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text("Type: ${hub.hubType}\nMAN: ${hub.manNumber}"),
                ],
              ),
            ),
            editPgnsHub(hub),
            const SizedBox(width: 8),
            Visibility(visible:hub.hubType.contains('XSEN')?false:true,child: buildActiveInActiveStatusRx(device, controller.eldSerialNumber)),
          ],
        ),
      ),

    );
  }
  Widget editPgnsHub(Hub hub) {
    String text = hub.hubType.contains('XSEN')?'Configure':'Edit PGNs';
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(0, 0), // remove default min size
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0), // adjust padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // round corners
        ),
      ),
      onPressed: () {
        Device device = Device(hubId: hub.manNumber, hubTD: hub.manNumber, hubName: hub.hubName, hubType: hub.hubType);
        if(text.contains('Edit')) {
          Get.toNamed(AppPages.EDIT_PGN, arguments: device);
        }
        else{
          Get.toNamed(AppPages.SENSOR_SETTINGS, arguments: device);
        }
      },
      child:  Text(
        text,
        style: TextStyle(fontSize: 12), // smaller text
      ),
    );
  }
  Widget _buildHubCardPortalDevices(Device hub) {
    return Card(
      color: Colors.white.withOpacity(0.9),
      margin: const EdgeInsets.only(left: 12, top: 6, right: 0, bottom: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(hub.hubName, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text("Type: ${hub.hubType}\nMAN: ${hub.hubTD}"),
                ],
              ),
            ),
            editPgns(hub),
            const SizedBox(width: 8),
            Visibility(visible:hub.hubType.contains('XSEN')?false:true,child: buildActiveInActiveStatusRx(hub, controller.eldSerialNumber)),
          ],
        ),
      ),
    );
  }


  Widget buildActiveInActiveStatusRx(Device device, RxString eldSerialNumber) {
    return Obx(() {
      bool isChecked = eldSerialNumber.value == device.hubTD;
      return Row(
        children: [
          Checkbox(
            value: isChecked,
            onChanged: (val) async {
              if (val != null && val) {
                await MySharedPref.setEldSerialNumber(device.hubTD);
                eldSerialNumber.value = device.hubTD;
                showAlertNow(device, true);
              } else {
                await MySharedPref.setEldSerialNumber('');
                eldSerialNumber.value = "";
                showAlertNow(device, false);
              }
            },
          ),
          Text(
            isChecked ? "Active" : "Inactive",
            style: TextStyle(
              color: isChecked ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 12
            ),
          ),
        ],
      );
    });
  }


  // Device card builder

  // Filter button builder
  Widget _buildFilterButton(String filter) {
    return Obx(() {
      return GestureDetector(
        onTap: () => controller.filterDevices(filter),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
          decoration: BoxDecoration(
            color: controller.selectedFilter.value == filter ? LightThemeColors.activeColor : LightThemeColors.inactiveColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Visibility(visible:filter == 'All'?false:true,
                  child: Icon(filter == 'Active' ? Icons.circle : Icons.circle, color: filter == 'Active' ? Colors.green : filter == 'Inactive' ? LightThemeColors.redButtonBackgroundColor : Colors.grey, size: 15)),
              const SizedBox(width: 4),
              Text(filter,textAlign: TextAlign.center,style: const TextStyle(color: Colors.white)),
            ],
          ),
        ),
      );
    });
  }
  Widget buildEditText() {
   return SizedBox(
     height: 40,
     child: ElevatedButton.icon(
       onPressed: () {
         // Define what happens when the button is pressed
       },
       icon: const Icon(
         Icons.edit, // Use the edit icon similar to the image
         size: 20.0, // Adjust the icon size if necessary
         color: Colors.white, // Icon color
       ),
       label: const Text(
         'Edit',
         style: TextStyle(
           color: Colors.white, // Text color
           fontSize: 16.0, // Adjust the text size
         ),
       ),
       style: ElevatedButton.styleFrom(
         backgroundColor: LightThemeColors.loginBtnColor, // Button background color (match the color from the image)
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(30.0), // Rounded corners
         ),
         padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0), // Button padding
       ),
     ),
   );
  }
  Widget buildText(String label, String iconName) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Row(
        children: [
          Image.asset(
            'assets/images/$iconName.png',
            width: 15,
            height: 15,
            color: LightThemeColors.prefixIconColor, // Optional: To apply a tint
          ),
          const SizedBox(width: 10),
          Text(label,style: const TextStyle(color: Colors.white)),
        ],
      )
    );
  }
  void showAlert(String s) {
    Get.dialog(
      Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.do_not_disturb_alt,
                  color: Colors.white,
                  size: 40,
                ),
                SizedBox(width: 16),
                Text(
                  'Deactivate Device',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text('Data from this device will no longer be sent to your mobile app or portal. You can still view historical data.',
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Cancel button
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back(); // Close the alert
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4E515B), // Grey color for Cancel
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // OK button
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle OK action
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF52A2C5), // Blue color for OK
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        'OK',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      barrierDismissible: false, // Makes the dialog modal
    );

  }

  Future<void> showAlertNow(Device device, bool value) async {
    String text = value?'activated':'deactivated';
    Utility.showDialogAlert(Get.context as BuildContext,'Success!','You have successfully '+ text+ ' this device '+device.hubName);
  }

  Widget editPgns(Device device) {
    String text = device.hubType.contains('XSEN')?'Configure':'Edit PGNs';
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(0, 0), // remove default min size
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0), // adjust padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // round corners
        ),
      ),
      onPressed: () {
        if(text.contains('Edit')) {
          Get.toNamed(AppPages.EDIT_PGN, arguments: device);
        }
        else{
          Get.toNamed(AppPages.SENSOR_SETTINGS, arguments: device);
        }
      },
      child:  Text(
        text,
        style: TextStyle(fontSize: 12), // smaller text
      ),
    );
  }

}



