import 'package:get/get.dart';

class CartDetailsController extends GetxController {
  var cartItems = [
    {'name': 'XCOM5G', 'price': 200.0, 'originalPrice': 300.0, 'discount': '33%', 'quantity': 2},
    {'name': 'XCOM5GC', 'price': 90.0, 'originalPrice': 100.0, 'discount': '10%', 'quantity': 1},
  ].obs;

  // Calculate total values
  int get totalItems => cartItems.length;

  // Cast the values to the correct types
  double get totalPrice => cartItems.fold(0.0, (sum, item) {
    return sum + ((item['price'] as double) * (item['quantity'] as int));
  });

  double get totalDiscount => cartItems.fold(0.0, (sum, item) {
    double originalPrice = item['originalPrice'] as double;
    double price = item['price'] as double;
    int quantity = item['quantity'] as int;
    return sum + ((originalPrice - price) * quantity);
  });

  void increaseQuantity(int index) {
    cartItems[index]['quantity'] = (cartItems[index]['quantity'] as int) + 1;
    cartItems.refresh();
  }

  void decreaseQuantity(int index) {
    if ((cartItems[index]['quantity'] as int) > 1) {
      cartItems[index]['quantity'] = (cartItems[index]['quantity'] as int) - 1;
      cartItems.refresh();
    }
  }

  void removeItem(int index) {
    cartItems.removeAt(index);
  }
}
