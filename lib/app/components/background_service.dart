import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:fbroadcast/fbroadcast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'dart:typed_data';

import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart' hide Response;
import '../components/custom_snackbar.dart';
import '../data/database/DatabaseHelper.dart';
import '../data/local/my_shared_pref.dart';
import '../modules/SensorSettings/controllers/sensor_settings_controller.dart';
import '../modules/edit_pgn/controllers/edit_pgn_controller.dart';
import '../utility/MySingleton.dart';
import '../utility/Utility.dart';
import 'package:flutter_fgbg/flutter_fgbg.dart';
import 'package:get_storage/get_storage.dart';

import 'api_service.dart';
@pragma('vm:entry-point')

class BackgroundService {
  static final String storageKey = 'saved_pgns';
  static RxString connectionState = "Disconnected".obs;

  static List<Map<String, dynamic>> initialList = [];
  void onPgnsUpdated(List<Map<String, dynamic>> latest) {
    // This gets called automatically whenever controller updates
    print("BackgroundService received update:");
    List<BluetoothDevice> devs = FlutterBluePlus.connectedDevices;
    if (latest.isNotEmpty && devs.isNotEmpty) {
      observeHubNotification(device!,1); // 1 for  write pgs
    }
    for (var entry in latest) {
      print("PGN: ${entry["pgn"]}, Freq: ${entry["freq"]}");
    }
  }
   void onSensorSettingUpdated() {
    // This gets called automatically whenever controller updates
    print("BackgroundService received update:");
    if (device != null && device!.isConnected) {
      setTransmissionTimer(device!);
    }

  }
  static final initialPgns = [
    65263, 65520, 65265, 65132, 65215, 65256,
    65267, 65262, 65266, 65253, 65217, 65260,
    65248, 60416, 60160, 65210, 64914, 65134,
    65206, 65269, 65279, 65271, 65268
  ];

  /// Read all PGNs + frequencies from SharedPreferences
  static Future<List<Map<String, dynamic>>> getAllPgns() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.reload();
    String? saved = prefs.getString(storageKey);
    initialList = initialPgns.map((pgn) => {"pgn": pgn, "freq": 10}).toList();

    if (saved == null) return initialList;

    List<dynamic> decoded = jsonDecode(saved);
    return decoded
        .map((e) => {
      "pgn": e["pgn"] as int,
      "freq": e["freq"] as int,
    })
        .toList();
  }
  static void monitorConnection(BluetoothDevice d) {
    device = d;
    d.connectionState.listen((state) {
      switch (state) {
        case BluetoothConnectionState.connected:
          setConnectionState("Connected");

          break;
        case BluetoothConnectionState.disconnected:
          setConnectionState("Disconnected");
          break;
        case BluetoothConnectionState.connecting:
          setConnectionState("Connecting...");
          break;
        case BluetoothConnectionState.disconnecting:
          setConnectionState("Disconnecting...");
          break;
      }
      print("BLE state changed: ${connectionState.value}");
    });
  }
  /// Just for debugging/logging
  static Future<void> printAllPgns() async {
    final list = await getAllPgns();
    for (var entry in list) {
      print("PGN: ${entry["pgn"]}, Freq: ${entry["freq"]}");
    }
  }
  static late DateTime dateLastLocationWSCall = DateTime.now();
  static final ApiService _apiService = ApiService();

  static String elsConnected = "ELD not connected";
  static bool isDiscoverServiceCalled = false;
  static double latitudeSensor = 0.0;
  static double longitudeSensor = 0.0;

  static int sensorGpsTime = 0;
  static  DateTime lastActiveTime = DateTime.now();
  static bool updateFirware = false;
  static int lastCanbusData = 0;
  static int lastCanbusDataWS = 0;
  static int lastCanbusDataTime = 0;
  static final dbHelper = DatabaseHelper.instance;
  static DateTime? speedBelowThresholdStartTime;
  static int countDirectConnectTry = 0;
  static int count65215 = 0;
  static String lastHexData = "";
  static String lastHex = "";
  static String pgnDriving = "";
  static String pgns = "";
  static String lastEldConnectionStatus = "0";
  static List<String> payLoad65520 = [];
  static List<String> payLoad65265 = [];
  static List<String> pgnsAdded = [];
  static List<String> errorcodes = [];
  static int countSpeedLessThan8 = 0;
  static int lastTimeMoveToDrive = DateTime.now().millisecondsSinceEpoch;
  static int lastEldConnectionToPortal = 0;
  static String onDutyReasonDriving = '';
  static int countWrongSpeed = 0;
  static int speed_65520 = 0; // Initialize with appropriate value
  static int speed_65265 = 0; // Initialize with appropriate value
  static int countNonDrive = 0;
  static int stopTime = 0;
  static int countValidNonDriveLocation = 0;
  static int countDriveLocationSpeed = 0;
  static double vehicleSpeed = 0.0;
  static bool isFirstScanDone = false;
  static bool isAppInBg = false;

// Replace with your characteristic UUID
  static final Guid gpsCharacteristicUuid = Guid(
      'ba3689d2-a82a-424a-b9cf-c26a0be437e5');
  static final Guid canbusCharacteristicUuid = Guid(
      'c62268ea-d0b4-4507-8afa-4efc095af8c0');
  static final Guid writePGNCharacteristicUuid = Guid(
      'ab143d21-9a86-43a3-8bd0-cd20cbfce171');
  static final Guid hardwareInfoUUID = Guid(
      '71128f6a-e8d8-4240-a9fe-4490384037e1');

  static final Guid drivingStatusUUID = Guid(
      'edcbc3e9-fcb7-487a-aa93-d872cb378c48');
  static final Guid writeSpeedLimitCharacteristicUuid = Guid(
      '54204adc-dc25-4011-a61f-1e52c866a7f1');
  static final Guid apnUUID = Guid(
      '587fdc3f-682a-41b7-9570-4682d1ff4e6a');
  static final Guid mqttURLUUID  = Guid(
      '3b187bbb-4556-4309-8a66-a613624d81b7');

  static final Guid portUUID = Guid(
      '0bc80a1a-ad2b-49fd-85be-d0a31d13ef74');
  static final Guid mqttUsername  = Guid(
      '9c9c0738-8163-412f-8617-ee0c020a0c2a');
  static final Guid mqttPassword  = Guid(
      '5aae588a-ffa2-4516-a324-d7b5a671f66a');
  static final Guid mqttEvent  = Guid(
      'c3cfdfef-3b10-4620-beb3-3bb918302262');
  static final Guid wifiName  = Guid(
      '234839e8-604a-47b2-9659-07a98e7f7c23');
  static final Guid password  = Guid(
      '990edbd9-e3ff-4a58-b346-706ab51a503c');

  static BluetoothDevice? device;
  static BluetoothCharacteristic? characteristic;
  static int isUpdatedSuccessfully = 0;
  static String errorCodes = "";
  static const notificationChannelId = 'background_service_channel';

