class DutyStatusItem {
  final String startTime;
  final int dutyStatus;
  final double latitude;
  final double longitude;
  final String location;
  final int driverId;
  final String? endCoordinate;
  final bool isDutyStatusCompleted;
  final bool isDutyStatusChangedManually;
  final bool isIntermediatelog;
  final bool isYardMove;
  final bool isEngineShutDownRecord;
  final bool isCertifiedRecord;
  final String certifiedBy;
  final bool isMalfunctionRecord;
  final String startAddress;
  final String? endAddress;
  final int shiftId;
  final String endTime;
  final String isCycleStatusCompleted;
  final int eventId;
  final int eventType;
  final int dutyStatusId;
  final String note;
  final String shiftStarted;
  final String shiftEnded;
  final int isPc;
  final String odoMeter;
  final int vehicleId;
  final bool isPreTrip;
  final bool is16Hrs;
  final int duration;

  DutyStatusItem({
    required this.startTime,
    required this.dutyStatus,
    required this.latitude,
    required this.longitude,
    required this.location,
    required this.driverId,
    this.endCoordinate,
    required this.isDutyStatusCompleted,
    required this.isDutyStatusChangedManually,
    required this.isIntermediatelog,
    required this.isYardMove,
    required this.isEngineShutDownRecord,
    required this.isCertifiedRecord,
    required this.certifiedBy,
    required this.isMalfunctionRecord,
    required this.startAddress,
    this.endAddress,
    required this.shiftId,
    required this.endTime,
    required this.isCycleStatusCompleted,
    required this.eventId,
    required this.eventType,
    required this.dutyStatusId,
    required this.note,
    required this.shiftStarted,
    required this.shiftEnded,
    required this.isPc,
    required this.odoMeter,
    required this.vehicleId,
    required this.isPreTrip,
    required this.is16Hrs,
    required this.duration,
  });

  Map<String, dynamic> toMap() {
    return {
      'startTime': startTime,
      'dutyStatus': dutyStatus,
      'latitude': latitude,
      'longitude': longitude,
      'location': location,
      'driverId': driverId,
      'endCoordinate': endCoordinate,
      'isDutyStatusCompleted': isDutyStatusCompleted ? 1 : 0,
      'isDutyStatusChangedManually': isDutyStatusChangedManually ? 1 : 0,
      'isIntermediatelog': isIntermediatelog ? 1 : 0,
      'isYardMove': isYardMove ? 1 : 0,
      'isEngineShutDownRecord': isEngineShutDownRecord ? 1 : 0,
      'isCertifiedRecord': isCertifiedRecord ? 1 : 0,
      'certifiedBy': certifiedBy,
      'isMalfunctionRecord': isMalfunctionRecord ? 1 : 0,
      'startAddress': startAddress,
      'endAddress': endAddress,
      'shiftId': shiftId,
      'endTime': endTime,
      'isCycleStatusCompleted': isCycleStatusCompleted ,
      'eventId': eventId,
      'eventType': eventType,
      'dutyStatusId': dutyStatusId,
      'note': note,
      'shiftStarted': shiftStarted,
      'shiftEnded': shiftEnded,
      'isPc': isPc,
      'odoMeter': odoMeter,
      'vehicleId': vehicleId,
      'isPreTrip': isPreTrip ? 1 : 0,
      'is16Hrs': is16Hrs ? 1 : 0,
      'duration': duration,
    };
  }
}
