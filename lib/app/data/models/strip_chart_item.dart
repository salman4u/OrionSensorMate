// To parse this JSON data, do
//
//     final stripChartData = stripChartDataFromJson(jsonString);

import 'dart:convert';

StripChartData stripChartDataFromJson(String str) => StripChartData.fromJson(json.decode(str));

String stripChartDataToJson(StripChartData data) => json.encode(data.toJson());

class StripChartData {
  bool? result;
  String? message;
  Map<String, List<DayModel>>? dayModels;

  StripChartData({
    this.result,
    this.message,
    this.dayModels,
  });

  factory StripChartData.fromJson(Map<String, dynamic> json) => StripChartData(
    result: json["Result"],
    message: json["Message"],
    dayModels: Map.from(json["DayModels"]!).map((k, v) => MapEntry<String, List<DayModel>>(k, List<DayModel>.from(v.map((x) => DayModel.fromJson(x))))),
  );

  Map<String, dynamic> toJson() => {
    "Result": result,
    "Message": message,
    "DayModels": Map.from(dayModels!).map((k, v) => MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x.toJson())))),
  };
}

class DayModel {
  String? startTime;
  String? dutyStatus;
  String? duration;
  String? isPc;
  bool? break30Min;
  String? location;
  String? note;
  String? odoMeter;
  String? engineHours;
  String? yardMove;
  int? id;
  int? estimatedOdometer;
  String? originalDutyStatus;
  DateTime? createdTime;
  DateTime? updatedOn;
  bool? isEditedByDriver;
  bool? isPreTrip;
  bool? is16Hrs;

  DayModel({
    this.startTime,
    this.dutyStatus,
    this.duration,
    this.isPc,
    this.break30Min,
    this.location,
    this.note,
    this.odoMeter,
    this.engineHours,
    this.yardMove,
    this.id,
    this.estimatedOdometer,
    this.originalDutyStatus,
    this.createdTime,
    this.updatedOn,
    this.isEditedByDriver,
    this.isPreTrip,
    this.is16Hrs,
  });

  factory DayModel.fromJson(Map<String, dynamic> json) => DayModel(
    startTime: json["StartTime"],
    dutyStatus: json["DutyStatus"],
    duration: json["Duration"],
    isPc: json["IsPc"],
    break30Min: json["Break30Min"],
    location: json["Location"],
    note: json["Note"] == null ? "" :json["Note"]!,
    odoMeter: json["OdoMeter"],
    engineHours: json["EngineHours"],
    yardMove: json["YardMove"],
    id: json["Id"],
    estimatedOdometer: json["EstimatedOdometer"],
    originalDutyStatus: json["OriginalDutyStatus"],
    createdTime: json["CreatedTime"] == null ? null : DateTime.parse(json["CreatedTime"]),
    updatedOn: json["UpdatedOn"] == null ? null : DateTime.parse(json["UpdatedOn"]),
    isEditedByDriver: json["IsEditedByDriver"],
    isPreTrip: json["IsPreTrip"],
    is16Hrs: json["Is16Hrs"],
  );

  Map<String, dynamic> toJson() => {
    "StartTime": startTime,
    "DutyStatus": dutyStatus,
    "Duration": duration,
    "IsPc": isPc,
    "Break30Min": break30Min,
    "Location": location,
    "Note": noteValues.reverse[note],
    "OdoMeter": odoMeter,
    "EngineHours": engineHours,
    "YardMove": yardMove,
    "Id": id,
    "EstimatedOdometer": estimatedOdometer,
    "OriginalDutyStatus": originalDutyStatus,
    "CreatedTime": createdTime?.toIso8601String(),
    "UpdatedOn": updatedOn?.toIso8601String(),
    "IsEditedByDriver": isEditedByDriver,
    "IsPreTrip": isPreTrip,
    "Is16Hrs": is16Hrs,
  };
}

enum Note {
  DVIR_TEST02_ODO_565_MILES,
  EMPTY
}

final noteValues = EnumValues({
  "DVIR TEST02, odo 565 miles": Note.DVIR_TEST02_ODO_565_MILES,
  "": Note.EMPTY
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
