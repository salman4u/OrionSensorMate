import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../components/light_theme_colors.dart';
import '../controllers/welcome_controller.dart';

class WelcomeView extends GetView<WelcomeController> {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
             Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                  children: [
                    Image.asset(
                      'assets/images/Logo.png', // Replace with your logo path
                      height: 76.53,
                    ),
                    const Column(
                      children: [
                        Text(
                          '  Orion             ',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 28,
                            color: LightThemeColors.lightTextColor,
                            fontWeight: FontWeight.bold,
                          ),),
                        Text(
                          '  Sensormate',
                          style: TextStyle(
                            fontSize: 28,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),)
                      ],
                    ),

                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Your World, Measured by Orion',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 410,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: AssetImage('assets/images/desk_bg_img.png',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            // Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: controller.onLoginPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1AACBE),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 18,color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: controller.onRegisterPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1D50A2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      'Register',
                      style: TextStyle(fontSize: 18,color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 0),
                  TextButton(
                    onPressed: controller.onForgotPasswordPressed,
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
            const Spacer(),
            // Footer
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
      ),
    );
  }
}

