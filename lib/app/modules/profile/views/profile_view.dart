import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sensor_mate/app/components/light_theme_colors.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());
   ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
            color: Colors.white
        ),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.back();
          },

        ),
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // First Name Field
              _buildTextField(
                controller: controller,
                hintText: 'First Name',
                icon: Icons.person_outline,
                onChanged: (value) => controller.firstName.value = value,
              ),
              const SizedBox(height: 16),
              // Last Name Field
              _buildTextField(
                controller: controller,
                hintText: 'Last Name',
                icon: Icons.person_outline,
                onChanged: (value) => controller.lastName.value = value,
              ),
              const SizedBox(height: 16),
              // Email Field
              _buildTextField(
                controller: controller,
                hintText: 'Email',
                icon: Icons.email_outlined,
                onChanged: (value) => controller.email.value = value,
              ),
              const SizedBox(height: 16),
              // Password Field
              _buildTextField(
                controller: controller,
                hintText: 'Update Password',
                icon: Icons.lock_outline,
                isPassword: true,
                onChanged: (value) => controller.password.value = value,
              ),
              const SizedBox(height: 16),
              // Re-enter Password Field
              _buildTextField(
                controller: controller,
                hintText: 'Re-enter Update Password',
                icon: Icons.lock_outline,
                isPassword: true,
                onChanged: (value) => controller.reEnterPassword.value = value,
              ),
              const SizedBox(height: 32),
              // Update Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: LightThemeColors.loginBtnColor, // Light teal color
                  padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  controller.updateProfile();
                },
                child: const Text(
                  'Update',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  // Helper method to build the input fields
  Widget _buildTextField({
    required ProfileController controller,
    required String hintText,
    required IconData icon,
    required ValueChanged<String> onChanged,
    bool isPassword = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF3A3F45), // Darker gray for text fields
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        onChanged: onChanged,
        obscureText: isPassword,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
          prefixIcon: Icon(
            icon,
            color: Colors.white.withOpacity(0.7),
          ),
        ),
      ),
    );
  }
}
