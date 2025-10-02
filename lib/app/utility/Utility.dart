import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart' hide Response;
import 'package:intl/intl.dart';
import 'package:sensor_mate/app/components/light_theme_colors.dart';

import '../components/ApiUtils.dart';
import '../components/custom_snackbar.dart';
import '../data/local/my_shared_pref.dart';
import '../routes/app_pages.dart';
import 'dart:math';
import 'package:blur/blur.dart';

enum DutyStatus {
  DRIVING,
  ON_DUTY,
  SLEEP,
  OFF_DUTY,
}
final ValueNotifier<String> cycleRemainingTimeNotifier = ValueNotifier<String>('');
 String webURL = ApiUtils.HELP_URL;
 double lastTimeDataInserted = 0;
 // String eldConnectionState = "XCOM5G not connected";
ValueNotifier<String> eldConnectionState = ValueNotifier<String>("Initial Value");
late final Response unDriverVehicleListResponse ;
  double currentOdometerValue = 0;
class Utility{
  static bool isTrailer(String str)
  {
    bool isTrailer = false;
    var words = ["53ft / 16.2m","Trailer (53ft / 16.2m)","trailer (53ft / 16.2m)","trailer (48ft / 14.6m)","Trailer-Semi","REEFER","Reefer","reefer","Trailer", "Reefer (refrigerated)", "reefer (refrigerated)", "trailer", "Dry Van","dry van","DRY VAN","Dry van","dry van","Liftgate","liftgate", "Semi-trailer","semi-trailer","Trailer (48ft / 14.6m)"];
    isTrailer =  words.contains(str);
    return isTrailer;
  }
  static String getStringValueOfDutyStatus(int input) {
    if(input == 1){
      return "Driving";
    }
    else  if(input == 2){
      return "On Duty(Not Driving)";
    }
    else if(input == 3){
      return "Sleeper";
    }
    else if(input == 4){
      return "Off Duty";
    }
    return "Off Duty";
  }
  static DateTime convertToUtcDateTime(String dateTimeString) {
    final dateFormat = DateFormat('M/d/yyyy h:mm:ss a');
    DateTime utcDateTime = dateFormat.parse(dateTimeString);
    //DateTime utcDateTime = localDateTime.toUtc();
    return utcDateTime;
  }

 static void showCustomToast(String message) {
   Fluttertoast.showToast(
       msg: message,
       toastLength: Toast.LENGTH_LONG,
       gravity: ToastGravity.CENTER,
       timeInSecForIosWeb: 1,
       backgroundColor: Colors.red,
       textColor: Colors.white,
       fontSize: 16.0
   );
  }

  static String formatMacAddress(String mac) {
    if (mac.length != 12) return mac.toUpperCase(); // fallback if not 12 chars

    final buffer = StringBuffer();
    for (int i = 0; i < mac.length; i += 2) {
      if (i > 0) buffer.write(':');
      buffer.write(mac.substring(i, i + 2).toUpperCase());
    }
    return buffer.toString();
  }

  void main() {
    String raw = "e465b85eab66";
    String formatted = formatMacAddress(raw);
    print(formatted); // E4:65:B8:5E:AB:66
  }

  static int getTimePassedFromNow(DateTime utcDateTime) {
    String currentDateTime = Utility.getUTCDateTime();
    DateTime now =  Utility.convertToUtcDateTimeDash(currentDateTime);
    Duration difference = now.difference(utcDateTime.toUtc());
    int timePassed = difference.inSeconds;
    return timePassed;
  }
  static String decimalToSwappedHex(int value) {
    // Take low and high byte
    int lowByte = value & 0xFF;
    int highByte = (value >> 8) & 0xFF;

    // Swap order: low byte comes second, high byte comes first
    return lowByte.toRadixString(16).padLeft(2, '0') +
        highByte.toRadixString(16).padLeft(2, '0');
  }


