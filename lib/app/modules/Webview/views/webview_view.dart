import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/webview_controller.dart';

import 'package:webview_flutter/webview_flutter.dart';


class WebviewView extends GetView<WebviewController> {
  const WebviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Portal Login"),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: controller.webViewController),
          Obx(() => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : const SizedBox.shrink()),
        ],
      ),
    );
  }
}

