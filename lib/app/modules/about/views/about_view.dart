import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../home/views/home_view.dart';
import '../controllers/about_controller.dart';

class AboutView extends GetView<AboutController> {
  const AboutView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const AppBarTitle(),
        leading: IconButton(
          icon: Image.asset(
            'assets/images/back_icon.png',  // Replace with your image path
            width: 30,  // Adjust the width
            height: 30,  // Adjust the height
          ),
          onPressed: () {
            Get.back();
          },
        ),
        iconTheme: const IconThemeData(
            color: Colors.white
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
            child: Text(
              'At Orion SensorMate, we specialize in intelligent long-range full-duplex wireless sensors designed for robust data acquisition, remote monitoring, and autonomous control. Whether on-grid or off-grid, our solutions deliver seamless, real-time connectivity for both stationary and mobile systems. With the tagline “Always There. Always Aware.™”, we strive to ensure that your systems remain reliably informed and responsive around the clock. Our wireless sensor platforms are engineered to not just collect data, but to interact — relaying insights and driving automated responses within electronic control architectures. Orion SensorMate is a division of Praxis Technologies, Inc. — combining innovation, security, and resilience to support a wide array of industrial, infrastructure, and machine-automation applications.',
              style: TextStyle(fontSize: 20,color: Colors.white),
            ),
          ),
            ),
      ));
  }
}
