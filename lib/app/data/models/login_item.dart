// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';



Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  bool result;
  String message;
  List<LoginData> data;

  Login({
    required this.result,
    required this.message,
    required this.data,
  });
  // json?["LoggedInTeamDriver"] != null?json["LoggedInTeamDriver"]:"",
  factory Login.fromJson(Map<String, dynamic> json) => Login(
    result: json["Result"],
    message: json["Message"],
    data: List<LoginData>.from(json["Data"].map((x) => LoginData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Result": result,
    "Message": message,
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class LoginData {
  String orgName;
  String guid;
  String vin;
  String odoMeter;
  int driverId;
  String driverName;
  String vehicleNo;
  String vehicleId;
  dynamic dutyStatusId;
  String role;
  String carrier;
  String license;
  String lastLogoutDate;
  String dutyStartTime;
  String dutyEndTime;
  int dutyStatus;
  String companyName;
  String maniFestNumber;
  String aid;
  String webSiteUrl;
  String privacyUrl;
  String legalUrl;
  String contactUrl;
  int cycleId;
  String timeZone;
  String credle;
  String vLink;
  String trailer;
  String isDriverOnPc;
  String pcStartTime;
  String isDriverOnYardMove;
  String yardMoveStartTime;
  String yardMoveStartLocation;
  dynamic error;
  bool isStripchartAvailable;
  bool isMapNavigationAvailable;
  List<OpenViolation>? openViolations;
  bool isTeamDriverLoggedin;
  dynamic loggedInTeamDriver;
  String maniFestStatus;
  int maniFestStatusId;
  int maniFestId;
  String isXcom5GAssigned;
  String isXsen5GAssigned;
  String xcom5GId;

  LoginData({
    required this.orgName,
    required this.guid,
    required this.vin,
    required this.odoMeter,
    required this.driverId,
    required this.driverName,
    required this.vehicleNo,
    required this.vehicleId,
    required this.dutyStatusId,
    required this.role,
    required this.carrier,
    required this.license,
    required this.lastLogoutDate,
    required this.dutyStartTime,
    required this.dutyEndTime,
    required this.dutyStatus,
    required this.companyName,
    required this.maniFestNumber,
    required this.aid,
    required this.webSiteUrl,
    required this.privacyUrl,
    required this.legalUrl,
    required this.contactUrl,
    required this.cycleId,
    required this.timeZone,
    required this.credle,
    required this.vLink,
    required this.trailer,
    required this.isDriverOnPc,
    required this.pcStartTime,
    required this.isDriverOnYardMove,
    required this.yardMoveStartTime,
    required this.yardMoveStartLocation,
    required this.error,
    required this.isStripchartAvailable,
    required this.isMapNavigationAvailable,
    required this.openViolations,
    required this.isTeamDriverLoggedin,
    required this.loggedInTeamDriver,
    required this.maniFestStatus,
    required this.maniFestStatusId,
    required this.maniFestId,
    required this.isXcom5GAssigned,
    required this.isXsen5GAssigned,
    required this.xcom5GId,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
    orgName: json["OrgName"],
    guid: json["Guid"],
    vin: json["VIN"],
    odoMeter: json["ODOMeter"],
    driverId: json["DriverId"],
    driverName: json["DriverName"],
    vehicleNo: json["VehicleNo"],
    vehicleId: json["VehicleId"],
    dutyStatusId: json["DutyStatusId"],
    role: json["Role"],
    carrier: json["Carrier"],
    license: json["License"],
    lastLogoutDate: json["LastLogoutDate"],
    dutyStartTime: json["DutyStartTime"],
    dutyEndTime: json["DutyEndTime"],
    dutyStatus: json["DutyStatus"],
    companyName: json["CompanyName"],
    maniFestNumber: json.containsKey("ManiFestNumber")? json["ManiFestNumber"]:"",
    aid: json["AID"],
    webSiteUrl: json["WebSiteURL"],
    privacyUrl: json["PrivacyURL"],
    legalUrl: json["LegalURL"],
    contactUrl: json["ContactURL"],
    cycleId: json["CycleId"],
    timeZone: json["TimeZone"],
    credle: json["Credle"],
    vLink: json["VLink"],
    trailer: json["Trailer"],
    isDriverOnPc: json["IsDriverOnPC"],
    pcStartTime: json["PcStartTime"],
    isDriverOnYardMove: json["IsDriverOnYardMove"],
    yardMoveStartTime: json["YardMoveStartTime"],
    yardMoveStartLocation: json["YardMoveStartLocation"],
    error: json["Error"],
    isStripchartAvailable: json["IsStripchartAvailable"],
    isMapNavigationAvailable: json["IsMapNavigationAvailable"],
    openViolations: json["OpenViolations"] == null ? [] : List<OpenViolation>.from(json["OpenViolations"]!.map((x) => OpenViolation.fromJson(x))),
    isTeamDriverLoggedin: json["IsTeamDriverLoggedin"],
    loggedInTeamDriver: json?["LoggedInTeamDriver"] != null?json["LoggedInTeamDriver"]:"",
    maniFestStatus: json?["ManiFestStatus"] != null?json["ManiFestStatus"]:"",
    maniFestStatusId: json["ManiFestStatusId"],
    maniFestId: json["ManiFestId"],
    isXcom5GAssigned: json["IsXCOM5gAssigned"],
    isXsen5GAssigned: json["IsXSEN5gAssigned"],
    xcom5GId: json["XCOM5G_id"],
  );
//  equModelDetails: json?["equ_model_details"]!=null?EquModelDetails.fromJson(json?["equ_model_details"]):EquModelDetails(id: '', userId: '', equipmentTypeId: '', modelName: '', price: '', durationType: '', description: '', status: true, image: [], specificationDetails: SpecificationDetailsAll(capacity: 'abc'), createdAt: DateTime(0), updatedAt: DateTime(0), v: 0, accept: false),

  Map<String, dynamic> toJson() => {
    "OrgName": orgName,
    "Guid": guid,
    "VIN": vin,
    "ODOMeter": odoMeter,
    "DriverId": driverId,
    "DriverName": driverName,
    "VehicleNo": vehicleNo,
    "VehicleId": vehicleId,
    "DutyStatusId": dutyStatusId,
    "Role": role,
    "Carrier": carrier,
    "License": license,
    "LastLogoutDate": lastLogoutDate,
    "DutyStartTime": dutyStartTime,
    "DutyEndTime": dutyEndTime,
    "DutyStatus": dutyStatus,
    "CompanyName": companyName,
    "ManiFestNumber": maniFestNumber,
    "AID": aid,
    "WebSiteURL": webSiteUrl,
    "PrivacyURL": privacyUrl,
    "LegalURL": legalUrl,
    "ContactURL": contactUrl,
    "CycleId": cycleId,
    "TimeZone": timeZone,
    "Credle": credle,
    "VLink": vLink,
    "Trailer": trailer,
    "IsDriverOnPC": isDriverOnPc,
    "PcStartTime": pcStartTime,
    "IsDriverOnYardMove": isDriverOnYardMove,
    "YardMoveStartTime": yardMoveStartTime,
    "YardMoveStartLocation": yardMoveStartLocation,
    "Error": error,
    "IsStripchartAvailable": isStripchartAvailable,
    "IsMapNavigationAvailable": isMapNavigationAvailable,
    "OpenViolations": openViolations == null ? [] : List<dynamic>.from(openViolations!.map((x) => x.toJson())),
    "IsTeamDriverLoggedin": isTeamDriverLoggedin,
    "LoggedInTeamDriver": loggedInTeamDriver,
    "ManiFestStatus": maniFestStatus,
    "ManiFestStatusId": maniFestStatusId,
    "ManiFestId": maniFestId,
    "IsXCOM5gAssigned": isXcom5GAssigned,
    "IsXSEN5gAssigned": isXsen5GAssigned,
    "XCOM5G_id": xcom5GId,
  };
}

class OpenViolation {
  int violationId;
  int violationCode;

  OpenViolation({
    required this.violationId,
    required this.violationCode,
  });

  factory OpenViolation.fromJson(Map<String, dynamic> json) => OpenViolation(
    violationId: json["ViolationId"],
    violationCode: json["ViolationCode"],
  );

  Map<String, dynamic> toJson() => {
    "ViolationId": violationId,
    "ViolationCode": violationCode,
  };
}
