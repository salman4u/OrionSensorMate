import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/permission_controller.dart';

class PermissionView extends GetView<PermissionController> {
  const PermissionView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PermissionView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PermissionView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
