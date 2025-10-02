import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewController extends GetxController {
  late final WebViewController webViewController;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();

    final String url = Get.arguments ?? "";

    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) => isLoading.value = true,
          onPageFinished: (url) => isLoading.value = false,
        ),
      )
      ..loadRequest(Uri.parse(url));
  }
}

