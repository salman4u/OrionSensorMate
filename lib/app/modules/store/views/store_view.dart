import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sensor_mate/app/components/light_theme_colors.dart';
import 'package:sensor_mate/app/routes/app_pages.dart';

import '../controllers/store_controller.dart';

class StoreView extends StatelessWidget {
  const StoreView({super.key});

  @override
  Widget build(BuildContext context) {
    final StoreController controller = Get.put(StoreController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.back();
            // Go back
          },
        ),
        title: const Text('Shop', style: TextStyle(color: Colors.white)),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
                onPressed: () {
                  // Handle cart click
                },
              ),
              const Positioned(
                right: 10,
                top: 10,
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 8,
                  child: Text('1', style: TextStyle(fontSize: 12, color: Colors.white)),
                ),
              ),
            ],
          )
        ],
      ),
      backgroundColor: Colors.black,
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
            child: Obx(() {
              return ListView.builder(
                itemCount: controller.items.length,
                itemBuilder: (context, index) {
                  final item = controller.items[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/bg_sensor_list_item.png'),
                      ),
                    ),
                    child: Row(
                      children: [
                         Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                               "XCOM5G",
                                style: TextStyle(fontSize: 21, color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                               "Lorem ipsum dummy text details Lorem ipsum dummy",
                                style: TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                              Image.asset('assets/images/device_icon.png', height: 60, width: 60), // Image as in your screenshot

                            ],
                          ),

                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '\$${item['price']}',
                              style: const TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '\$${item['oldPrice']}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            Text(
                              '(${item['discount']}% off)',
                              style: const TextStyle(fontSize: 12, color: Colors.blue),
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () {
                                Get.toNamed(AppPages.SENSOR_DETAILS);
                                // Add to cart logic
                              },
                              style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(46, 45, 56, 1)),
                              child: const Text('View Details',style: TextStyle(fontSize: 12, color: Colors.white)),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Add to cart logic
                              },
                              style: ElevatedButton.styleFrom(backgroundColor:  const Color.fromRGBO(20, 117, 132, 1)),
                              child: const Text('Add to Cart',style: TextStyle(fontSize: 12, color: Colors.white)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ),
      ),
    );
  }
}
