import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sensor_mate/app/components/light_theme_colors.dart';
import 'package:sensor_mate/app/routes/app_pages.dart';

import '../../../components/MqttController.dart';
import '../controllers/login_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  final LoginController loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('assets/images/desk_bg_img.png'),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildTextField(
                        controller: controller,
                        hintText: 'Email',
                        icon: Icons.email,
                        onChanged: (value) => controller.email.value = value,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: controller,
                        hintText: 'Password',
                        icon: Icons.lock,
                        isPassword: true,
                        onChanged: (value) => controller.password.value = value,
                      ),
                      const SizedBox(height: 32),
                      Obx(() {
                        return controller.isLoading.value
                            ? const CircularProgressIndicator()
                            : ElevatedButton(
                          onPressed: () => controller.login(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: LightThemeColors.loginBtnColor,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 100, vertical: 15),
                            textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          child: const Text('Login',
                              style: TextStyle(color: Colors.white)),
                        );
                      }),
                      TextButton(
                        onPressed: () {
                          showForgotPasswordDialog();
                        },
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width / 2 - 24,
                          child: const Divider(color: Colors.white)),
                      const Text('or', style: TextStyle(color: Colors.white)),
                      SizedBox(
                          width: MediaQuery.of(context).size.width / 2 - 24,
                          child: const Divider(color: Colors.white)),
                    ],
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      Get.toNamed(AppPages.REGISTER);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 100, vertical: 15),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text('Register',
                        style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(height: 30),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      '©2024 LogistiWerx, Inc.',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
Widget _buildTextField({
  required LoginController controller,
  required String hintText,
  required IconData icon,
  bool isPassword = false,
  required Function(String) onChanged,
}) {
  return TextField(
    onChanged: onChanged,
    obscureText: isPassword,
    style: const TextStyle(color: Colors.white),
    decoration: InputDecoration(
      filled: true,
      fillColor: const Color(0xFF3A3A3A), // Dark grey background color
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.white54),
      prefixIcon: Icon(icon, color: Colors.white54),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
    ),
  );
}

void showForgotPasswordDialog() {
  Get.defaultDialog(
    barrierDismissible: false, // Prevent dismissing by tapping outside
    backgroundColor: Colors.transparent,
    title: '',
    content: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        padding: const EdgeInsets.all(16.0),

        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('assets/images/bg_sensor_list_item.png'), // Add your image path
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(20), // Optional: Add corner radius
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title Section
            const Row(
              children: [
                Icon(Icons.lock, color: Colors.white),
                SizedBox(width: 10),
                Text(
                  'Forgot Password',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "You are about to reset your password. Please enter your username and the cell phone used when your app was registered. "
                  "If your input matches our records, "
                  "you will receive a text message with your"
                  " temporary password.\nDo you want to continue?",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 20),
            // Username Field
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person, color: Colors.white),
                hintText: 'Username',
                hintStyle: const TextStyle(color: Colors.white),
                filled: true,
                fillColor: LightThemeColors.textFieldBgColor2,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.white30,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(
                    color: Colors.white60,
                  ),
                ),


              ),
              style: const TextStyle(color: Colors.white),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a username';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            // Phone Number Field with Country Picker
            TextFormField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.phone, color: Colors.white),
                hintText: '+1 | Phone Number',
                hintStyle: const TextStyle(color: Colors.white),
                filled: true,
                fillColor: LightThemeColors.textFieldBgColor2,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.white30,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(
                    color: Colors.white60,
                  ),
                ),


              ),
              style: const TextStyle(color: Colors.white),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a phone number';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.back(); // Close dialog
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: LightThemeColors.cancelBtnColor, // OK button color
                  ),
                  child: const Text("      Cancel      ",style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    showOtpDialog();
                    // Handle form submission and verification
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: LightThemeColors.loginBtnColor, // OK button color
                  ),
                  child: const Text("         OK         ",style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
void showOtpDialog() {
  Get.dialog(
    BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      child: Dialog(
        backgroundColor: Colors.transparent, // Transparent to preserve blur effect
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/images/bg_sensor_list_item.png'), // Add your image path
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(20), // Optional: Add corner radius
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Row(
                  children: [
                    Icon(Icons.lock_outline, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      "Enter PIN",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  "Enter 4 digit PIN sent on your registered mobile number.",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 20),
                // OTP TextField or PinCodeFields
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    4, // Assuming 4 digits
                        (index) => Container(
                      width: 50,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const TextField(
                        style: TextStyle(
                          color: Colors.white, // Set the font color to white
                          fontSize: 24,
                        ),
                        textAlign: TextAlign.center, // Center the text within the TextField
                        decoration: InputDecoration(
                          border: InputBorder.none, // Remove the default underline border
                          isCollapsed: true, // Ensure no extra padding is added
                        ),
                        keyboardType: TextInputType.number, // Make sure it's suitable for PIN entry
                        maxLength: 1, // Limit each field to one digit
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Get.back(); // Close dialog
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: LightThemeColors.cancelBtnColor, // OK button color
                      ),
                      child: const Text("      Cancel      ",style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        Get.back(); // Close dialog// Handle form submission and verification
                        showPasswordChangeDialog();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: LightThemeColors.loginBtnColor, // OK button color
                      ),
                      child: const Text("         OK         ",style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    ),
    barrierColor: Colors.black.withOpacity(0.5), // Semi-transparent background
  );
}
void showPasswordChangeDialog() {
  Get.defaultDialog(
    barrierDismissible: false, // Prevent dismissing by tapping outside
    backgroundColor: Colors.transparent,
    title: '',
    content: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('assets/images/bg_sensor_list_item.png'), // Add your image path
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(20), // Optional: Add corner radius
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.lock,
                  color: Colors.white, // Icon color
                ),
                SizedBox(width: 10),
                Text(
                  'Please Set New Password',
                  style: TextStyle(
                    color: Colors.white, // Text color
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              obscureText: false,
              style: const TextStyle(color: Colors.white), // Input text color
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: const TextStyle(color: Colors.white70), // Label color
                filled: true,
                fillColor: Colors.grey.withOpacity(0.2),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(
                    'assets/images/password_icon.png', // Add your icon image path
                    width: 20,
                    height: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              obscureText: false,
              style: const TextStyle(color: Colors.white), // Input text color
              decoration: InputDecoration(
                labelText: 'Re-enter Password',
                labelStyle: const TextStyle(color: Colors.white70), // Label color
                filled: true,
                fillColor: Colors.grey.withOpacity(0.2),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(
                    'assets/images/password_icon.png', // Add your icon image path
                    width: 20,
                    height: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.back(); // Close dialog
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: LightThemeColors.cancelBtnColor, // OK button color
                  ),
                  child: const Text(
                    "      Cancel      ",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    showOtpDialog();
                    // Handle form submission and verification
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: LightThemeColors.loginBtnColor, // OK button color
                  ),
                  child: const Text(
                    "         OK         ",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}



