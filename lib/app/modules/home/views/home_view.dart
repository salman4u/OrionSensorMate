import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sensor_mate/app/routes/app_pages.dart';

import '../../../components/background_service.dart';
import '../../../components/light_theme_colors.dart';
import '../../../data/database/HubDatabase.dart';
import '../../../data/models/Hub.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final HomeController controller = Get.put(HomeController());

  HomeView({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,  // Assign the GlobalKey to the Scaffold
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const AppBarTitle(),
        leading: IconButton(
          icon: Image.asset(
            'assets/images/menu.png',  // Replace with your image path
            width: 30,
            height: 30,
          ),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();  // Open the drawer using GlobalKey
          },
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: _buildDrawer(context),  // Drawer implementation
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: [
                      _buildGridItem(1, 'Sensors', () {
                        // Add navigation or action
                      }),
                      _buildGridItem(2, 'Register', () {
                        // Add navigation or action
                      }),
                      _buildGridItem(3, 'About', () {
                        // Add navigation or action
                      }),
                      _buildGridItem(4, 'Profile', () {
                        // Add navigation or action
                      }),
                      _buildGridItem(5, 'Portal Login', () {

                        // Add navigation or action
                      }),
                      _buildGridItem(6, 'Store', () {
                        // Add navigation or action
                      }),
                    ],
                  ),
                ),
                const SizedBox(height: 0),
                Obx(() => Center(
                  child: Text(
                    "BLE Status: ${controller.connectionStatus}",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white, // 👈 white text
                    ),
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Drawer implementation
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black,  // Dark background to match the screenshot
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.black),
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    const SizedBox(width:200),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white, size: 40),  // Close icon
                      onPressed: () {
                        Navigator.pop(context);  // Close the drawer
                      },
                    ),
                  ],
                ),
              ),
            ),
            _buildDrawerItem(Icons.home, 'Home', () {
              Navigator.pop(context);
              Get.toNamed(AppPages.HOME);  // Navigate to home
            }),
            _buildDrawerItem(Icons.sensors, 'Sensors', () {
              Navigator.pop(context);
              Get.toNamed(AppPages.DEVICES_DETAILS_LIST);  // Navigate to sensors
             // Get.toNamed(AppPages.SENSOR_LIST);  // Navigate to sensors
            }),
            _buildDrawerItem(Icons.device_hub, 'Register', () {
              Navigator.pop(context);
              Get.toNamed(AppPages.REGISTER_DEVICE);  // Navigate to register

            //  addRandomData();

            }),
            _buildDrawerItem(Icons.store, 'Shop', () {
              Navigator.pop(context);
              Get.toNamed(AppPages.STORE);  // Navigate to shop
            }),
            _buildDrawerItem(Icons.info, 'About', () {
              Navigator.pop(context);
              Get.toNamed(AppPages.ABOUT);  // Navigate to about
            }),
            _buildDrawerItem(Icons.login, 'Portal Login', () {

              Navigator.pop(context);
              Get.toNamed(
                AppPages.WEBVIEW,
                arguments: "https://mvcportal.shipeliteexpress.com/HubManagement/index#collapsefour",
              );
            }),
            _buildDrawerItem(Icons.person, 'Profile', () {
              Navigator.pop(context);
              Get.toNamed(AppPages.PROFILE);  // Navigate to profile
            }),
            _buildDrawerItem(Icons.logout, 'Logout', () {
              Navigator.pop(context);
              Get.toNamed(AppPages.LOGIN);
              // Implement logout action
            }, isLogout: true),
          ],
        ),
      ),
    );
  }

  // Drawer item builder with optional logout styling
  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap, {bool isLogout = false}) {
    return ListTile(
      leading: Icon(icon, color: isLogout ? Colors.red : Colors.white),
      title: Text(
        title,
        style: TextStyle(
          color: isLogout ? Colors.red : Colors.white,
          fontSize: 18,
        ),
      ),
      onTap: onTap,
    );
  }

  Widget _buildGridItem(int index, String title, VoidCallback onTap) {
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
              icon: Image.asset(
                getImageName(index),
                width: 65,
                height: 65,
              ),
              onPressed: () {
                navigate(index);
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

  String getImageName(int index) {
    switch (index) {
      case 1:
        return 'assets/images/sensors.png';
      case 2:
        return 'assets/images/register_devices.png';
      case 3:
        return 'assets/images/about.png';
      case 4:
        return 'assets/images/profile.png';
      case 5:
        return 'assets/images/portal_login.png';
      case 6:
        return 'assets/images/store.png';
      default:
        return 'assets/images/store.png';
    }
  }

  void navigate(int index) {
    switch (index) {
      case 1:
       // Get.toNamed(AppPages.SENSOR_LIST);
        Get.toNamed(AppPages.DEVICES_DETAILS_LIST);  // Navigate to sensors

        break;
      case 2:
        Get.toNamed(AppPages.REGISTER_DEVICE);
        break;
      case 3:
        Get.toNamed(AppPages.ABOUT);
        break;
      case 4:
        Get.toNamed(AppPages.PROFILE);
        break;
      case 5:
        Get.toNamed(
          AppPages.WEBVIEW,
          arguments: "https://mvcportal.shipeliteexpress.com/HubManagement/index#collapsefour",
        );
        break;
      case 6:

        Get.toNamed(AppPages.STORE);
        break;
    }
  }

  Future<void> addRandomData() async {
    final db = HubDatabase.instance;
    List<Hub> hubs = await db.getHubs();

// Insert
    await db.insertHub(Hub(
      manNumber: "t465b85eab8e",
      hubName: "XCOM5G-0039",
      description: "fw v11, nobat",
      did: "t465b85eab4e",
      hubType: "XSEN",   // 👈 new field
    ));

// Fetch
     hubs = await db.getHubs();

// Update
//     await db.updateHub(Hub(
//       id: hubs.first.id,
//       manNumber: "e465b85eab47e",
//       hubName: "XCOM5G-0030",
//       description: "fw v12, updated",
//       did: "e465b85eab4e",
//       hubType: "5G-Pro",   // 👈 updated hubType
//     ));

// Delete
  //  await db.deleteHub(hubs.first.id!);

  }
}

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      // Center Row contents horizontally
      children: [
        Image.asset(
          'assets/images/Logo.png', // Replace with your logo path
          height: 46.53,
        ),
        const Column(
          children: [
            Text(
              'Orion                    ',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 18,
                color: LightThemeColors.lightTextColor,
                // Replace with your theme colors
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '  Sensormate',
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