  static String getUTCDateTime(){
    final DateTime now = DateTime.now().toUtc();
    final String formattedDateTime = formatDateTime(now);
    return formattedDateTime;
  }
  static String formatDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return formatter.format(dateTime);
  }
  static DateTime convertToUtcDateTimeDash(String dateTimeString) {
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    DateTime utcDateTime = dateFormat.parse(dateTimeString);
    //DateTime utcDateTime = localDateTime.toUtc();
    return utcDateTime;
  }

  static int getIntValueOfDutyStatus(String input) {
    if(input == "Driving"){
      return 1;
    }
    else  if(input == "On Duty(Not Driving)"){
      return 2;
    }
    else if(input == "Sleeper"){
      return 3;
    }
    else if(input == "Off Duty"){
      return 4;
    }
    return 4;
  }
  static String formatDuration(int totalSeconds) {
    int hours = totalSeconds ~/ 3600;
    int minutes = (totalSeconds % 3600) ~/ 60;
    String hoursStr = hours.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');
    return '$hoursStr:$minutesStr';
  }
  static String formatDurationMinutes(int totalSeconds) {
    totalSeconds = totalSeconds*60;
    int hours = totalSeconds ~/ 3600;
    int minutes = (totalSeconds % 3600) ~/ 60;
    String hoursStr = hours.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');
    return '$hoursStr:$minutesStr';
  }

  static void logout() {
    MySharedPref.clear();
    Get.toNamed(AppPages.LOGIN);
  }
 static Response convertStringToResponse(String responseString) {
    return Response(
      data: responseString,
      requestOptions: RequestOptions(path: ''), // Provide the actual path if needed
      statusCode: 200, // Set the desired status code
      statusMessage: "OK", // Optional status message
    );
  }
  static void showDialogAlert(BuildContext context,String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static double round(double value, int places) {
    if (places < 0) {
      throw ArgumentError("places must be non-negative");
    }
    double factor = pow(10, places).toDouble();
    value = value * factor;
    double tmp = value.roundToDouble();
    return tmp / factor;
  }


  static void showToast(String s) {
    CustomSnackBar.showCustomToast(
      message: s,
      title: 'Notice!',
    );
  }
  static void showErrorToast(String title, String msg) {
    CustomSnackBar.showCustomToast(
      message: title,
      title: msg,
      color: Colors.red
    );
  }
  static String bytesToHex(data) {
    return data.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join('');
  }

  static void showInternetIssue() {
    CustomSnackBar.showCustomErrorSnackBar(
      message: "Check your internet connection",
      title: 'Notice!',
    );
  }
  static void showDeactivateDeviceAlert(BuildContext context,String icon, String title,String text, bool isWarning, {bool isTextLeftAlign = false}) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dialog dismissal by tapping outside
      builder: (BuildContext context) {
        return Stack(
          children: [
            // Blurry background
            Blur(
              blur: 8.0,
              blurColor: Colors.transparent,
              child: Container(color: Colors.transparent),
            ),
            // The alert dialog content
            Center(
              child: Dialog(
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/sensor_details_bg.png'),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 20),
                         Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Row(
                            children: [
                               Image.asset(
                                'assets/images/$icon.png',
                                width: 30,
                                height: 30,
                                color: title.contains("Deactivate")?Colors.white:LightThemeColors.prefixIconColor, // Optional: To apply a tint
                              ),
                              const SizedBox(width: 10),
                              Text(
                                title,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                         Padding(
                          padding: const EdgeInsets.only(left: 60.0,right: 20.0),
                          child: Text(
                            text,
                            textAlign: isTextLeftAlign ? TextAlign.left:TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Cancel button
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // Close the alert
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF4E515B), // Grey color for Cancel
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child:  Padding(
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  child: Text(
                                    getNegativeButtonText(title),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            // OK button
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  // Handle OK action
                                  Navigator.of(context).pop();
                                  if(title.contains('Pairing')){
                                    Utility.showDeactivateDeviceAlert(Get.context as BuildContext,'check_mark_checked','Successfully Assigned','Don\'t forget to configure the sensor data options in XSEN5GC-1234.',true,isTextLeftAlign: true);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: title.contains("Remove")?LightThemeColors.redButtonBackgroundColor:LightThemeColors.loginBtnColor, // Blue color for OK
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child:  Padding(
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  child: Text(
                                    getPositiveButtonText(title),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
  static String getPositiveButtonText(String title) {
    if(title.contains('Successfully Assigned')) {
      return 'Configure';
    }
      return title.contains('Pairing') ? 'PAIR' : 'OK';
  }
  static String getNegativeButtonText(String title) {
    return title.contains('Successfully Assigned') ? 'Later' : 'Cancel';
  }
  static String getStatusInShort(String status) {
    if(status == "Off Duty"){
      return "OF";
    }
    else if (status == "On Duty(Not Driving)"){
      return "ON";
    }
    else if (status == "Driving"){
      return "DR";
    }
    else if (status == "Sleeper"){
      return "SL";
    }
    return "OF";
  }



}
class DutyStatusStr {
  static const String DRIVING = "Driving";
  static const String ON_DUTY = "On Duty";
  static const String SLEEP = "Sleeper";
  static const String OFF_DUTY = "Off Duty";
}