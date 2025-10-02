// To parse this JSON data, do
//
//     final vehicleList = vehicleListFromJson(jsonString);

import 'dart:convert';

VehicleList vehicleListFromJson(String str) => VehicleList.fromJson(json.decode(str));

String vehicleListToJson(VehicleList data) => json.encode(data.toJson());

class VehicleList {
  bool result;
  String message;
  List<VehicleListData> data;

  VehicleList({
    required this.result,
    required this.message,
    required this.data,
  });

  factory VehicleList.fromJson(Map<String, dynamic> json) => VehicleList(
    result: json["Result"],
    message: json["Message"],
    data: List<VehicleListData>.from(json["Data"].map((x) => VehicleListData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Result": result,
    "Message": message,
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class VehicleListData {
  String vehicleId;
  String aid;
  String vehicleType;
  String vehicleName;
  String isManifest;
  String? isVLinkAssigned;
  String? isCanAssigned;
  String licensePlate;
  String vin;
  int isDnl;
  int isSelected;
  bool isTrailer = false;
  String manifestNumber;
  String manifestStatus;
  String driverName;
  String vehicleStatus;
  int isPermanentAssigned;
  String isXcom5GAssigned;
  String isXsen5GAssigned;

  VehicleListData({
    required this.vehicleId,
    required this.aid,
    required this.vehicleType,
    required this.vehicleName,
    required this.isManifest,
    required this.isVLinkAssigned,
    required this.isCanAssigned,
    required this.licensePlate,
    required this.vin,
    required this.isDnl,
    required this.manifestNumber,
    required this.manifestStatus,
    required this.driverName,
    required this.vehicleStatus,
    required this.isPermanentAssigned,
    required this.isXcom5GAssigned,
    required this.isXsen5GAssigned,
    required this.isSelected,
    required bool isTrailer
  });

  factory VehicleListData.fromJson(Map<String, dynamic> json) => VehicleListData(
    vehicleId: json["VehicleId"],
    aid: json["AID"],
    vehicleType: json["VehicleType"],
    vehicleName: json["VehicleName"],
    isManifest: json["IsManifest"],
    isVLinkAssigned: json["IsVLinkAssigned"],
    isCanAssigned: json["IsCanAssigned"],
    licensePlate: json["LicensePlate"],
    vin: json["VIN"],
    isDnl: json["IsDnl"],
    manifestNumber: json["ManifestNumber"] ?? "",
    manifestStatus: json["ManifestStatus"] ?? "",
    driverName: json["DriverName"],
    vehicleStatus: json["VehicleStatus"],
    isPermanentAssigned: json["IsPermanentAssigned"],
    isXcom5GAssigned: json["IsXCOM5gAssigned"],
    isXsen5GAssigned: json["IsXSEN5gAssigned"],
    isSelected: 0,
    isTrailer:false
  );

  Map<String, dynamic> toJson() => {
    "VehicleId": vehicleId,
    "AID": aid,
    "VehicleType": vehicleType,
    "VehicleName": vehicleName,
    "IsManifest": isManifest,
    "IsVLinkAssigned": isVLinkAssigned,
    "IsCanAssigned": isCanAssigned,
    "LicensePlate": licensePlate,
    "VIN": vin,
    "IsDnl": isDnl,
    "ManifestNumber": manifestNumber,
    "ManifestStatus": manifestStatus,
    "DriverName": driverName,
    "VehicleStatus": vehicleStatus,
    "IsPermanentAssigned": isPermanentAssigned,
    "IsXCOM5gAssigned": isXcom5GAssigned,
    "IsXSEN5gAssigned": isXsen5GAssigned,
  };
}