// this will be used for notification id, So you can update your custom notification with this id.
  static const notificationId = 888;

   static Future<void> initializeService() async {
    final service = FlutterBackgroundService();

    // Create the notification channel with HIGH importance
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      notificationChannelId, // id
      'MY FOREGROUND SERVICE', // title
      description: 'This channel is used for important notifications.', // description
      importance: Importance.high, // Set importance to high to prevent Android from killing it
    );

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

    // Create the notification channel
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    // Configure the service
    await service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        autoStart: true,  // Ensure auto-start is enabled
        isForegroundMode: getIsForground(),  // Foreground mode ensures the service stays alive
        notificationChannelId: 'background_service_channel',
        initialNotificationTitle: 'eLog Service Running',
        initialNotificationContent: 'eLog app is running in the background',
        foregroundServiceNotificationId: 999,
        autoStartOnBoot: true,  // Restart the service after a device reboot
      ),
      iosConfiguration: IosConfiguration(
        autoStart: true,
        onForeground: onStart,
        onBackground: onIosBackground,
      ),
    );
    service.startService();
     FGBGEvents.instance.stream.listen((event) {
      lastActiveTime = DateTime.now();
      if(event == FGBGType.background) {
        Glob().appStatus = 'bg';
      }
      else{
        Glob().appStatus = 'foreground';
      }
      print("subscription "+ event!.toString());
    });
  }
  @pragma('vm:entry-point')
  static Future<bool> onIosBackground(ServiceInstance service) async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.reload();
    final log = preferences.getStringList('log') ?? <String>[];
    log.add(DateTime.now().toIso8601String());
    await preferences.setStringList('log', log);
    return true;
  }

  @pragma('vm:entry-point')
  static void onStart(ServiceInstance service) {
    // DartPluginRegistrant.ensureInitialized();
    WidgetsFlutterBinding.ensureInitialized();

    service.on('stopService').listen((event) {
      service.stopSelf();
    });
    service.on('destroy').listen((event) {
      service.stopSelf();
    });
    // Monitor when the service is killed

    if (service is AndroidServiceInstance) {
      service.setForegroundNotificationInfo(
        title: "eLog App Running",
        content: "eLog App Location is running in the background.",
      );
    }
    // Timer(const Duration(seconds: 10), () async {
    //   await checkBluetoothPermission();
    // });
    Timer.periodic(const Duration(seconds: 30), (timer) async {
      final DateTime now = DateTime.now();
      service.invoke(
        'update',
        {
          "current_date": elsConnected, // Ensure elsConnected is properly defined
        },
      );
      try {
        fetchLastDutyStatusDetails();
        await checkWSFailures();
        await scanXcomDevices();
        await sendLocationToPortal(now);
      } catch (e) {
        print("Error during periodic tasks: $e");
      }
      relaunch(service);
    });
  }


  static Future<void> sendLocationToPortal(DateTime date) async {
    final difference = date
        .difference(dateLastLocationWSCall)
        .inMinutes;
    if (difference > 3) {
       sendData();
    }
  }

  static Future<void> fetchLastDutyStatusDetails() async {
    Map<String, dynamic> lastRecord = await dbHelper.getLastDutyStatusDetails();
    int dutyStatus = lastRecord['dutyStatus'];
    int dutyStatusId = lastRecord['dutyStatusId'];
    String note = lastRecord['note'];
    String startTime = lastRecord['startTime'];
    if(startTime.isNotEmpty) {
      DateTime utcDateTime = Utility.convertToUtcDateTime(startTime);
      int timePassed = Utility.getTimePassedFromNow(utcDateTime);
      if ((timePassed > 14400 && (dutyStatus == 2)) ||
          (timePassed > 28800 && (dutyStatus == 1))) {
        editLastDutyStatus(4, dutyStatusId, startTime, note);
        dbHelper.updateLastDutyStatus(4);
      }
    }
  }
 static Future<void> editLastDutyStatus(int dutyStatus, int dutyStatusId,String startTime,String note) async {
    bool result = true;
    if (result == true) {
      // try {
      //   await _apiService.callDutyStatusWS(dutyStatus,"",note,startTime,dutyStatusId,false,false,isManually: true);
      // } catch (error) {
      //   handleError(error);
      // }
    } else {
      CustomSnackBar.showCustomErrorSnackBar(message: "Check your internet connection", title: 'Notice!');
    }
  }

  static Future<void> sendData() async {
    dateLastLocationWSCall = DateTime.now();
    bool result = await InternetConnectionChecker().hasConnection;
    if (result) {
      // try {
      //   Response response = await _apiService.callDriverLatLongWS();
      //   handleResponse(response, "DriverLatLongWS");
      // } catch (error) {
      //   handleError(error);
      //   if(error.hashCode == 404){
      //     Utility.logout();
      //   }
      // }
    } else {
      try {
        CustomSnackBar.showCustomErrorSnackBar(
            message: "Check your internet connection", title: 'Notice!');
      }
      catch (error) {
        handleError(error);
      }
    }
  }
  static Future<void> scanXcomDevices() async {
    List<BluetoothDevice> devs = FlutterBluePlus.connectedDevices;
    if(devs.isEmpty){
      updateText("ELD not connected");
      MySharedPref.reloadPreferences();
      String eldSerialNumber = await MySharedPref.getEldSerialNumber();
      if(eldSerialNumber.isNotEmpty){
        connectDirectly(Utility.formatMacAddress(eldSerialNumber));
      }
    }
    else{
      device = devs.first;
      updateText("ELD connected");
      // bool isUpdate = MySharedPref.isUpdateXcom();
      // MySharedPref.reloadPreferences();
      // if(isUpdate){
      //   MySharedPref.setEldUpdateStart(false);
      //   writeStringToEsp32hubnow(MySharedPref.getWifiNetworkName(),MySharedPref.getWifiNetworkPassword(), 1,true);
      // }
    }
  }

  static Future<BluetoothCharacteristic?> _findCharacteristic(String uuid) async {
    List<BluetoothService> services = await device!.discoverServices();
    for (var service in services) {
      for (var char in service.characteristics) {
        if (char.uuid.toString() == uuid) {
          return char;
        }
      }
    }
    return null;
  }

  static Future<void> connectDirectly(String eldSerialNumber) async {
    try {
      //String deviceId = eldSerialNumber.toLowerCase().replaceAll(":", "").trim();
      BluetoothDevice device_ = BluetoothDevice.fromId(eldSerialNumber);
      print("Connecting directly to $eldSerialNumber ...");
      await device_.connect(autoConnect: false); // autoConnect true will try background reconnects
      print("Connected to device: ${device_.remoteId}");
      if(device_.isConnected){
        device = device_;
        sendEldStatustoPortal();
        //
        discoverServices(device!);
        monitorConnection(device!);
        setConnectionState("Connected");
      }
      else{
        scanXcomDevicesNow();
      }
    } catch (e) {
      print("Direct connect error: $e");
      scanXcomDevicesNow();
    }
  }

  static Future<void> scanXcomDevicesNow() async {
    isFirstScanDone = true;
    String eldSerialNumber = await MySharedPref.getEldSerialNumber();
    var subscription = FlutterBluePlus.onScanResults.listen((results) async {
      if (results.isNotEmpty) {
        ScanResult r = results.last; // the most recently found device
        print('remoteId is ${r.device.remoteId}: "${r.advertisementData.advName}" found!');
        String deviceAddress = r.device.remoteId.toString().toLowerCase();
        if (deviceAddress.contains(":")) {
          deviceAddress = deviceAddress.replaceAll(":", "");
        }
        try {
          String mac = r.device.remoteId.toString();
          String deviceAddress = mac.toLowerCase().replaceAll(":", "").trim();
          String myDeviceId = eldSerialNumber.toLowerCase().replaceAll(":", "").trim();
           // (r.device.name ?? "").contains("NG")
          if (deviceAddress == myDeviceId && myDeviceId.isNotEmpty) {
            print("Matched device: $deviceAddress == $myDeviceId");
            await FlutterBluePlus.stopScan();
            isDiscoverServiceCalled = false;
            connectToDevice(r);
          }

        }
        catch(e){
          print("");
        }
      }
    },
      onError: (e) => print(e),
    );
    FlutterBluePlus.cancelWhenScanComplete(subscription);
    // Start scanning
    FlutterBluePlus.startScan(
      timeout: Duration(seconds: 30),
      androidUsesFineLocation: true,
      androidScanMode: AndroidScanMode.lowLatency
    );

  }


  static Future<void> checkBluetoothPermission() async {
    var status = await Permission.bluetoothScan
        .status; // accepted after near by
    if (status.isGranted) {
      checkNearByPermission();
    }

  }

  static Future<void> checkNearByPermission() async {
    var status = await Permission.bluetoothConnect.status;
    if (status.isGranted) {
      scanXcomDevices();
    }
    else {
      await Permission.bluetoothConnect
          .onDeniedCallback(() {})
          .onGrantedCallback(() {
        scanXcomDevices();
      })
          .onPermanentlyDeniedCallback(() {})
          .onRestrictedCallback(() {})
          .onLimitedCallback(() {})
          .onProvisionalCallback(() {})
          .request();
    }
  }
  static void setConnectionState(String connection){
    Future.microtask(() {
      BackgroundService.connectionState.value = connection;
      MySharedPref.setEldConnectionStatus(connection);
      MySharedPref.reloadPreferences();
    });
  }

  static Future<void> connectToDevice(ScanResult r) async {
     r.device.connectionState.listen((
        BluetoothConnectionState state) async {
       if (state == BluetoothConnectionState.connected) {
         setConnectionState("Connected");
         device = r.device;
         sendEldStatustoPortal();
         //
         discoverServices(device!);
         monitorConnection(device!);

       }
        else if (state == BluetoothConnectionState.disconnected) {
         setConnectionState("Disconnected");

         sendEldStatustoPortal();
        print("${r.device.disconnectReason?.code} ${r.device.disconnectReason
            ?.description}");
      }
      else {
        if(device != null && device!.isConnected) {
          setConnectionState("Connected");
          device = r.device;
          sendEldStatustoPortal();
          //  requestHighMTU(r.device);
          discoverServices(device!);
        }
      }
    });
   // r.device.cancelWhenDisconnected(subscription, delayed: true, next: true);
    await r.device.connect(autoConnect: true, mtu: null);
    // subscription.cancel();

  }

  static Future<void> requestHighMTU(BluetoothDevice device) async {
    final subscription = device.mtu.listen((int mtu) {
      // iOS: initial value is always 23, but iOS will quickly negotiate a higher value
      print("mtu $mtu");

    });
    device.cancelWhenDisconnected(subscription);
    if (Platform.isAndroid) {
      await device.requestMtu(512);
    }
  }

  static Future<void> discoverServices(BluetoothDevice device) async {
    requestHighMTU(device);
    Timer(const Duration(seconds: 15), () {
      updateWifi(device,'Jionewtv','12345678'); // type 3 for Canbus
    });
    Timer(const Duration(seconds: 10), () {
      startMQTT(device); // type 3 for Canbus
    });
    Timer(const Duration(seconds: 5), () {
       setTransmissionTimer(device);
     // setTransmissionTimerAllSettings(device);

    });
    Timer(const Duration(seconds: 20), () {
      observeHubNotification(device,-2); // type 3 for Canbus
    });
    Timer(const Duration(seconds: 25), () {
      observeHubNotification(device,-1); // type 3 for Canbus
    });
    Timer(const Duration(seconds: 30), () {
      observeHubNotification(device,0); // 0 for write speed limit
    });
    Timer(const Duration(seconds: 35), () {
      observeHubNotification(device,1); // 1 for  write pgs
    });
    Timer(const Duration(seconds: 40), () {
      observeHubNotification(device,2);  // type 2 for GPS
    });
    Timer(const Duration(seconds: 45), () {
      observeHubNotification(device,3); // type 3 for Canbus
    });

  }

 static void observeHubNotification(BluetoothDevice device, int type) async {
    try {
      List<BluetoothService> services = await device.discoverServices();
      for (BluetoothService service in services) {
        for (BluetoothCharacteristic characteristic in service
            .characteristics) {
          if (characteristic.uuid == drivingStatusUUID && type == -2) {
            observeNotifications(characteristic);
            break;
          }
         else if (characteristic.uuid == hardwareInfoUUID && type == -1) {
            observeNotifications(characteristic);
            break;
          }
          else if (characteristic.uuid == writePGNCharacteristicUuid && type == 0) {
            writeSpeedLimit(characteristic);
            break;
          }
         else if (characteristic.uuid == writePGNCharacteristicUuid && type == 1) {
            writePGNDataNow(characteristic);
            break;
          }
          else if (characteristic.uuid == gpsCharacteristicUuid && type == 2) {
            observeNotifications(characteristic);
            break;
          }
          else if (characteristic.uuid == canbusCharacteristicUuid && type == 3) {
            observeNotifications(characteristic);
            break;
          }
        }
      }
    } catch (e) {
      print('Error setting up notification: $e');
    }
  }

  static BluetoothCharacteristic? findCharacteristic(
      List<BluetoothService> services, String uuid) {
    try {
      return services
          .expand((s) => s.characteristics) // flatten all characteristics
          .firstWhere(
            (c) => c.uuid.toString().toLowerCase() == uuid.toLowerCase(),
        orElse: () => null as BluetoothCharacteristic, // workaround for type
      );
    } catch (_) {
      return null;
    }
  }

