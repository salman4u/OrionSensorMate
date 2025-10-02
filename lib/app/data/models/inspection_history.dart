// To parse this JSON data, do
//
//     final inspectionHistory = inspectionHistoryFromJson(jsonString);

import 'dart:convert';

InspectionHistory inspectionHistoryFromJson(String str) => InspectionHistory.fromJson(json.decode(str));

String inspectionHistoryToJson(InspectionHistory data) => json.encode(data.toJson());

class InspectionHistory {
  bool success;
  List<Inspection> inspections;
  String message;

  InspectionHistory({
    required this.success,
    required this.inspections,
    required this.message,
  });

  factory InspectionHistory.fromJson(Map<String, dynamic> json) => InspectionHistory(
    success: json["success"],
    inspections: List<Inspection>.from(json["inspections"].map((x) => Inspection.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "inspections": List<dynamic>.from(inspections.map((x) => x.toJson())),
    "message": message,
  };
}

class Inspection {
  int inspectionId;
  String vehicleId;
  String vehicleName;
  dynamic licensePlate;
  double odometer;
  int fhwa;
  String fhwaStatus;
  int ifta;
  String iftaStatus;
  int nje;
  String njeStatus;
  String tugTest;
  String driverQuestions;
  int cameraCondition;
  String cameraCondition1;
  String freshDamage;
  int lights;
  String lightsStatus;
  int tirePressure;
  String tirePressureStatus;
  int tireTread;
  String tireTreadStatus;
  int trailerAirLines;
  String trailerAirLinesStatus;
  int airLeaks;
  String airLeaksStatus;
  int vehicleStatusId;
  String vehicleStatus;
  String inspectionDate;

  String inspectionDoneBy;
  int registration;
  String registrationStatus;
  int inspectionType;
  String inspectionTypeStatus;
  int vehicleType;
  String vehicleTypeStatus;

  Inspection({
    required this.inspectionId,
    required this.vehicleId,
    required this.vehicleName,
    required this.licensePlate,
    required this.odometer,
    required this.fhwa,
    required this.fhwaStatus,
    required this.ifta,
    required this.iftaStatus,
    required this.nje,
    required this.njeStatus,
    required this.tugTest,
    required this.driverQuestions,
    required this.cameraCondition,
    required this.cameraCondition1,
    required this.freshDamage,
    required this.lights,
    required this.lightsStatus,
    required this.tirePressure,
    required this.tirePressureStatus,
    required this.tireTread,
    required this.tireTreadStatus,
    required this.trailerAirLines,
    required this.trailerAirLinesStatus,
    required this.airLeaks,
    required this.airLeaksStatus,
    required this.vehicleStatusId,
    required this.vehicleStatus,
    required this.inspectionDate,
    required this.inspectionDoneBy,
    required this.registration,
    required this.registrationStatus,
    required this.inspectionType,
    required this.inspectionTypeStatus,
    required this.vehicleType,
    required this.vehicleTypeStatus,
  });

  factory Inspection.fromJson(Map<String, dynamic> json) => Inspection(
    inspectionId: json["InspectionId"],
    vehicleId: json["VehicleId"],
    vehicleName: json["VehicleName"],
    licensePlate: json["LicensePlate"],
    odometer: json["Odometer"]?.toDouble(),
    fhwa: json["Fhwa"],
    fhwaStatus: json["FhwaStatus"],
    ifta: json["Ifta"],
    iftaStatus: json["IftaStatus"],
    nje: json["Nje"],
    njeStatus: json["NjeStatus"],
    tugTest: json["TugTest"],
    driverQuestions: json["DriverQuestions"],
    cameraCondition: json["CameraCondition"],
    cameraCondition1: json["CameraCondition1"],
    freshDamage: json["FreshDamage"],
    lights: json["Lights"],
    lightsStatus: json["LightsStatus"],
    tirePressure: json["TirePressure"],
    tirePressureStatus: json["TirePressureStatus"],
    tireTread: json["TireTread"],
    tireTreadStatus: json["TireTreadStatus"],
    trailerAirLines: json["TrailerAirLines"],
    trailerAirLinesStatus: json["TrailerAirLinesStatus"],
    airLeaks: json["AirLeaks"],
    airLeaksStatus: json["AirLeaksStatus"],
    vehicleStatusId: json["VehicleStatusId"],
    vehicleStatus: json["VehicleStatus"],
    inspectionDate: json["InspectionDate"],
    inspectionDoneBy: json["InspectionDoneBy"],
    registration: json["Registration"],
    registrationStatus: json["RegistrationStatus"],
    inspectionType: json["InspectionType"],
    inspectionTypeStatus: json["InspectionTypeStatus"],
    vehicleType: json["VehicleType"],
    vehicleTypeStatus: json.containsKey("VehicleTypeStatus")?json["VehicleTypeStatus"]:"",
  );

  Map<String, dynamic> toJson() => {
    "InspectionId": inspectionId,
    "VehicleId": vehicleId,
    "VehicleName": vehicleName,
    "LicensePlate": licensePlate,
    "Odometer": odometer,
    "Fhwa": fhwa,
    "FhwaStatus": fhwaStatus,
    "Ifta": ifta,
    "IftaStatus": iftaStatus,
    "Nje": nje,
    "NjeStatus": njeStatus,
    "TugTest": tugTest,
    "DriverQuestions": driverQuestions,
    "CameraCondition": cameraCondition,
    "CameraCondition1": cameraCondition1,
    "FreshDamage": freshDamage,
    "Lights": lights,
    "LightsStatus": lightsStatus,
    "TirePressure": tirePressure,
    "TirePressureStatus": tirePressureStatus,
    "TireTread": tireTread,
    "TireTreadStatus": tireTreadStatus,
    "TrailerAirLines": trailerAirLines,
    "TrailerAirLinesStatus": trailerAirLinesStatus,
    "AirLeaks": airLeaks,
    "AirLeaksStatus": airLeaksStatus,
    "VehicleStatusId": vehicleStatusId,
    "VehicleStatus": vehicleStatus,
    "InspectionDate":inspectionDate,
    "InspectionDoneBy": inspectionDoneBy,
    "Registration": registration,
    "RegistrationStatus": registrationStatus,
    "InspectionType": inspectionType,
    "InspectionTypeStatus": inspectionTypeStatus,
    "VehicleType": vehicleType,
    "VehicleTypeStatus": vehicleTypeStatus,
  };
}

class LicensePlateClass {
  LicensePlateClass();

  factory LicensePlateClass.fromJson(Map<String, dynamic> json) => LicensePlateClass(
  );

  Map<String, dynamic> toJson() => {
  };
}
