import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sensor_mate/app/components/light_theme_colors.dart';
import 'package:sensor_mate/app/routes/app_pages.dart';

import '../controllers/delivery_address_controller.dart';

class DeliveryAddressView extends StatelessWidget {
  const DeliveryAddressView({super.key});

  @override
  Widget build(BuildContext context) {
    final DeliveryAddressController controller = Get.put(DeliveryAddressController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Delivery Address', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.back();
            // Go back
          },
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.home_outlined, color: Colors.white),
          ),
        ],
      ),
      body:  Container(
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
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.addresses.length,
                    itemBuilder: (context, index) {
                      return Obx(() => AddressTile(
                        name: controller.addresses[index]['name']!,
                        address: controller.addresses[index]['address']!,
                        phone: controller.addresses[index]['phone']!,
                        email: controller.addresses[index]['email']!,
                        isSelected: controller.selectedAddress.value == index,
                        onTap: () => controller.selectAddress(index),
                      ));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed(AppPages.ADD_ADDRESS);
                      // Handle add new address
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: const Text(
                        'Add New Address',
                        style: TextStyle(fontSize: 24,color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed(AppPages.ORDER_SUMMARY);
                      // Handle continue action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: LightThemeColors.buttonColorsDark,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: const Text(
                        'Continue',
                        style: TextStyle(fontSize: 21,color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AddressTile extends StatelessWidget {
  final String name;
  final String address;
  final String phone;
  final String email;
  final bool isSelected;
  final VoidCallback onTap;

  const AddressTile({super.key,
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey[800] : Colors.transparent,
          border: Border(
            bottom: BorderSide(color: Colors.grey[700]!),
          ),
        ),
        child: Row(
          children: [
            isSelected
                ? Image.asset(
              'assets/images/check_mark_checked.png', // Path to your selected asset image
              width: 25,
              height: 25,
            )
                : const Icon(
              Icons.check_box_outline_blank, // Default icon when not selected
              color: Colors.white,
              size: 25,
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.grey, size: 14),
                    const SizedBox(width: 5),
                    Text(
                      address,
                      style: TextStyle(color: Colors.grey[500], fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(Icons.phone, color: Colors.grey, size: 14),
                    const SizedBox(width: 5),
                    Text(
                      phone,
                      style: TextStyle(color: Colors.grey[500], fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(Icons.email, color: Colors.grey, size: 14),
                    const SizedBox(width: 5),
                    Text(
                      email,
                      style: TextStyle(color: Colors.grey[500], fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),

          ],
        ),
      ),
    );
  }
}