// Assuming writeStringToHub is a method that writes data to a hub
  static Future<void> writeStringToHub(List<BluetoothService> services, String value, String uuid, bool isHex) async {
    print('Writing to hub: value=$value, uuid=$uuid');
    try {
      final characteristic = findCharacteristic(services, uuid);
      if (characteristic != null) {
        List<int> bytes = value.codeUnits;//utf8.encode(value);
        if(isHex){
          bytes = hexToBytes(value);
        }
        await characteristic.write(bytes, withoutResponse: false);

        // await writeCharacteristic(characteristic, bytes);
        print("Write successful to $uuid");
      } else {
        print("Characteristic $uuid not found");
      }
    } catch (e) {
      print('Error writing to hub: $e');
    }
  }

  static Future<void> startMQTT(BluetoothDevice device) async {
   if(device !=null && device.isConnected){
     List<BluetoothService> services = await device.discoverServices();
     final data = [
     //  ['flolive.net', '587fdc3f-682a-41b7-9570-4682d1ff4e6a'],
       ['mqtt://50.248.143.225', '3b187bbb-4556-4309-8a66-a613624d81b7'],
       ['mqtt://50.248.143.225', '3b187bbb-4556-4309-8a66-a613624d81b7'],
       ['mqtt://50.248.143.225', '3b187bbb-4556-4309-8a66-a613624d81b7'],
       ["flolive.net", "587fdc3f-682a-41b7-9570-4682d1ff4e6a"],
       ["mqtt://50.248.143.225","3b187bbb-4556-4309-8a66-a613624d81b7"],
       ["1883", "0bc80a1a-ad2b-49fd-85be-d0a31d13ef74"],
       ["xcom5gnc", "9c9c0738-8163-412f-8617-ee0c020a0c2a"],
       ["XyC?5gBr828+eL!", "5aae588a-ffa2-4516-a324-d7b5a671f66a"],
       ["xcom5gc_event", "c3cfdfef-3b10-4620-beb3-3bb918302262"]
     ];
     int delay = 0; // initial delay in milliseconds
     for (var entry in data) {
       final value = entry[0];
       final uuid = entry[1];
       Future.delayed(Duration(milliseconds: delay), () {
         writeStringToHub(services,value, uuid,false);
       });
       delay += 3000; // increase by 10 seconds for next call
     }
   }
  }
  static Future<void> setTransmissionTimer(BluetoothDevice device) async {
    if (device == null || !device.isConnected) return;
    List<BluetoothService> services = await device.discoverServices();
    BluetoothService? sensorService = services.firstWhere(
          (s) => s.uuid.toString() == '6cb3c4bd-fc4f-4abd-b356-fff4e6326381',
    );
    if (sensorService == null) return;
    BluetoothCharacteristic? sensorDevChar = sensorService.characteristics.firstWhere(
          (c) => c.uuid.toString() == '6e72881c-5d35-4652-bbeb-e2a14dbd1f17',
    );
    if (sensorDevChar == null) return;
    BluetoothCharacteristic? setLimitChar = sensorService.characteristics.firstWhere(
          (c) => c.uuid.toString() == '025590ee-ab41-497a-b801-fe5e8ad8cd46',
    );
    if (setLimitChar == null) return;
    await sensorDevChar.setNotifyValue(true);
    List<int> serials = [];
    Completer<void> completer = Completer();
    int expectedNum = 0;
    StreamSubscription<List<int>>? sub = sensorDevChar.value.listen((List<int> value) {
      if (value.length != 7) return;
      int num = value[0];
      int index = value[1];
      int serial = value[2] | (value[3] << 8) | (value[4] << 16) | (value[5] << 24); // Little-endian uint32_t
      int fw = value[6];
      if (expectedNum == 0) expectedNum = num;
      if (!serials.contains(serial)) serials.add(serial);
      if (serials.length >= expectedNum) {
        completer.complete();
      }
    });
    try {
      await completer.future.timeout(Duration(seconds: 10));
    } catch (e) {
    } finally {
      sub?.cancel();
    }
    int? timer = MySharedPref.getTransmissionTimer();
    // Now set the 60-second transmission timer for each sensor serial
    int delay = 0;
    for (int serial in serials) {
      List<int> bytes = [
        serial & 0xFF,
        (serial >> 8) & 0xFF,
        (serial >> 16) & 0xFF,
        (serial >> 24) & 0xFF,  // sensor_serial uint32_t
        0,                      // sensor_id = SENSOR_ID_GENERAL (0)
        timer! & 0xFF,
        (timer! >> 8) & 0xFF,       // u_limit = 60 (transmit interval)
        0, 0,                   // l_limit = 0 (no battery trigger)
        0                       // trigger_enable = 0
      ];
      Future.delayed(Duration(milliseconds: delay), () async {
        await setLimitChar.write(bytes);
      });
      delay += 3000; // 3-second delay between writes, similar to the example
    }
  }
  static Future<void> setTransmissionTimerAllSettings(BluetoothDevice device) async {
    final packets = await loadPacketsFromPrefs();
    if (packets == null || packets.isEmpty) return;

    if (device == null || !device.isConnected) return;

    // Discover services
    List<BluetoothService> services = await device.discoverServices();

    // Sensor Service (UUID from PDF)
    BluetoothService? sensorService = services.firstWhere(
          (s) => s.uuid.toString() == '6cb3c4bd-fc4f-4abd-b356-fff4e6326381',
    );

    if (sensorService == null) return;

    // Set Sensor Limit Characteristic (UUID from PDF)
    BluetoothCharacteristic? setLimitChar = sensorService.characteristics.firstWhere(
          (c) => c.uuid.toString() == '025590ee-ab41-497a-b801-fe5e8ad8cd46',
    );

    if (setLimitChar == null) return;

    // 🔹 Load all prepared packets from SharedPreferences

    // 🔹 Write each packet with a delay
    int delay = 0;
    for (var pkt in packets) {
      Future.delayed(Duration(milliseconds: delay), () async {
        try {
          await setLimitChar.write(pkt, withoutResponse: false);
          debugPrint("✅ Wrote packet: ${pkt.map((b) => b.toRadixString(16).padLeft(2, '0')).join(' ')}");
        } catch (e) {
          debugPrint("⚠️ Error writing packet: $e");
        }
      });
      delay += 3000; // 3-second gap between writes
    }

  }

  static Future<List<Uint8List>> loadPacketsFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.reload();
    final encoded = prefs.getStringList("sensor_packets") ?? [];
    return encoded.map((s) => base64Decode(s)).toList();
  }

  static Future<void> updateWifi(BluetoothDevice device,String wifiName, String password) async {
   List<BluetoothService> services = await device.discoverServices();

   final data = [
      [wifiName, '234839e8-604a-47b2-9659-07a98e7f7c23'],
      [password, '990edbd9-e3ff-4a58-b346-706ab51a503c'],
    ];

    int delay = 0; // initial delay in milliseconds
    for (var entry in data) {
      final value = entry[0];
      final uuid = entry[1];
      Future.delayed(Duration(milliseconds: delay), () {
       writeStringToHub(services,value, uuid,false);
      });
      delay += 5000; // increase by 5 seconds for next call
    }
  }


 static void moveToDrive(DutyStatus dutyStatus1) {
      changeDutyStatus( dutyStatus1);
      sendShiftToPortal(dutyStatus1);
  }

  static Future<void> sendShiftToPortal(DutyStatus dutyStatus) async {
    bool result = true;
    if (result == true) {
      try {
        // Response response = await _apiService.callDutyStatusWS(dutyStatus.index + 1,"","","",0,false,false);
        // handleResponse(response, "DutyStatus");
      } catch (error) {
        handleError(error);
      }
    } else {
      CustomSnackBar.showCustomErrorSnackBar(message: "Check your internet connection", title: 'Notice!');
    }
  }

 static void handleResponse(Response response, String ws) {
    if (response.statusCode == 200) {
      if (response.data["Message"] != null) {
        CustomSnackBar.showCustomSnackBar(
            title: "Notice!", message: response.data["Message"]);
      } else {}
    } else {
      CustomSnackBar.showCustomErrorToast(
          title: "Notice!", message: "Error Occured.");
    }
    sendEldStatustoPortal();
  }

  static void handleError(Object error) {
    try {
      DioException? err = error as DioException?;
      String? message = err?.response?.data["Message"];
      CustomSnackBar.showCustomErrorToast(
          title: "Notice!", message: message ?? "An error occurred");
    }
    catch(e){

    }
  }

  static void changeDutyStatus(DutyStatus dutyStatus) {
    //MySharedPref.setDutyStatus(dutyStatus);
    FBroadcast.instance().broadcast("updateTimer");
  }
  static Future<void> observeNotifications(BluetoothCharacteristic characteristic) async {
    if (characteristic.uuid == drivingStatusUUID) {
      try {
        await characteristic.setNotifyValue(true);
        characteristic.value.listen((bytes) {
          procesBytes(bytes, -2);
        }).onError((error) {
          // String text1 = " gps ${error.toString()}";
        });
      }
      catch(e){}
    }
   else if (characteristic.uuid == gpsCharacteristicUuid) {
      await characteristic.setNotifyValue(true);
      characteristic.value.listen((bytes) {
        procesBytes(bytes,1);
      }).onError((error) {
        String text1 = " gps ${error.toString()}";
      });
    }
    else  if (characteristic.uuid == canbusCharacteristicUuid) {
      await characteristic.setNotifyValue(true);
      characteristic.value.listen((bytes) {
        procesBytes(bytes, 3);
      }).onError((error) {
        String text1 = " gps ${error.toString()}";
      });
    }
    else  if (characteristic.uuid == hardwareInfoUUID) {
      if (characteristic.properties.read) {
        List<int> value = await characteristic.read();
        procesBytes(value, -1);
      }
      await characteristic.setNotifyValue(true);
      characteristic.value.listen((bytes) {
        procesBytes(bytes, -1);
      }).onError((error) {
        String text1 = " gps ${error.toString()}";
      });
    }
  }



  static Future<void> writePGNDataNow(BluetoothCharacteristic characteristic) async {
     clearPgn();
    if (true) {
      List<String> pgns = [];
      // String pgnsList = "65520,65520,65520,65265,65132,65215,65256,65267,65262,65266,65263,65253,65217,65263,65265,65260,65248,60416,60160,65210,64914,65134,65206,65269,65279,65271,65268";
      // List<String> list = pgnsList.split(",");
      // for (var i = 0; i < list.length; i++) {
      //   String hex = decToHex(int.parse(list[i]));
      //   hex = getLittleEndian(hex) + "6400";
      //   pgns.add(hex);
      // }

      final pgn_list = await getAllPgns();
      for (var entry in pgn_list) {
        String hex = decToHex(entry["pgn"]);
        int freq = entry["freq"];
        String freq_hex = Utility.decimalToSwappedHex(freq);
        hex = getLittleEndian(hex) + freq_hex;
        pgns.add(hex);
        print("PGN: ${entry["pgn"]}, Freq: ${entry["freq"]}");
      }
        for (int i = 0; i < pgns.length; i++) {
          Timer(Duration(milliseconds: i * 3000), () {
              if (!pgnsAdded.contains(pgns[i])) {
                writePGNS(characteristic,pgns[i], i, pgns.length);
              }
          });
        }

    }
  }


  static Future<void> writePGNS(
      BluetoothCharacteristic characteristic,
      String pgnData,
      int index,
      int size) async {
      final value = hexToBytes(pgnData);
      try {
        await characteristic.write(value);
        pgnsAdded.add(pgnData);
        String text1 = "writePGNData success";
        if (!errorcodes.contains(text1)) {
          errorcodes.add(text1);
        }
      } catch (e) {
        pgnsAdded.clear();
        String text1 = "writePGNData ${e.toString()}";
        if (!errorcodes.contains(text1)) {
          errorcodes.add(text1);
        }
      }
      if (index == (size - 3)) {
           getSensorDetails();
      }

  }

  static List<int> hexToBytes(String hex) {
    final buffer = StringBuffer();
    for (var i = 0; i < hex.length; i += 2) {
      buffer.writeCharCode(int.parse(hex.substring(i, i + 2), radix: 16));
    }
    return buffer.toString().codeUnits;
  }


 static String decToHex(int dec) {
    return dec.toRadixString(16).toUpperCase().padLeft(4, '0');
  }

