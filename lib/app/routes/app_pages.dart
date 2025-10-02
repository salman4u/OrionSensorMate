import 'package:get/get.dart';
import 'package:sensor_mate/app/modules/SensorSettings/views/sensor_settings_view.dart';
import 'package:sensor_mate/app/modules/Webview/bindings/webview_binding.dart';
import 'package:sensor_mate/app/modules/edit_pgn/bindings/edit_pgn_binding.dart';
import 'package:sensor_mate/app/modules/edit_pgn/views/edit_pgn_view.dart';

import '../modules/AddAddress/bindings/add_address_binding.dart';
import '../modules/AddAddress/views/add_address_view.dart';
import '../modules/DevicesDetailsList/bindings/devices_details_list_binding.dart';
import '../modules/DevicesDetailsList/views/devices_details_list_view.dart';
import '../modules/InVehicle/bindings/in_vehicle_binding.dart';
import '../modules/InVehicle/views/in_vehicle_view.dart';
import '../modules/MyDevices/bindings/my_devices_binding.dart';
import '../modules/MyDevices/views/my_devices_view.dart';
import '../modules/OrderSummary/bindings/order_summary_binding.dart';
import '../modules/OrderSummary/views/order_summary_view.dart';
import '../modules/PairSensorDevice/bindings/pair_sensor_device_binding.dart';
import '../modules/PairSensorDevice/views/pair_sensor_device_view.dart';
import '../modules/Permission/bindings/permission_binding.dart';
import '../modules/Permission/views/permission_view.dart';
import '../modules/Register/bindings/register_binding.dart';
import '../modules/Register/views/register_view.dart';
import '../modules/RegisterDevice/bindings/register_device_binding.dart';
import '../modules/RegisterDevice/views/register_device_view.dart';
import '../modules/RegisterDeviceManually/bindings/register_device_manually_binding.dart';
import '../modules/RegisterDeviceManually/views/register_device_manually_view.dart';
import '../modules/RegisterXCOM5GC/bindings/register_x_c_o_m5_g_c_binding.dart';
import '../modules/RegisterXCOM5GC/views/register_x_c_o_m5_g_c_view.dart';
import '../modules/SensorList/bindings/sensor_list_binding.dart';
import '../modules/SensorList/views/sensor_list_view.dart';
import '../modules/SensorSettings/bindings/sensor_settings_binding.dart';
import '../modules/Webview/views/webview_view.dart';
import '../modules/about/bindings/about_binding.dart';
import '../modules/about/views/about_view.dart';
import '../modules/cartDetails/bindings/cart_details_binding.dart';
import '../modules/cartDetails/views/cart_details_view.dart';
import '../modules/deliveryAddress/bindings/delivery_address_binding.dart';
import '../modules/deliveryAddress/views/delivery_address_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/sensorDetails/bindings/sensor_details_binding.dart';
import '../modules/sensorDetails/views/sensor_details_view.dart';
import '../modules/store/bindings/store_binding.dart';
import '../modules/store/views/store_view.dart';
import '../modules/welcome/bindings/welcome_binding.dart';
import '../modules/welcome/views/welcome_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.WELCOME;
  static const LOGIN = Routes.LOGIN;
  static const SENSOR_LIST = Routes.SENSOR_LIST;
  static const REGISTER_DEVICE = Routes.REGISTER_DEVICE;
  static const REGISTER_DEVICE_MNUALLY = Routes.REGISTER_DEVICE_MANUALLY;
  static const MY_DEVICES = Routes.MY_DEVICES;
  static const DEVICES_DETAILS_LIST = Routes.DEVICES_DETAILS_LIST;
  static const PAIR_SENSOR_DEVICE = Routes.PAIR_SENSOR_DEVICE;
  static const IN_VEHICLE = Routes.IN_VEHICLE;
  static const ABOUT = Routes.ABOUT;
  static const PROFILE = Routes.PROFILE;
  static const STORE = Routes.STORE;
  static const SENSOR_DETAILS = Routes.SENSOR_DETAILS;
  static const CART_DETAILS = Routes.CART_DETAILS;
  static const DELIVERY_ADDRESS = Routes.DELIVERY_ADDRESS;
  static const ORDER_SUMMARY = Routes.ORDER_SUMMARY;
  static const ADD_ADDRESS = Routes.ADD_ADDRESS;
  static const REGISTER_X_C_O_M5_G_C = Routes.REGISTER_X_C_O_M5_G_C;
  static const HOME = Routes.HOME;
  static const REGISTER = Routes.REGISTER;
  static const EDIT_PGN = Routes.EDIT_PGN;
  static const SENSOR_SETTINGS = Routes.SENSOR_SETTINGS;
  static const WEBVIEW = Routes.WEBVIEW;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.WELCOME,
      page: () => const WelcomeView(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: _Paths.PERMISSION,
      page: () => const PermissionView(),
      binding: PermissionBinding(),
    ),
    GetPage(
      name: _Paths.SENSOR_LIST,
      page: () => SensorListView(),
      binding: SensorListBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER_DEVICE,
      page: () => RegisterDeviceView(),
      binding: RegisterDeviceBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER_DEVICE_MANUALLY,
      page: () => RegisterDeviceManuallyView(),
      binding: RegisterDeviceManuallyBinding(),
    ),
    GetPage(
      name: _Paths.MY_DEVICES,
      page: () => MyDevicesView(),
      binding: MyDevicesBinding(),
    ),
    GetPage(
      name: _Paths.DEVICES_DETAILS_LIST,
      page: () => DevicesDetailsListView(),
      binding: DevicesDetailsListBinding(),
    ),
    GetPage(
      name: _Paths.PAIR_SENSOR_DEVICE,
      page: () => PairSensorDeviceView(),
      binding: PairSensorDeviceBinding(),
    ),
    GetPage(
      name: _Paths.IN_VEHICLE,
      page: () => InVehicleView(),
      binding: InVehicleBinding(),
    ),
    GetPage(
      name: _Paths.ABOUT,
      page: () => const AboutView(),
      binding: AboutBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.STORE,
      page: () => StoreView(),
      binding: StoreBinding(),
    ),
    GetPage(
      name: _Paths.SENSOR_DETAILS,
      page: () => SensorDetailsView(),
      binding: SensorDetailsBinding(),
    ),
    GetPage(
      name: _Paths.CART_DETAILS,
      page: () => CartDetailsView(),
      binding: CartDetailsBinding(),
    ),
    GetPage(
      name: _Paths.DELIVERY_ADDRESS,
      page: () => DeliveryAddressView(),
      binding: DeliveryAddressBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_SUMMARY,
      page: () => OrderSummaryView(),
      binding: OrderSummaryBinding(),
    ),
    GetPage(
      name: _Paths.ADD_ADDRESS,
      page: () => AddAddressView(),
      binding: AddAddressBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER_X_C_O_M5_G_C,
      page: () => RegisterXCOM5GCView(),
      binding: RegisterXCOM5GCBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () =>  RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PGN,
      page: () =>  EditPgnView(),
      binding: EditPgnBinding(),
    ),
    GetPage(
      name: _Paths.SENSOR_SETTINGS,
      page: () =>  SensorSettingsView(),
      binding: SensorSettingsBinding(),
    ),
    GetPage(
      name: _Paths.WEBVIEW,
      page: () =>  WebviewView(),
      binding: WebviewBinding(),
    )
  ];
}

