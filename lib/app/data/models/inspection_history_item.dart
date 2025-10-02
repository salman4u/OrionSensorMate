// To parse this JSON data, do
//
//     final inspectionHistoryData = inspectionHistoryDataFromJson(jsonString);

import 'dart:convert';

InspectionHistoryData inspectionHistoryDataFromJson(String str) => InspectionHistoryData.fromJson(json.decode(str));

String inspectionHistoryDataToJson(InspectionHistoryData data) => json.encode(data.toJson());

class InspectionHistoryData {
  bool? result;
  String? message;
  List<Datum>? data;

  InspectionHistoryData({
    this.result,
    this.message,
    this.data,
  });

  factory InspectionHistoryData.fromJson(Map<String, dynamic> json) => InspectionHistoryData(
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
  String? vehicleId;
  String? time;
  String? odoMeter;
  String? inspectorName;
  String? location;
  bool? foundDefects;
  String? note;
  int? flag;

  Datum({
    this.date,
    this.vehicleId,
    this.time,
    this.odoMeter,
    this.inspectorName,
    this.location,
    this.foundDefects,
    this.note,
    this.flag,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    date: json["Date"],
    vehicleId: json["VehicleId"],
    time: json["Time"],
    odoMeter: json["OdoMeter"],
    inspectorName: json["InspectorName"]!,
    location: json["Location"],
    foundDefects: json["FoundDefects"],
    note: json["Note"],
    flag: json["Flag"],
  );

  Map<String, dynamic> toJson() => {
    "Date": date,
    "VehicleId": vehicleId,
    "Time": time,
    "OdoMeter": odoMeter,
    "InspectorName": inspectorName,
    "Location": location,
    "FoundDefects": foundDefects,
    "Note": note,
    "Flag": flag,
  };
}


class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
