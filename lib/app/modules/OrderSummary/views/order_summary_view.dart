import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/order_summary_controller.dart';

class OrderSummaryView extends StatelessWidget {
  const OrderSummaryView({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderSummaryController controller = Get.put(OrderSummaryController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Order Summary', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            // Handle back button
            Get.back();
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
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.orderItems.length,
                  itemBuilder: (context, index) {
                    var item = controller.orderItems[index];
                    return ListTile(
                      leading: Image.asset(
                        'assets/images/device_icon.png', // Replace with actual image asset
                        width: 50,
                        height: 50,
                      ),//Icon(item['image'] as IconData, color: Colors.white, size: 40),
                      title: Text(item['name'].toString(), style: const TextStyle(color: Colors.white)),
                      subtitle: Row(
                        children: [
                        ],
                      ),
                      trailing: Column(
                        children: [
                          Text("\$${item['price']}",
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          Text("\$${item['originalPrice']}",
                              style: const TextStyle(
                                fontSize: 14,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough)),
                      Text(item['discount'].toString(), style: const TextStyle(color: Colors.tealAccent)),


                        ],
                      ),
                    );
                  },
                ),
              ),
              Divider(color: Colors.grey[700], thickness: 1),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.name,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.grey, size: 14),
                        const SizedBox(width: 5),
                        Text(controller.address, style: TextStyle(color: Colors.grey[500])),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(Icons.phone, color: Colors.grey, size: 14),
                        const SizedBox(width: 5),
                        Text(controller.phone, style: TextStyle(color: Colors.grey[500])),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(Icons.email, color: Colors.grey, size: 14),
                        const SizedBox(width: 5),
                        Text(controller.email, style: TextStyle(color: Colors.grey[500])),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildPriceRow('Price (2 items)', '\$${controller.totalPrice.value}', Colors.white),
                      _buildPriceRow('Discount', '\$${controller.discount.value}', Colors.tealAccent),
                      _buildPriceRow('Delivery Charges', '\$${controller.deliveryCharges.value}', Colors.white),
                      const Divider(color: Colors.grey),
                      _buildPriceRow('Total Amount', '\$${controller.totalAmount.value}', Colors.white, isBold: true),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Handle payment action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(20, 117, 132, 1.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    width: double.infinity,
                    child: const Text(
                      'Make Payment',
                      style: TextStyle(fontSize: 20,color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, Color valueColor, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white)),
          Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
