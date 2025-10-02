import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sensor_mate/app/components/light_theme_colors.dart';
import 'package:sensor_mate/app/routes/app_pages.dart';
import '../controllers/sensor_details_controller.dart';

class SensorDetailsView extends GetView<SensorDetailsController> {
  const SensorDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Product Detail',style: TextStyle(
          color: Colors.white,)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.back();
            // Go back
          },
        ),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined, size: 35,color: Colors.white70),
                onPressed: () {
                  // Handle cart action
                },
              ),
              Visibility(
                visible: true,
                child: Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Colors.white),
                       borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    child: const Text(
                      '1', // Change this dynamically
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          )
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/images/sensor_details_bg.png'),
                    ),
                  ),
                  height: 200,
                  width: double.infinity,
                  child: Center(
                    child: Image.asset(
                      'assets/images/device_icon.png', // Replace with actual image asset
                      width: 150,
                      height: 150,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'XCOM5G',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                     const Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard ',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),
                    const Row(
                      children: [
                        Text(
                          '\$100.00',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          '\$150.00',
                          style: TextStyle(
                            fontSize: 16,
                            decoration: TextDecoration.lineThrough,
                            color: Colors.white70,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          '(33% off)',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.cyan,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Divider(color: Colors.white),
                    const SizedBox(height: 8),
                    const Text(
                      'Product Specifications',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Range: 100m',
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    const Text(
                      'Water Resistance: 300m',
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    TextButton(
                      onPressed: () {
                        // Handle view more
                      },
                      child: const Text(
                        'view more...',
                        style: TextStyle(color: Colors.cyan),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Warranty',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '1 year',
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    const Text(
                      'Lorem ipsum dummy text',
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Warranty',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '1 year',
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    const Text(
                      'Lorem ipsum dummy text',
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: LightThemeColors.buttonColorsDark,
                        ),
                        onPressed: () {
                          Get.toNamed(AppPages.CART_DETAILS);
                          // Handle add to cart
                        },
                        child: const Text(
                          'Add to Cart',
                          style: TextStyle(fontSize: 18,color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
