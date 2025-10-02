import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sensor_mate/app/components/light_theme_colors.dart';
import 'package:sensor_mate/app/routes/app_pages.dart';
import '../controllers/cart_details_controller.dart';
class CartDetailsView extends GetView<CartDetailsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Cart Details',style: TextStyle(
          color: Colors.white,)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.back();
            // Go back
          },
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
              Expanded(
                child: Obx(() => ListView.builder(
                  itemCount: controller.cartItems.length,
                  itemBuilder: (context, index) {
                    final item = controller.cartItems[index];
                    return Column(
                      children: [
                        ListTile(
                          leading: Image.asset(
                            'assets/images/device_icon.png', // Replace with actual image asset
                            width: 50,
                            height: 50,
                          ),
                          title: Text(
                            item['name'] as String,
                            style: const TextStyle(fontSize: 16, color: Colors.white),
                          ),

                          trailing: Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '\$${item['price']}',
                                    style: const TextStyle(fontSize: 16, color: Colors.white),
                                  ),
                                  Text(
                                    '\$${item['originalPrice']} (${item['discount']} off)',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.white70,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: SizedBox(
                                height:30,
                                child: ElevatedButton.icon(
                                  onPressed: () => controller.removeItem(index),
                                  icon: const Icon(Icons.delete_outline_rounded, color: Colors.white),
                                  label: const Text('Remove', style: const TextStyle(fontSize: 16, color: Colors.white)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: LightThemeColors.redButtonBackgroundColor,
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () => controller.decreaseQuantity(index),
                                  icon: const Icon(Icons.remove_circle_outline, color: Colors.white),
                                ),
                                Container(
                                  color:Color.fromRGBO(34, 34, 43, 1),
                                  child: Text(
                                    '${item['quantity']}',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => controller.increaseQuantity(index),
                                  icon: const Icon(Icons.add_circle_outline, color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Divider(color: Colors.white),
                      ],
                    );
                  },
                )),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade800,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Obx(() {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Price (${controller.totalItems} items)',
                              style: const TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            Text(
                              '\$${controller.totalPrice}',
                              style: const TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Discount',
                              style: TextStyle(color: Colors.cyan, fontSize: 16),
                            ),
                            Text(
                              '\$${controller.totalDiscount}',
                              style: const TextStyle(color: Colors.cyan, fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Delivery Charges',
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            Text(
                              '\$0',
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Divider(color: Colors.white),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total Amount',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Text(
                              '\$${controller.totalPrice - controller.totalDiscount}',
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: LightThemeColors.buttonColorsDark,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    onPressed: () {
                      Get.toNamed(AppPages.DELIVERY_ADDRESS);
                      // Handle continue action
                    },
                    child: const Text(
                      'Continue',
                      style: TextStyle(fontSize: 18,color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
