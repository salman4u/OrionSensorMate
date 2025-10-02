// To parse this JSON data, do
//
//     final days14DutyStatusDetails = days14DutyStatusDetailsFromJson(jsonString);

import 'dart:convert';

Days14DutyStatusDetails days14DutyStatusDetailsFromJson(String str) => Days14DutyStatusDetails.fromJson(json.decode(str));

String days14DutyStatusDetailsToJson(Days14DutyStatusDetails data) => json.encode(data.toJson());

class Days14DutyStatusDetails {
  bool? result;
  String? message;
  List<Datum>? data;

  Days14DutyStatusDetails({
    this.result,
    this.message,
    this.data,
  });

  factory Days14DutyStatusDetails.fromJson(Map<String, dynamic> json) => Days14DutyStatusDetails(
    result: json["Result"],
    message: json["Message"],
    data: json["Data"] == null ? [] : List<Datum>.from(json["Data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Result": result,
    "Message": message,
    "Data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? date;
  String? driveTime;
  String? notDriveTime;
  String? distance;
  String? location;
  bool? violation;
  String? odoMeter;
  String? engineHours;
  String? tractorAid;
  String? trailerAid;
  DateTime? driveDate;

  Datum({
    this.date,
    this.driveTime,
    this.notDriveTime,
    this.distance,
    this.location,
    this.violation,
    this.odoMeter,
    this.engineHours,
    this.tractorAid,
    this.trailerAid,
    this.driveDate,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    date: json["Date"],
    driveTime: json["DriveTime"],
    notDriveTime: json["NotDriveTime"],
    distance: json["Distance"],
    location: json["Location"],
    violation: json["Violation"],
    odoMeter: json["OdoMeter"],
    engineHours: json["EngineHours"],
    tractorAid: json["TractorAID"],
    trailerAid: json["TrailerAID"],
    driveDate: json["DriveDate"] == null ? null : DateTime.parse(json["DriveDate"]),
  );

  Map<String, dynamic> toJson() => {
    "Date": date,
    "DriveTime": driveTime,
    "NotDriveTime": notDriveTime,
    "Distance": distance,
    "Location": location,
    "Violation": violation,
    "OdoMeter": odoMeter,
    "EngineHours": engineHours,
    "TractorAID": tractorAid,
    "TrailerAID": trailerAid,
    "DriveDate": driveDate?.toIso8601String(),
  };
}
