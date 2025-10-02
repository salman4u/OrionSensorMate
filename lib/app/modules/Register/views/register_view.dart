import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sensor_mate/app/components/light_theme_colors.dart';
import 'package:sensor_mate/app/routes/app_pages.dart';
import '../controllers/register_controller.dart';

class RegisterView extends StatelessWidget {
  final RegisterController controller = Get.put(RegisterController());
   RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0D12), // Background color from the image (adjusted)
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0D12), // AppBar background color same as screen
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Register',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
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
          child: Column(
            children: [
              _buildTextField(
                controller: controller.firstName,
                labelText: 'First Name',
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                controller: controller.lastName,
                labelText: 'Last Name',
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                controller: controller.email,
                labelText: 'Email',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                controller: controller.password,
                labelText: 'Password',
                icon: Icons.lock_outline,
                obscureText: true,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                controller: controller.confirmPassword,
                labelText: 'Re-enter Password',
                icon: Icons.lock_outline,
                obscureText: true,
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: controller.registerUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A73E8), // Register button color (blue)
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 100),

                ),
                child: const Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Spacer(),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.grey[600],
                          thickness: 0.5,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'or',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.grey[600],
                          thickness: 0.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      Get.toNamed(AppPages.LOGIN);
                      // Login action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00ACC1), // Login button color (teal)
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 100),

                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '©2024 LogistiWerx, Inc.',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required RxString controller,
    required String labelText,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return  Padding(
      padding: const EdgeInsets.only(left: 20.0,right: 20.0),
      child: TextField(
          onChanged: (value) => controller(value),
          obscureText: obscureText,
          style: const TextStyle(color: Colors.white),
          keyboardType: keyboardType,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: const TextStyle(color: Colors.white70),
            filled: true,
            fillColor: LightThemeColors.textFieldBgColor3,
            prefixIcon: Icon(icon, color: Colors.white70),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: const BorderSide(
                color: Colors.white60,
              ),
            ),
          ),
      ),
    );

  }
}
