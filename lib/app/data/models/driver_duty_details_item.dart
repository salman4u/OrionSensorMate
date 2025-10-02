// To parse this JSON data, do
//
//     final driverDutyDetails = driverDutyDetailsFromJson(jsonString);

import 'dart:convert';

DriverDutyDetails driverDutyDetailsFromJson(String str) => DriverDutyDetails.fromJson(json.decode(str));

String driverDutyDetailsToJson(DriverDutyDetails data) => json.encode(data.toJson());

class DriverDutyDetails {
  bool? result;
  String? message;
  List<Datum>? data;

  DriverDutyDetails({
    this.result,
    this.message,
    this.data,
  });

  factory DriverDutyDetails.fromJson(Map<String, dynamic> json) => DriverDutyDetails(
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
  String? vehicleId;
  String? trailers;
  String? canbus;
  String? vlink;
  String? driverId;
  String? cycleId;
  String? timezone;
  String? dutyStatus;
  String? driveTime;
  String? onDutyNotDrive;
  String? reset14HoursTime;
  String? rest10HoursTime;
  String? shiftReset;
  DateTime? shiftResetTime;
  String? untilRestBreak;
  String? minimumBreakTime;
  String? cycleReset;
  DateTime? cycleResetTime;
  DateTime? cycleEndTime;
  String? maniFestNumber;
  String? warningsNumber;
  String? deliveredManifestDate;
  String? proLastAddress;
  double? unAccountedDriverMiles;
  String? sleeper2Time;
  String? sleeper3Time;
  String? sleeper7Time;
  String? sleeper8Time;
  int? sleeper2Min;
  int? sleeper3Min;
  int? sleeper7Min;
  int? sleeper8Min;
  String? day1OnDutyTime;
  String? day2OnDutyTime;
  String? day3OnDutyTime;
  String? day4OnDutyTime;
  String? day5OnDutyTime;
  String? day6OnDutyTime;
  String? day7OnDutyTime;
  String? day8OnDutyTime;
  int? day1DriveTime;
  int? day2DriveTime;
  int? day3DriveTime;
  int? day4DriveTime;
  int? day5DriveTime;
  int? day6DriveTime;
  int? day7DriveTime;
  int? day8DriveTime;
  int? day1OffDutyTime;
  int? day2OffDutyTime;
  int? day3OffDutyTime;
  int? day4OffDutyTime;
  int? day5OffDutyTime;
  int? day6OffDutyTime;
  int? day7OffDutyTime;
  int? day8OffDutyTime;
  int? day1SleeperTime;
  int? day2SleeperTime;
  int? day3SleeperTime;
  int? day4SleeperTime;
  int? day5SleeperTime;
  int? day6SleeperTime;
  int? day7SleeperTime;
  int? day8SleeperTime;
  bool? drivingSh;
  bool? hours70Sh;
  bool? min30BreakSh;
  int? distance;
  bool? duty14Hrsh;
  bool? vehicleInspectionsFlag;
  String? coDriver;
  double? engineHours;
  String? xcom5G;
  String? xsen5G;

  Datum({
    this.vehicleId,
    this.trailers,
    this.canbus,
    this.vlink,
    this.driverId,
    this.cycleId,
    this.timezone,
    this.dutyStatus,
    this.driveTime,
    this.onDutyNotDrive,
    this.reset14HoursTime,
    this.rest10HoursTime,
    this.shiftReset,
    this.shiftResetTime,
    this.untilRestBreak,
    this.minimumBreakTime,
    this.cycleReset,
    this.cycleResetTime,
    this.cycleEndTime,
    this.maniFestNumber,
    this.warningsNumber,
    this.deliveredManifestDate,
    this.proLastAddress,
    this.unAccountedDriverMiles,
    this.sleeper2Time,
    this.sleeper3Time,
    this.sleeper7Time,
    this.sleeper8Time,
    this.sleeper2Min,
    this.sleeper3Min,
    this.sleeper7Min,
    this.sleeper8Min,
    this.day1OnDutyTime,
    this.day2OnDutyTime,
    this.day3OnDutyTime,
    this.day4OnDutyTime,
    this.day5OnDutyTime,
    this.day6OnDutyTime,
    this.day7OnDutyTime,
    this.day8OnDutyTime,
    this.day1DriveTime,
    this.day2DriveTime,
    this.day3DriveTime,
    this.day4DriveTime,
    this.day5DriveTime,
    this.day6DriveTime,
    this.day7DriveTime,
    this.day8DriveTime,
    this.day1OffDutyTime,
    this.day2OffDutyTime,
    this.day3OffDutyTime,
    this.day4OffDutyTime,
    this.day5OffDutyTime,
    this.day6OffDutyTime,
    this.day7OffDutyTime,
    this.day8OffDutyTime,
    this.day1SleeperTime,
    this.day2SleeperTime,
    this.day3SleeperTime,
    this.day4SleeperTime,
    this.day5SleeperTime,
    this.day6SleeperTime,
    this.day7SleeperTime,
    this.day8SleeperTime,
    this.drivingSh,
    this.hours70Sh,
    this.min30BreakSh,
    this.distance,
    this.duty14Hrsh,
    this.vehicleInspectionsFlag,
    this.coDriver,
    this.engineHours,
    this.xcom5G,
    this.xsen5G,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    vehicleId: json["VehicleId"],
    trailers: json["Trailers"],
    canbus: json["Canbus"],
    vlink: json["Vlink"],
    driverId: json["DriverId"],
    cycleId: json["CycleId"],
    timezone: json["Timezone"],
    dutyStatus: json["DutyStatus"],
    driveTime: json["DriveTime"],
    onDutyNotDrive: json["OnDutyNotDrive"],
    reset14HoursTime: json["Reset14HoursTime"],
    rest10HoursTime: json["Rest10HoursTime"],
    shiftReset: json["ShiftReset"],
    shiftResetTime: json["ShiftResetTime"] == null ? null : DateTime.parse(json["ShiftResetTime"]),
    untilRestBreak: json["UntilRestBreak"],
    minimumBreakTime: json["MinimumBreakTime"],
    cycleReset: json["CycleReset"],
    cycleResetTime: json["CycleResetTime"] == null ? null : DateTime.parse(json["CycleResetTime"]),
    cycleEndTime: json["CycleEndTime"] == null ? null : DateTime.parse(json["CycleEndTime"]),
    maniFestNumber: json["ManiFestNumber"],
    warningsNumber: json["WarningsNumber"],
    deliveredManifestDate: json["DeliveredManifestDate"],
    proLastAddress: json["ProLastAddress"],
    unAccountedDriverMiles: json["UnAccountedDriverMiles"],
    sleeper2Time: json["sleeper2time"],
    sleeper3Time: json["sleeper3time"],
    sleeper7Time: json["sleeper7time"],
    sleeper8Time: json["sleeper8time"],
    sleeper2Min: json["sleeper2min"],
    sleeper3Min: json["sleeper3min"],
    sleeper7Min: json["sleeper7min"],
    sleeper8Min: json["sleeper8min"],
    day1OnDutyTime: json["Day1OnDutyTime"],
    day2OnDutyTime: json["Day2OnDutyTime"],
    day3OnDutyTime: json["Day3OnDutyTime"],
    day4OnDutyTime: json["Day4OnDutyTime"],
    day5OnDutyTime: json["Day5OnDutyTime"],
    day6OnDutyTime: json["Day6OnDutyTime"],
    day7OnDutyTime: json["Day7OnDutyTime"],
    day8OnDutyTime: json["Day8OnDutyTime"],
    day1DriveTime: json["Day1DriveTime"],
    day2DriveTime: json["Day2DriveTime"],
    day3DriveTime: json["Day3DriveTime"],
    day4DriveTime: json["Day4DriveTime"],
    day5DriveTime: json["Day5DriveTime"],
    day6DriveTime: json["Day6DriveTime"],
    day7DriveTime: json["Day7DriveTime"],
    day8DriveTime: json["Day8DriveTime"],
    day1OffDutyTime: json["Day1OffDutyTime"],
    day2OffDutyTime: json["Day2OffDutyTime"],
    day3OffDutyTime: json["Day3OffDutyTime"],
    day4OffDutyTime: json["Day4OffDutyTime"],
    day5OffDutyTime: json["Day5OffDutyTime"],
    day6OffDutyTime: json["Day6OffDutyTime"],
    day7OffDutyTime: json["Day7OffDutyTime"],
    day8OffDutyTime: json["Day8OffDutyTime"],
    day1SleeperTime: json["Day1SleeperTime"],
    day2SleeperTime: json["Day2SleeperTime"],
    day3SleeperTime: json["Day3SleeperTime"],
    day4SleeperTime: json["Day4SleeperTime"],
    day5SleeperTime: json["Day5SleeperTime"],
    day6SleeperTime: json["Day6SleeperTime"],
    day7SleeperTime: json["Day7SleeperTime"],
    day8SleeperTime: json["Day8SleeperTime"],
    drivingSh: json["DrivingSH"],
    hours70Sh: json["Hours70SH"],
    min30BreakSh: json["Min30BreakSH"],
    distance: json["Distance"],
    duty14Hrsh: json["Duty14HRSH"],
    vehicleInspectionsFlag: json["VehicleInspectionsFlag"],
    coDriver: json["CoDriver"],
    engineHours: json["EngineHours"]?.toDouble(),
    xcom5G: json["XCOM5G"],
    xsen5G: json["XSEN5G"],
  );

  Map<String, dynamic> toJson() => {
    "VehicleId": vehicleId,
    "Trailers": trailers,
    "Canbus": canbus,
    "Vlink": vlink,
    "DriverId": driverId,
    "CycleId": cycleId,
    "Timezone": timezone,
    "DutyStatus": dutyStatus,
    "DriveTime": driveTime,
    "OnDutyNotDrive": onDutyNotDrive,
    "Reset14HoursTime": reset14HoursTime,
    "Rest10HoursTime": rest10HoursTime,
    "ShiftReset": shiftReset,
    "ShiftResetTime": shiftResetTime?.toIso8601String(),
    "UntilRestBreak": untilRestBreak,
    "MinimumBreakTime": minimumBreakTime,
    "CycleReset": cycleReset,
    "CycleResetTime": cycleResetTime?.toIso8601String(),
    "CycleEndTime": cycleEndTime?.toIso8601String(),
    "ManiFestNumber": maniFestNumber,
    "WarningsNumber": warningsNumber,
    "DeliveredManifestDate": deliveredManifestDate,
    "ProLastAddress": proLastAddress,
    "UnAccountedDriverMiles": unAccountedDriverMiles,
    "sleeper2time": sleeper2Time,
    "sleeper3time": sleeper3Time,
    "sleeper7time": sleeper7Time,
    "sleeper8time": sleeper8Time,
    "sleeper2min": sleeper2Min,
    "sleeper3min": sleeper3Min,
    "sleeper7min": sleeper7Min,
    "sleeper8min": sleeper8Min,
    "Day1OnDutyTime": day1OnDutyTime,
    "Day2OnDutyTime": day2OnDutyTime,
    "Day3OnDutyTime": day3OnDutyTime,
    "Day4OnDutyTime": day4OnDutyTime,
    "Day5OnDutyTime": day5OnDutyTime,
    "Day6OnDutyTime": day6OnDutyTime,
    "Day7OnDutyTime": day7OnDutyTime,
    "Day8OnDutyTime": day8OnDutyTime,
    "Day1DriveTime": day1DriveTime,
    "Day2DriveTime": day2DriveTime,
    "Day3DriveTime": day3DriveTime,
    "Day4DriveTime": day4DriveTime,
    "Day5DriveTime": day5DriveTime,
    "Day6DriveTime": day6DriveTime,
    "Day7DriveTime": day7DriveTime,
    "Day8DriveTime": day8DriveTime,
    "Day1OffDutyTime": day1OffDutyTime,
    "Day2OffDutyTime": day2OffDutyTime,
    "Day3OffDutyTime": day3OffDutyTime,
    "Day4OffDutyTime": day4OffDutyTime,
    "Day5OffDutyTime": day5OffDutyTime,
    "Day6OffDutyTime": day6OffDutyTime,
    "Day7OffDutyTime": day7OffDutyTime,
    "Day8OffDutyTime": day8OffDutyTime,
    "Day1SleeperTime": day1SleeperTime,
    "Day2SleeperTime": day2SleeperTime,
    "Day3SleeperTime": day3SleeperTime,
    "Day4SleeperTime": day4SleeperTime,
    "Day5SleeperTime": day5SleeperTime,
    "Day6SleeperTime": day6SleeperTime,
    "Day7SleeperTime": day7SleeperTime,
    "Day8SleeperTime": day8SleeperTime,
    "DrivingSH": drivingSh,
    "Hours70SH": hours70Sh,
    "Min30BreakSH": min30BreakSh,
    "Distance": distance,
    "Duty14HRSH": duty14Hrsh,
    "VehicleInspectionsFlag": vehicleInspectionsFlag,
    "CoDriver": coDriver,
    "EngineHours": engineHours,
    "XCOM5G": xcom5G,
    "XSEN5G": xsen5G,
  };
}
