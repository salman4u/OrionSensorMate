class LoginResponse {
  final String orgName;
  final String guid;
  final String vin;
  final String odometer;
  final int driverId;
  final String driverName;
  final String vehicleNo;
  final String vehicleId;
  final int? dutyStatusId;
  final String role;
  final String carrier;
  final String license;

  LoginResponse({
    required this.orgName,
    required this.guid,
    required this.vin,
    required this.odometer,
    required this.driverId,
    required this.driverName,
    required this.vehicleNo,
    required this.vehicleId,
    this.dutyStatusId,
    required this.role,
    required this.carrier,
    required this.license,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      orgName: json["OrgName"] ?? "",
      guid: json["Guid"] ?? "",
      vin: json["VIN"] ?? "",
      odometer: json["ODOMeter"] ?? "",
      driverId: json["DriverId"] ?? 0,
      driverName: json["DriverName"] ?? "",
      vehicleNo: json["VehicleNo"] ?? "",
      vehicleId: json["VehicleId"] ?? "",
      dutyStatusId: json["DutyStatusId"],
      role: json["Role"] ?? "",
      carrier: json["Carrier"] ?? "",
      license: json["License"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "OrgName": orgName,
    "Guid": guid,
    "VIN": vin,
    "ODOMeter": odometer,
    "DriverId": driverId,
    "DriverName": driverName,
    "VehicleNo": vehicleNo,
    "VehicleId": vehicleId,
    "DutyStatusId": dutyStatusId,
    "Role": role,
    "Carrier": carrier,
    "License": license,
  };
}
