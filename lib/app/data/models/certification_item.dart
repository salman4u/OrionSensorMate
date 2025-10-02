// To parse this JSON data, do
//
//     final certificationHistory = certificationHistoryFromJson(jsonString);

import 'dart:convert';

CertificationHistory certificationHistoryFromJson(String str) => CertificationHistory.fromJson(json.decode(str));

String certificationHistoryToJson(CertificationHistory data) => json.encode(data.toJson());

class CertificationHistory {
  bool? result;
  String? message;
  List<CertificationDetails>? data;

  CertificationHistory({
    this.result,
    this.message,
    this.data,
  });

  factory CertificationHistory.fromJson(Map<String, dynamic> json) => CertificationHistory(
    result: json["Result"],
    message: json["Message"],
    data: json["Data"] == null ? [] : List<CertificationDetails>.from(json["Data"]!.map((x) => CertificationDetails.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Result": result,
    "Message": message,
    "Data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class CertificationDetails {
  int? driverId;
  String? date;
  SigninType? signinType;
  String? imageSignature;

  CertificationDetails({
    this.driverId,
    this.date,
    this.signinType,
    this.imageSignature,
  });

  factory CertificationDetails.fromJson(Map<String, dynamic> json) => CertificationDetails(
    driverId: json["DriverId"],
    date: json["Date"],
    signinType: signinTypeValues.map[json["SigninType"]]!,
    imageSignature: json["ImageSignature"],
  );

  Map<String, dynamic> toJson() => {
    "DriverId": driverId,
    "Date": date,
    "SigninType": signinTypeValues.reverse[signinType],
    "ImageSignature": imageSignature,
  };
}

enum SigninType {
  DAILY_LOG
}

final signinTypeValues = EnumValues({
  "DailyLog": SigninType.DAILY_LOG
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
