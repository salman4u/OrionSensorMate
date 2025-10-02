import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/add_address_controller.dart';

class AddAddressView extends StatelessWidget {
  final AddAddressController controller = Get.put(AddAddressController());

   AddAddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0D24), // dark background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Add new Address',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
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
              _buildTextField(
                label: 'Full Name',
                icon: Icons.person_outline,
                onChanged: (value) => controller.fullName.value = value,
              ),
              const SizedBox(height: 10),
              _buildTextField(
                label: 'Email',
                icon: Icons.email_outlined,
                onChanged: (value) => controller.email.value = value,
              ),
              const SizedBox(height: 10),
              _buildTextField(
                label: 'Phone',
                icon: Icons.phone_outlined,
                onChanged: (value) => controller.phone.value = value,
              ),
              const SizedBox(height: 10),
              _buildTextField(
                label: 'Address-1',
                icon: Icons.location_on_outlined,
                onChanged: (value) => controller.address1.value = value,
              ),
              const SizedBox(height: 10),
              _buildTextField(
                label: 'Address-2',
                icon: Icons.location_on_outlined,
                onChanged: (value) => controller.address2.value = value,
              ),
              const SizedBox(height: 10),
              _buildTextField(
                label: 'City',
                icon: Icons.location_city_outlined,
                onChanged: (value) => controller.city.value = value,
              ),
              const SizedBox(height: 10),
              _buildTextField(
                label: 'Zip Code',
                icon: Icons.markunread_mailbox_outlined,
                onChanged: (value) => controller.zipCode.value = value,
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () => Get.back(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4B4B4B),
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: controller.onAddPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00B8D4), // Teal-ish Add button color
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Add',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }

  Widget _buildTextField({required String label, required IconData icon, required Function(String) onChanged}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), // Adjust to your needs
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF4E4E63), // Start color
            Color(0xFF2F2F3D), // End color
          ],
        ),
      ),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: const Color(0xFFB0B0B0)), // Icon color
          labelText: label,
          labelStyle: const TextStyle(color: Color(0xFFB0B0B0)),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF4B4B4B)),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF00B8D4)),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
