import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/components/background_service.dart';
import 'app/modules/edit_pgn/controllers/edit_pgn_controller.dart';
import 'app/routes/app_pages.dart';
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();




void main() async {
  // ✅ Ensure Flutter engine is ready
  WidgetsFlutterBinding.ensureInitialized();
  // ✅ Configure background service or notifications AFTER initialization
  await initializeNotifications();
  //await initializeBackgroundService();
  await GetStorage.init();

  await BackgroundService.initializeService();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  await service.configure(
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
    androidConfiguration: AndroidConfiguration(
      autoStart: true,
      onStart: onStart,
      isForegroundMode: false,
      autoStartOnBoot: true,
    ),
  );
}


Future<void> initializeNotifications() async {
  // Android settings
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher'); // your app icon

  // iOS settings (optional)
  final DarwinInitializationSettings initializationSettingsDarwin =
  DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        // handle iOS notification tapped in foreground
      });

  // Combine settings
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
  );

  // Initialize
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // handle notification tapped
      });
}

/// ----------------------
/// TOP-LEVEL FUNCTION
/// ----------------------
@pragma('vm:entry-point') // 👈 required so the callback survives tree-shaking
void onStart(ServiceInstance service) {
  // Needed so plugins are registered in background isolate
  DartPluginRegistrant.ensureInitialized();

  // Example: keep updating notification
  Timer.periodic(const Duration(seconds: 5), (timer) async {
    if (service is AndroidServiceInstance) {
      service.setForegroundNotificationInfo(
        title: "My Service",
        content: "Updated at ${DateTime.now()}",
      );
    }

    print("Background service running at ${DateTime.now()}");
  });
}

/// iOS background handler (also top-level)
@pragma('vm:entry-point')
bool onIosBackground(ServiceInstance service) {
  WidgetsFlutterBinding.ensureInitialized();
  return true;
}


Future<void> initializeBackgroundService() async {
  final service = FlutterBackgroundService();

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      // This callback will be executed when app starts in foreground or background
      onStart: onStart,
      isForegroundMode: true,
      autoStart: true,
      notificationChannelId: 'my_foreground', // must match with AndroidManifest.xml
      initialNotificationTitle: 'Background Service',
      initialNotificationContent: 'Running...',
      foregroundServiceNotificationId: 888,
    ),
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
  );

  // Optional: Start the service right away
 // service.startService();
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(child: Text('Hello Flutter')),
      ),
    );
  }
}

// Future<void> main() async {
//   BackgroundService.initializeService();
//   const AndroidInitializationSettings initializationSettingsAndroid =
//   AndroidInitializationSettings('@mipmap/ic_launcher'); // Add your app icon here
//
//   final DarwinInitializationSettings initializationSettingsDarwin =
//   DarwinInitializationSettings();
//
//   final InitializationSettings initializationSettings = InitializationSettings(
//     android: initializationSettingsAndroid,
//     iOS: initializationSettingsDarwin,
//   );
//
//   await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//
//
//  
// }
