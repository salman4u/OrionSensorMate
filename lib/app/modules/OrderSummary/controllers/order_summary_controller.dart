import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderSummaryController extends GetxController {
  // Dummy Data for Order Items
  var orderItems = [
    {
      'name': 'XCOM5G *2 Nos.',
      'price': 200,
      'originalPrice': 300,
      'discount': '33 % off',
      'image': Icons.wifi, // Using an icon for simplicity
    },
    {
      'name': 'XCOM5GC',
      'price': 90,
      'originalPrice': 90,
      'discount': '10 % off',
      'image': Icons.wifi, // Using an icon for simplicity
    },
  ];

  // Address Information
  var name = 'Kaydon Stanzione';
  var address = '123 Main St, MyCity, ST, Zip';
  var phone = '1234567890';
  var email = 'hello@gmail.com';

  // Price Summary
  var totalPrice = 700.obs;
  var discount = 210.obs;
  var deliveryCharges = 0.obs;
  var totalAmount = 490.obs;
}
