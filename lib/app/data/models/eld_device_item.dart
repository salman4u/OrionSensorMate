// To parse this JSON data, do
//
//     final eldDeviceItem = eldDeviceItemFromJson(jsonString);

import 'dart:convert';

EldDeviceItem eldDeviceItemFromJson(String str) => EldDeviceItem.fromJson(json.decode(str));

String eldDeviceItemToJson(EldDeviceItem data) => json.encode(data.toJson());

class EldDeviceItem {
  bool result;
  String message;
  List<EldInfo> data;

  EldDeviceItem({
    required this.result,
    required this.message,
    required this.data,
  });

  factory EldDeviceItem.fromJson(Map<String, dynamic> json) => EldDeviceItem(
    result: json["Result"],
    message: json["Message"],
    data: List<EldInfo>.from(json["Data"].map((x) => EldInfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Result": result,
    "Message": message,
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class EldInfo {
  String hubId;
  String hubTd;
  String hubname;
  String hubType;

  EldInfo({
    required this.hubId,
    required this.hubTd,
    required this.hubname,
    required this.hubType,
  });

  factory EldInfo.fromJson(Map<String, dynamic> json) => EldInfo(
    hubId: json["HubId"],
    hubTd: json["HubTD"],
    hubname: json["Hubname"],
    hubType: json["HubType"],
  );

  Map<String, dynamic> toJson() => {
    "HubId": hubId,
    "HubTD": hubTd,
    "Hubname": hubname,
    "HubType": hubType,
  };
}
