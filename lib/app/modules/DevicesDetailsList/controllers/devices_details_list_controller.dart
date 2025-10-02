import 'package:get/get.dart';
import 'package:sensor_mate/app/data/local/my_shared_pref.dart';
import '../../../components/api_service.dart';
import '../../../data/database/HubDatabase.dart';
import '../../../data/models/Hub.dart';
import '../../../data/models/login_response.dart';


class DevicesDetailsListController extends GetxController {
  var deviceList = <Device>[].obs;
  var selectedFilter = 'All'.obs;
  var deviceType = ''.obs;
  var buttonLabel = 'Remove'.obs;
  var isActive = false.obs;
  final ApiService api = ApiService();

  RxString eldSerialNumber = ''.obs;
  var hubList = <Hub>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    var argumentData = Get.arguments;
    if (argumentData != null) {
      deviceType.value = argumentData['sensor'] ?? '';
    }

    if (deviceType.value == 'XSEN5G') {
      buttonLabel.value = 'Configure';
    }
    eldSerialNumber.value = await MySharedPref.getEldSerialNumber();
    loadDevicesFromApi();
    loadHubs();
  }

  Future<void> loadHubs() async {
    final db = HubDatabase.instance;
    List<Hub> hubs = await db.getHubs();

    hubList.assignAll(hubs);
  }
  Future<void> loadDevicesFromApi() async {
    LoginResponse? savedData = await api.getSavedLoginData();
    const orgName = "OFE";
    final guid = savedData!.guid;
    final vehicleId = savedData!.vehicleId;
    final devices =
    await api.getCradlesCanHubList(orgName: orgName, guid: guid, vehicleId: vehicleId);
    deviceList.value = devices;
  }

  void filterDevices(String filter) {
    selectedFilter.value = filter;
  }
}

class Device {
  final String hubId;
  final String hubTD;
  final String hubName;
  final String hubType;
  final String status = 'Active';
  final String id = '123456789';
  final String model = 'XSEN5G';

  Device({
    required this.hubId,
    required this.hubTD,
    required this.hubName,
    required this.hubType,
  });

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      hubId: json["HubId"] ?? "",
      hubTD: json["HubTD"] ?? "",
      hubName: json["Hubname"] ?? "",
      hubType: json["HubType"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "HubId": hubId,
    "HubTD": hubTD,
    "Hubname": hubName,
    "HubType": hubType,
  };
}

