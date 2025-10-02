import 'package:get/get.dart';

class StoreController extends GetxController {
  var items = [
    {
      'name': 'XCOM5G',
      'description': 'Lorem ipsum dummy text details Lorem ipsum dummy',
      'price': 100.00,
      'oldPrice': 150.00,
      'discount': 33
    },
    {
      'name': 'XCOM5GC',
      'description': 'Lorem ipsum dummy text details Lorem ipsum dummy',
      'price': 90.00,
      'oldPrice': 100.00,
      'discount': 10
    },
    {
      'name': 'XSEN5G',
      'description': 'Lorem ipsum dummy text details Lorem ipsum dummy',
      'price': 100.00,
      'oldPrice': 200.00,
      'discount': 50
    },
  ].obs;
}
