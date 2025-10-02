// To parse this JSON data, do
//
//     final headerInfoData = headerInfoDataFromJson(jsonString);

import 'dart:convert';

HeaderInfoData headerInfoDataFromJson(String str) => HeaderInfoData.fromJson(json.decode(str));

String headerInfoDataToJson(HeaderInfoData data) => json.encode(data.toJson());

class HeaderInfoData {
  bool? result;
  String? message;
  List<Datum>? data;

  HeaderInfoData({
    this.result,
    this.message,
    this.data,
  });

  factory HeaderInfoData.fromJson(Map<String, dynamic> json) => HeaderInfoData(
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
  String? driverName;
  String? coDriverName;
  String? name;
  String? dotNo;
  String? address;
  String? shippingDocs;
  String? trailers;
  String? timeZone;
  String? cycle;
  String? recapType;
  String? homeTerminal;

  Datum({
    this.driverName,
    this.coDriverName,
    this.name,
    this.dotNo,
    this.address,
    this.shippingDocs,
    this.trailers,
    this.timeZone,
    this.cycle,
    this.recapType,
    this.homeTerminal,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    driverName: json["DriverName"],
    coDriverName: json["CoDriverName"],
    name: json["Name"],
    dotNo: json["DotNo"],
    address: json["Address"],
    shippingDocs: json["ShippingDocs"],
    trailers: json["Trailers"],
    timeZone: json["TimeZone"],
    cycle: json["Cycle"],
    recapType: json["RecapType"],
    homeTerminal: json["HomeTerminal"],
  );

  Map<String, dynamic> toJson() => {
    "DriverName": driverName,
    "CoDriverName": coDriverName,
    "Name": name,
    "DotNo": dotNo,
    "Address": address,
    "ShippingDocs": shippingDocs,
    "Trailers": trailers,
    "TimeZone": timeZone,
    "Cycle": cycle,
    "RecapType": recapType,
    "HomeTerminal": homeTerminal,
  };
}
