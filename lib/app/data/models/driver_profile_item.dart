// To parse this JSON data, do
//
//     final driverProfileDetails = driverProfileDetailsFromJson(jsonString);

import 'dart:convert';

DriverProfileDetails driverProfileDetailsFromJson(String str) => DriverProfileDetails.fromJson(json.decode(str));

String driverProfileDetailsToJson(DriverProfileDetails data) => json.encode(data.toJson());

class DriverProfileDetails {
  bool? result;
  String? message;
  List<Datum>? data;
  DriverLicense? driverLicense;

  DriverProfileDetails({
    this.result,
    this.message,
    this.data,
    this.driverLicense,
  });

  factory DriverProfileDetails.fromJson(Map<String, dynamic> json) => DriverProfileDetails(
    result: json["Result"],
    message: json["Message"],
    data: json["Data"] == null ? [] : List<Datum>.from(json["Data"]!.map((x) => Datum.fromJson(x))),
    driverLicense: json["DriverLicense"] == null ? null : DriverLicense.fromJson(json["DriverLicense"]),
  );

  Map<String, dynamic> toJson() => {
    "Result": result,
    "Message": message,
    "Data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "DriverLicense": driverLicense?.toJson(),
  };
}

class Datum {
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? licenceNumber;
  String? licenceIssuedDate;
  String? usdo;
  String? dutyCycle;
  String? homeTimeZone;
  int? isVehiclePropertyType;
  bool? is30MinutsExceptions;
  bool? is24HourExceptions;
  bool? isOilfieldExceptions;
  bool? is100AirMileExceptions;
  bool? isMotionPictureExceptions;
  bool? is16HourExceptions;
  bool? isVehicleMoreThan500Gallons;
  bool? is150AirMile;
  bool? isOilfieldWaitingTime;
  bool? isRequireApprovalForCarrierEdits;
  int? driverId;
  String? state;
  String? signatureUrl;

  Datum({
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.licenceNumber,
    this.licenceIssuedDate,
    this.usdo,
    this.dutyCycle,
    this.homeTimeZone,
    this.isVehiclePropertyType,
    this.is30MinutsExceptions,
    this.is24HourExceptions,
    this.isOilfieldExceptions,
    this.is100AirMileExceptions,
    this.isMotionPictureExceptions,
    this.is16HourExceptions,
    this.isVehicleMoreThan500Gallons,
    this.is150AirMile,
    this.isOilfieldWaitingTime,
    this.isRequireApprovalForCarrierEdits,
    this.driverId,
    this.state,
    this.signatureUrl,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    firstName: json["FirstName"],
    lastName: json["LastName"],
    email: json["Email"],
    phoneNumber: json["PhoneNumber"],
    licenceNumber: json["LicenceNumber"],
    licenceIssuedDate: json["LicenceIssuedDate"],
    usdo: json["USDO"],
    dutyCycle: json["DutyCycle"],
    homeTimeZone: json["HomeTimeZone"],
    isVehiclePropertyType: json["IsVehiclePropertyType"],
    is30MinutsExceptions: json["Is30MinutsExceptions"],
    is24HourExceptions: json["Is24HourExceptions"],
    isOilfieldExceptions: json["IsOilfieldExceptions"],
    is100AirMileExceptions: json["Is100AirMileExceptions"],
    isMotionPictureExceptions: json["IsMotionPictureExceptions"],
    is16HourExceptions: json["Is16HourExceptions"],
    isVehicleMoreThan500Gallons: json["IsVehicleMoreThan500Gallons"],
    is150AirMile: json["Is150AirMile"],
    isOilfieldWaitingTime: json["IsOilfieldWaitingTime"],
    isRequireApprovalForCarrierEdits: json["IsRequireApprovalForCarrierEdits"],
    driverId: json["DriverId"],
    state: json["State"],
    signatureUrl: json["SignatureUrl"],
  );

  Map<String, dynamic> toJson() => {
    "FirstName": firstName,
    "LastName": lastName,
    "Email": email,
    "PhoneNumber": phoneNumber,
    "LicenceNumber": licenceNumber,
    "LicenceIssuedDate": licenceIssuedDate,
    "USDO": usdo,
    "DutyCycle": dutyCycle,
    "HomeTimeZone": homeTimeZone,
    "IsVehiclePropertyType": isVehiclePropertyType,
    "Is30MinutsExceptions": is30MinutsExceptions,
    "Is24HourExceptions": is24HourExceptions,
    "IsOilfieldExceptions": isOilfieldExceptions,
    "Is100AirMileExceptions": is100AirMileExceptions,
    "IsMotionPictureExceptions": isMotionPictureExceptions,
    "Is16HourExceptions": is16HourExceptions,
    "IsVehicleMoreThan500Gallons": isVehicleMoreThan500Gallons,
    "Is150AirMile": is150AirMile,
    "IsOilfieldWaitingTime": isOilfieldWaitingTime,
    "IsRequireApprovalForCarrierEdits": isRequireApprovalForCarrierEdits,
    "DriverId": driverId,
    "State": state,
    "SignatureUrl": signatureUrl,
  };
}

class DriverLicense {
  int? id;
  int? driverId;
  String? licenseTypeId;
  dynamic licenseType;
  String? licenseNumber;
  dynamic countryIssued;
  String? state;
  String? country;
  DateTime? issuedDate;
  DateTime? expiredDate;

  DriverLicense({
    this.id,
    this.driverId,
    this.licenseTypeId,
    this.licenseType,
    this.licenseNumber,
    this.countryIssued,
    this.state,
    this.country,
    this.issuedDate,
    this.expiredDate,
  });

  factory DriverLicense.fromJson(Map<String, dynamic> json) => DriverLicense(
    id: json["Id"],
    driverId: json["DriverId"],
    licenseTypeId: json["LicenseTypeId"],
    licenseType: json["LicenseType"],
    licenseNumber: json["LicenseNumber"],
    countryIssued: json["CountryIssued"],
    state: json["State"],
    country: json["Country"],
    issuedDate: json["IssuedDate"] == null ? null : DateTime.parse(json["IssuedDate"]),
    expiredDate: json["ExpiredDate"] == null ? null : DateTime.parse(json["ExpiredDate"]),
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "DriverId": driverId,
    "LicenseTypeId": licenseTypeId,
    "LicenseType": licenseType,
    "LicenseNumber": licenseNumber,
    "CountryIssued": countryIssued,
    "State": state,
    "Country": country,
    "IssuedDate": issuedDate?.toIso8601String(),
    "ExpiredDate": expiredDate?.toIso8601String(),
  };
}