// Ensure that Utility, BLEUtility, LogUtility, writePGNS, writePGNSRxBle, getSensorDetails, writeSpeedLimit, and other methods are properly defined in your Dart project.



  static void procesBytes(List<int> bytes, int type) {
    try {
      procesBytesNow(bytes, type);
    }
    catch(e){}
  }
  static void procesBytesNow(List<int> bytes, int type) {
    String hex = Utility.bytesToHex(bytes);
    if(type == 1 && hex.length>4) {
      checkIfGPSData(hex);
    }
    else if (type == 3 && hex.length>4){
      processCanbusDataStream(hex);
    }
    else if (type == -1 && hex.length>4){
      getHardwareInfo(hex);
    }
    else if (type == -2 && hex.length>4){
      processDrivingValue(hex);
    }
  }
  static Future<void> getHardwareInfo(String hex) async {
    String batteryLevelHex = hex.substring(0, 4);
    int batteryLevel = int.parse(batteryLevelHex, radix: 16);
    String firmwareVersionHex = hex.substring(4, 6);
    int espFirmwareVersion = int.parse(firmwareVersionHex, radix: 16);
    MySharedPref.setHubFirmwareVersion(espFirmwareVersion);
    String powerStatusHex = hex.substring(6, 8);
    int espPowerStatus = int.parse(powerStatusHex, radix: 16);
    print('Battery Level: $batteryLevel');
    print('Firmware Version: $espFirmwareVersion');
    print('Power Status: $espPowerStatus');
  }

 static void  processCanbusDataStream(String hex) {
    int timePassed = (DateTime.now().millisecondsSinceEpoch - lastCanbusData) ~/ 1000;
    int pgn = getPgn(hex);
    if(timePassed > 30){
      speedBelowThresholdStartTime = null;
    }
    int timePassedPortal = (DateTime.now().millisecondsSinceEpoch - lastCanbusDataWS) ~/ 1000;
    if(timePassedPortal > 300){
      lastCanbusDataWS = DateTime.now().millisecondsSinceEpoch;
      sendHexToPortal(hex);
    }
    if (timePassed > 10 || (pgn == 65132 || pgn == 65215 || pgn == 65265)) {
      lastCanbusData = DateTime.now().millisecondsSinceEpoch;
      parseNewHubData(hex);
    }
    try{
      saveLastCanbusData();
    }
    catch(e){}
 }

  static void parseNewHubData(String upLinkData) {
    countDirectConnectTry = 0;
    if (payLoad65520.isNotEmpty) {
      payLoad65520.clear();
    }
    if (payLoad65265.isNotEmpty) {
      payLoad65265.clear();
    }
    String parseToastMessage = "";

    if (upLinkData.startsWith("0x") || upLinkData.startsWith("Ox")) {
      upLinkData = upLinkData.substring(2);
    }
    List<String> payLoadList = [];
    int pgnIndex = 0;
    String pgn = upLinkData.substring(pgnIndex, pgnIndex + 4);
    int pgnInt = int.parse(getLittleEndian(pgn), radix: 16);
    int sensorDataBytes = 4;
    if (pgnInt == 65267 || pgnInt == 65132) {
      sensorDataBytes = 8;
    } else if (pgnInt == 65215 && count65215 > 20) {
      count65215 = 0;
      lastHexData = upLinkData;
    } else {
      lastHexData = upLinkData;
    }

    if (pgnInt == 65215) {
      count65215++;
      lastHex = upLinkData;
    }
    if (!pgns.contains(pgnInt.toString())) {
      pgns += "$pgnInt , ";
    }
    int payLoadIndex = pgnIndex + pgn.length;
    String payloadStr = upLinkData.substring(payLoadIndex, payLoadIndex + (sensorDataBytes * 2));
    payLoadList.add(payloadStr);
    parseToastMessage += " PGN: $pgnInt";
    if (pgnInt == 65215 || pgnInt == 65132) {
      try {
        parseDrivingPGNData(payloadStr, pgnInt == 65215 ? 1 : 2);
      } catch (e) {
        print(e);
      }
    }
    if (pgnInt == 65248) {
      String payLoad = payloadStr.substring(0, 8);
      int temp = int.parse(getLittleEndian(payLoad), radix: 16);
      double tripDistance = temp * 0.125;
      if (!parseToastMessage.contains("Trip Distance")) {
        parseToastMessage += "\n Trip Distance: $tripDistance (m) \n";
      }
      String payloadStr2 = upLinkData.substring(4 + payloadStr.length, 20);
      temp = int.parse(getLittleEndian(payloadStr2), radix: 16);
      double totalTripDistance = temp * 0.125;
      if (!parseToastMessage.contains("Total Distance")) {
        parseToastMessage += " Total Distance: $totalTripDistance (m) \n";
      }
    }
    if (pgnInt == 61444) {
      String statusEEC1 = payloadStr.substring(0, 2);
      if (!parseToastMessage.contains("Status_EEC1")) {
        parseToastMessage += " Status_EEC1: $statusEEC1\n";
      }
      String enginePercentTorque = "${int.parse(getLittleEndian(payloadStr.substring(2, 4)), radix: 16) - 125} %";
      if (!parseToastMessage.contains("Driver demand engine torque:")) {
        parseToastMessage += " Driver demand engine torque: $enginePercentTorque\n";
      }
      int index = 4 + payloadStr.length - 2;
      String engineSpeedPayload = upLinkData.substring(index, index + 4);
      String engineSpeed = "${int.parse(getLittleEndian(engineSpeedPayload), radix: 16) * 0.125} rpm/bit";
      if (!parseToastMessage.contains("Engine speed")) {
        parseToastMessage += " Engine speed: $engineSpeed\n";
      }
      // Add Utility.showLog function if needed
    }

    if (pgnInt == 65267) {
      String payLoad = payloadStr.substring(0, 8);
      double latitude = hex2Decimal(getLittleEndian(payLoad));
      String payLoad1 = payloadStr.substring(8, 16);
      double longitude = double.parse(getLittleEndian(payLoad1));
    }
    if (pgnInt == 65253) {
      String payLoad = payloadStr.substring(0, 8);
      int enginehrs = int.parse(getLittleEndian(payLoad), radix: 16);
      double engineHours = Utility.round(enginehrs * 0.05, 2);
      if (!parseToastMessage.contains("Engine Hours")) {
        parseToastMessage += " Engine Hours: $engineHours\n";
      }
      MySharedPref.saveLastEngineHours(engineHours);
    }

    if (pgnInt == 65266) {
      String payLoad = payloadStr.substring(0, 4);
      int temp = int.parse(getLittleEndian(payLoad), radix: 16);
      double fuelRate = temp * 0.05;
      String fuelRateStr = "$fuelRate L/h";
      if (!parseToastMessage.contains("Fuel rate")) {
        parseToastMessage += " Fuel rate: $fuelRateStr\n";
      }

      String payLoad1 = payloadStr.substring(4, 8);
      int temp1 = int.parse(getLittleEndian(payLoad1), radix: 16);
      double instantaneousFuelEconomy = temp1 / 512;
      String instantaneousFuelEconomyStr = "$instantaneousFuelEconomy Km/L";
      if (!parseToastMessage.contains("Instantaneous fuel economy")) {
        parseToastMessage += " Instantaneous fuel economy: $instantaneousFuelEconomyStr\n";
      }
      payloadStr = upLinkData.substring(4 + payloadStr.length, 20);
      String payLoad2 = payloadStr.substring(0, 4);
      int temp2 = int.parse(getLittleEndian(payLoad2), radix: 16);
      double averageFuelEconomy = temp2 / 512;
      String averageFuelEconomyStr = "$averageFuelEconomy Km/L";
      if (!parseToastMessage.contains("Average fuel economy")) {
        parseToastMessage += " Average fuel economy: $averageFuelEconomyStr\n";
      }
    }
    if (pgnInt == 65520) {
      if (payLoad65520.isNotEmpty) {
        payLoad65520.clear();
      }
      if (payLoad65265.isNotEmpty) {
        payLoad65265.clear();
      }
      payLoad65520.add(payloadStr);
    } else if (pgnInt == 65217) {
      String payLoad = payloadStr.substring(0, 8);
      int odometer = int.parse(getLittleEndian(payLoad), radix: 16) * 5;
      processOdometer(upLinkData, odometer);
    } else if (pgnInt == 65265) {
      payLoad65265.add(payloadStr);
    }
    if (payLoad65520.isNotEmpty || payLoad65265.isNotEmpty) {
      int speed65520 = -1;
      int speed65265 = -1;
      if (payLoad65520.isNotEmpty) {
        speed65520 = int.parse(payLoad65520.last.substring(2, 4), radix: 16);
        pgnDriving = "655200 $speed65520";
      }
      if (payLoad65265.isNotEmpty) {
        double baseSpeed = double.parse(getLittleEndian(payLoad65265.last.substring(2, 6)));
        speed65265 = (baseSpeed / 256).round();
        pgnDriving = "65265 $speed65265";
        if (speed65265 == 255 || speed65265 < 0) {
          lastHex = "";
          return;
        }
      }

      if (speed65265 > 0 && speed65265 < 160) {
        if (speed65265 > 8.1) {
          canbusSpeedMoreThan8(upLinkData, "65265", speed65265);
        } else if (speed65265 < 8.1) {
          canbusSpeedLessThan8("65265", speed65265);
        }
      }
    }
  }

  static double hex2Decimal(String s) {
    return int.parse(s, radix: 16) / 1e7;
  }


  static void parseDrivingPGNData(String payloadStr, int type) {
    try {
      String drivingPart = "";
      if (type == 1 || type ==3) {
        pgnDriving = (type == 1?"65215":"61443");
        drivingPart = payloadStr.substring(2, 4);
      }
      else if (type == 2) {
        pgnDriving = "65132";
        drivingPart = payloadStr.substring(payloadStr.length-2, payloadStr.length);
      }
      int speed = int.parse(drivingPart, radix: 16);
      pgnDriving = "$pgnDriving $speed";
      if (drivingPart.isNotEmpty && speed>-100 && speed<180 ) {
        if (speed > 8.1) {
          canbusSpeedMoreThan8(payloadStr,type==2?"65132":"65215",speed);
        } else if (speed < 8.1) {
          canbusSpeedLessThan8(type==2?"65132":"65215",speed); // new Sensor
        }
      }
    }
    catch (e){}
  }
 static void canbusSpeedMoreThan8(String upLinkData, String pgn, int speed) {
    countSpeedLessThan8 = 0;
    int timePassed = (DateTime.now().millisecondsSinceEpoch - lastTimeMoveToDrive) ~/ 1000;
    if (timePassed > 10) {
      onDutyReasonDriving = 'Driving PGN $pgn speed $speed ';
      lastTimeMoveToDrive = DateTime.now().millisecondsSinceEpoch;
      processcanbusSpeedMoreThan8(upLinkData, pgn);
    }
  }
  static void processcanbusSpeedMoreThan8(String upLinkData, String pgn) {
    speedBelowThresholdStartTime = null;
    countWrongSpeed = 0;
    int maxSpeed = speed_65520;
    if (speed_65265 > maxSpeed) {
      maxSpeed = speed_65265;
    }
    countNonDrive = 0;
    stopTime = 0;
    countValidNonDriveLocation = 0;
    countDriveLocationSpeed++;
    String pgnName;
    double pgnSpeed;
    if (speed_65265 > 8.1) {
      pgnName = '65265';
      pgnSpeed = speed_65265.toDouble();
      vehicleSpeed = pgnSpeed;
    } else {
      pgnName = '65520';
      pgnSpeed = speed_65520.toDouble();
      vehicleSpeed = pgnSpeed;
    }
    bool? isPCStarted = MySharedPref.isPCStarted();
    int? driverId = MySharedPref.getDriverId(); // Pass appropriate context if needed
    int? currentDutyStatus = MySharedPref.getDutyStatus(); // Pass appropriate context if needed
    if (currentDutyStatus != 1 && driverId! > 0 && !isPCStarted! ) {
      try {
        moveToDrive(DutyStatus.DRIVING);
      } catch (e) {
        e.printError();
        // Handle exception or log error if needed
      }
    } else {
      removeLocationAndOdometerIfNeeded();
    }
  }


  static void processOdometer(String data, int odometer) {
    double odometerNow = odometer * 0.000621371192;
    MySharedPref.saveTruckOdometer(odometerNow);
  }


  static void canbusSpeedLessThan8(String pgn, int speed) {
    int? driverId = MySharedPref.getDriverId(); // Pass appropriate context if needed
    int? currentDutyStatus = MySharedPref.getDutyStatus(); // Pass appropriate context if needed
    int? dutyStatusToPortal = MySharedPref.getLastDutyStatusToPortal();
    if (currentDutyStatus == 1 && driverId! > 0 && dutyStatusToPortal != 2 && speedBelowThresholdStartTime == null) {
      try {
        speedBelowThresholdStartTime ??= DateTime.now(); // if null then initialize
        changeDutyStatus(DutyStatus.ON_DUTY);
       }
       catch (e) {
        e.printError();
      }
    }
    if (driverId! > 0 && dutyStatusToPortal != 2) {
      sendOnDutyToPortal();
    }
  }


  static int getPgn(String upLinkData) {
    try {
      if (upLinkData.startsWith("0x") || upLinkData.startsWith("Ox")) {
        upLinkData = upLinkData.substring(2);
      }
      int pgnIndex = 0;
      String pgn = upLinkData.substring(pgnIndex, pgnIndex + 4);
      int pgnInt = int.parse(getLittleEndian(pgn), radix: 16);
      return pgnInt;
    } catch (e) {
      print(e);
    }
    return -1;
  }

  static String getLittleEndian(String hexadecimal) {
    List<int> serialBytes = hexToByte(hexadecimal);
    int j = serialBytes.length - 1;
    int i = 0;
    while (j > i) {
      int temp = serialBytes[j];
      serialBytes[j] = serialBytes[i];
      serialBytes[i] = temp;
      j--;
      i++;
    }
    String result = Utility.bytesToHex(serialBytes);
    print(result); // Replace with your logging mechanism if needed
    return result.replaceAll(" ", "");
  }
 static List<int> hexToByte(String hexStr) {
    int length = hexStr.length;
    List<int> byteData = List.filled(length ~/ 2, 0);
    for (int i = 0; i < length; i += 2) {
      byteData[i ~/ 2] = (int.parse(hexStr[i], radix: 16) << 4) + int.parse(hexStr[i + 1], radix: 16);
    }
    return byteData;
  }

  static void checkIfGPSData(String hex) {
    sendOnDutyToPortal();
    StringBuffer output = StringBuffer();
    try {
      for (int i = 0; i < hex.length; i += 2) {
        String str = hex.substring(i, i + 2);
        output.write(String.fromCharCode(int.parse(str, radix: 16)));
      }
    } catch (e) {
      print(e);
    }
    int length = hex.length;
    if (length % 2 == 1) hex = "0" + hex;
    StringBuffer sb = StringBuffer();
    for (int i = 0; i < hex.length; i += 2) {
      String hex1 = "${hex[i]}${hex[i + 1]}";
      int ival = int.parse(hex1, radix: 16);
      sb.write(String.fromCharCode(ival));
    }
    if (output.isNotEmpty && output.toString().contains(", ")) {
      List<String> array = output.toString().split(", ");
      double latitude = 0;
      try {
        latitude = double.parse(array[0]);
      } catch (e) {
        print(e);
      }
      double longitude = 0;
      try {
        longitude = double.parse(array[1]);
      } catch (e) {
        print(e);
      }
      if (latitude != 0 &&
          longitude != 0 &&
          (latitude > 0 || latitude < 0) &&
          (longitude > 0 || longitude < 0) &&
          isValidLatLng(latitude, longitude)) {
          latitudeSensor = latitude;
          longitudeSensor = longitude;
          sensorGpsTime = DateTime.now().millisecondsSinceEpoch;
      }
    }
  }

// Function to validate latitude and longitude
  static bool isValidLatLng(double latitude, double longitude) {
    return latitude >= -90 && latitude <= 90 && longitude >= -180 && longitude <= 180;
  }

 static void writeSpeedLimit(BluetoothCharacteristic characteristic) {
    writeCharacteristic(characteristic, hexToByte('0x000801'));
  }
  static Future<void> writeCharacteristic(BluetoothCharacteristic characteristic, List<int> value) async {
    try {
      await characteristic.write(value);
    } catch (e) {}
  }

  static void getSensorDetails() {

  }

  static void removeLocationAndOdometerIfNeeded() {

  }

  static void sendOnDutyToPortal() {
    if (speedBelowThresholdStartTime != null) {
      Duration timeBelowThreshold = DateTime.now().difference(speedBelowThresholdStartTime!);
      int? currentDutyStatus = MySharedPref.getDutyStatus();
      int? dutyStatusToPortal = MySharedPref.getLastDutyStatusToPortal();
      if (timeBelowThreshold.inSeconds > 90 && currentDutyStatus == 2 && dutyStatusToPortal != 2) {
        speedBelowThresholdStartTime = null;
        sendShiftToPortal(DutyStatus.ON_DUTY);
      }
    }
  }

  static void sendHexToPortal(String hex) {
  //  _apiService.sendHexToPortal(hex);
  }

  static Future<void> sendEldStatustoPortal() async {
    int timePassed = (DateTime
        .now()
        .millisecondsSinceEpoch - lastEldConnectionToPortal) ~/ 1000;
    if (timePassed > 60) {
      lastEldConnectionToPortal = DateTime.now().millisecondsSinceEpoch;
      String isConnected = "2";
      updateText("ELD not connected");
      List<BluetoothDevice> devs = FlutterBluePlus.connectedDevices;
      if (devs.isNotEmpty) {
        isConnected = "1";
        updateText("ELD connected");
      }
      if (isConnected != lastEldConnectionStatus) {
        lastEldConnectionStatus = "0";
        try {
          // Response response = await _apiService.sendEldStatus(isConnected);
          // if (response.statusCode == 200) {
          //   lastEldConnectionStatus = isConnected;
          // }
        }
        catch(e){
          lastEldConnectionToPortal = 0;
          e.printError();
        }
      }
    }
  }
 static void updateText(String text) {
    // Access the Singleton instance and change the text
   //if(MySingleton.text != text)
   {
     MySingleton.text = text;
     elsConnected = text;
    // MySharedPref.saveEldConnectionStatus(text.contains('not')?false:true);
   }
 }

  static void writeStringToEsp32hubnow(String s, String t, int i, bool bool) {
    writeStringToEsp32Hub(s,t,i,bool);
  }
  static void  writeStringToEsp32Hub(String str, String str1, int type, bool isXcom) async {
    isUpdatedSuccessfully = 0;
    if (device != null) {
      String characteristicUUID = "234839e8-604a-47b2-9659-07a98e7f7c23";
      switch (type) {
        case 2:
          characteristicUUID = "990edbd9-e3ff-4a58-b346-706ab51a503c";
          break;
        case 3:
          characteristicUUID = "87bfac28-f7af-4e2e-bc99-d9aca5d2c8d3";
          break;
        case 4:
          characteristicUUID = "2aa6047e-630e-4071-895b-2f998cd0935d";
          break;
        case 5:
          characteristicUUID = "1c05afea-1e44-40f3-b3cf-2fa860957548";
          break;
      }
      try {
        List<int> data = [0x00]; // Sample data, replace with actual
        List<int> payload = type == 5
            ? (isXcom ? data : utf8.encode(await MySharedPref.getEldSerialNumber()))
            : utf8.encode(str);

        characteristic = await _findCharacteristic(characteristicUUID);
        if (characteristic != null) {
          await characteristic!.write(payload);
          String successMsg = "Write String success $str";
          if (type == 5) isUpdatedSuccessfully = 1;
          if (!errorCodes.contains(successMsg)) {
            errorCodes += successMsg;
          }
          // Recursive calls for subsequent types
          if (type == 1) {
             writeStringToEsp32Hub(str1, "", 2, isXcom);
          } else if (type == 2) {
             writeStringToEsp32Hub("http://dev.redegg.net/public", "", 3, isXcom);
          } else if (type == 3) {
             writeStringToEsp32Hub(isXcom ? "kaydon_ng_base_V17.bin" : "kaydon_ng_sensor_V9.bin", "", 4, isXcom);
          } else if (type == 4) {
             writeStringToEsp32Hub("000000", "", 5, isXcom);
          }
        }
      } catch (e) {
        isUpdatedSuccessfully = 2;
        String errorMsg = "Write String $str ${e.toString()}";
        if (!errorCodes.contains(errorMsg)) {
          errorCodes += errorMsg;
        }
      }
    }
  }

  static void processDrivingValue(String hex) {
    try{
      saveLastCanbusData();
    }
    catch(e){}
    String speed = hex.substring(hex.length - 2, hex.length);
    String pgnDriving = "65520 $speed";
    double baseSpeed = int.parse(getLittleEndian(speed), radix: 16).toDouble();
    if (baseSpeed > -1 && baseSpeed < 200 ) {
      if (baseSpeed > 8.1) {
        canbusSpeedMoreThan8(hex, "65520", baseSpeed as int);
      } else {
        canbusSpeedLessThan8("65520", baseSpeed as int);
      }
    }
  }

  static void saveLastCanbusData() {
    int timePassedFromLastSave = (DateTime.now().millisecondsSinceEpoch - lastCanbusDataTime) ~/ 1000;
    if(timePassedFromLastSave > 60){
      lastCanbusDataTime = DateTime.now().millisecondsSinceEpoch;
      MySharedPref.setLastCanbusDataTime(lastCanbusDataTime);
    }
  }

  static checkWSFailures() async {
    if (await InternetConnectionChecker().hasConnection) {
    //  final failures = await dbHelper.fetchAllDutyStatusWSFailures();
     // for (var failure in failures) {
        // dbHelper.deleteDutyStatusWSFailures(
        //     "DutyStatus", failure['WSRequestJSON']);
        // await _apiService.callDutyStatusWSWithJSON(failure['WSRequestJSON']);
        // print(
        //     "WSName: ${failure['WSName']}, WSRequestJSON: ${failure['WSRequestJSON']}");
     // }
    }
  }

  static getIsForground() {
    if (Platform.isIOS) {
      return true;
    }
    return false;
    }

  static void relaunch(ServiceInstance service) {
    final timeInBackground = DateTime.now().difference(lastActiveTime);
    int min = timeInBackground.inMinutes;
    String status = Glob().getAppStatus();
    if (status == "bg" &&  min>= 2) {
      //service.invoke("bringToForeground");
    // FlutterForegroundTask.launchApp();
    }
  }

  static Future<void> clearPgn() async {
     if(device != null) {
       List<BluetoothService> services = await device!.discoverServices();
       final data = [
         ['0x000000', 'd6cfba4f-e0ce-4bef-87e6-5d821a6416b8'],
       ];
       int delay = 0; // initial delay in milliseconds
       for (var entry in data) {
         final value = entry[0];
         final uuid = entry[1];
         Future.delayed(Duration(milliseconds: delay), () {
          // writeStringToHub(services, value, uuid, true);
         });
         delay += 10000; // increase by 10 seconds for next call
       }
     }
  }

}
class Glob {
  static Glob? _instance; // Make it nullable
  factory Glob() => _instance ??= Glob._();
  Glob._();
  String appStatus = 'bg';

  String getAppStatus() {
    return appStatus;
  }
}
