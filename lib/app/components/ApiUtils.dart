class ApiUtils {
  static const String KEY_GUID = 'Guid';
  static const String KEY_UNACCOUNTED_MILES = 'UnAccountedMiles';
  static const String KEY_UNACCOUNTED_MILES_LAST_TIME = 'UnAccountedMilesLastTime';
  static const String FakeDriverId = '52441'; //Lehmeier 169713
  static const String FakeDriverId_1 = '52441'; //Lehmeier 169713
  static const String FakeDriverGuid = 'fc81edd6-c867-4254-8e49-9b1550e9ff6e';
  static const String KEY_ORG = 'OrgName';
  static const String SIGN_IN_TYPE = 'SigninType';
  static const String KEY_TEXT = 'Subject';
  static const String KEY_TEXT_BODY = 'Note';
  static const String KEY_ACCESS_KEY_ID = 'here.com.key';
  static const String KEY_ACCESS_KEY_SECRET = 'here.com.secret';
  static const String KEY_CANBUS_ID = 'CanBusId';
  static const String KEY_VEHICLE_ID = 'VehicleId';
  static const String KEY_MESSAGE = 'Message';
  static const String KEY_TRACTOR_ID = 'TractorId';
  static const String KEY_VIOLATION_CODE = 'ViolationCode';
  static const String KEY_LAST_VIOLATION_ID = 'LastViolationID';
  static const String KEY_VIOLATION_ID = 'violationId';
  static const String KEY_VIOLATION_TIME = 'ViolationTime';
  static const String KEY_TRAILER_ID_ASSIGN = 'trailerId';
  static const String KEY_VLINK_ID = 'VLinkId';
  static const String KEY_DRIVER_ID = 'DriverId';
  static const String KEY_FM_APP_USER_ID = 'UserID';
  static const String KEY_ROUTING_ID = 'Routing';
  static const String KEY_ODOMETER_OFFSET = 'OdometerCalibration';
  static const String KEY_VEHICLE_IDs = 'VehicleId';
  static const String KEY_UTC_DATETIME = 'UTCDateTime';
  static const String KEY_DATA_FLAG = 'DataFlag';
  static const String KEY_VEHICLE_VIN = 'VIN';
  static const String KEY_VEHICLE_NAME = 'VehicleName';
  static const String KEY_LICENSE_PLATE = 'LicensePlate';
  static const String KEY_VEHICLE_AID = 'VehicleAID';
  static const String KEY_VEHIClE_TYPE = 'VehicleType';
  static const String KEY_AID_NUMBER = 'AIDNumber';
  static const String KEY_OLD_AID_NUMBER = 'OldAIDNumber';
  static const String KEY_NEW_AID_NUMBER = 'NewAIDNumber';
  static const String KEY_HUB_NAME = 'HubName';
  static const String KEY_LICENCE_NUMBER = 'licencenuber';
  static const String KEY_LICENCE_ISSUED_DATE = 'issuedDate';
  static const String KEY_LICENCE_EXPIRED_DATE = 'expiredDate';
  static const String KEY_LICENCE_ISSUED_STATE = 'state';
  static const String KEY_LICENCE_TYPE = 'licencetype';
  static const String KEY_LICENCE_ID = 'licenceeid';
  static const String KEY_LICENSE_TYPE_ID = 'licenseTypeId';
  static const String KEY_DURATION_LOG_SHIFT_TIME = 'durationLogShiftTime';
  static const String KEY_IS_ON_GOING_SHIFT = 'isOnGoingShift';
  static const String KEY_HUB_TYPE = 'HubType';
  static const String KEY_HUB_TD = 'HUBTD';
  static const String KEY_DESCRIPTION = 'Description';
  static const String KEY_IMEI = 'IMEI';
  static const String KEY_DID = 'DID';
  static const String KEY_DISTANCE = 'Distance';
  static const String KEY_IS_ENGINE_ON = 'IsEngineRunning';
  static const String KEY_CAN_SERIAL_NO = 'CanSerialNo';
  static const String KEY_VLINK_SERIAL_NO = 'VLinkSerialNo';
  static const String KEY_CANBUS = 'CanBus';
  static const String KEY_VLINK = 'VLink';
  static const String KEY_TRAILER_ID = 'TrailerId';
  static const String KEY_LOGIN_ID = 'loginId';
  static const String KEY_USERNAME_ID = 'userName';
  static const String KEY_LOGIN_PW = 'password';
  static const String KEY_USERNAME = 'UserName';
  static const String KEY_APP_VERSION = 'AppVersion';
  static const String KEY_DEVICE_OS_INFO = 'DeviceInfo';
  static const String KEY_APP_TYPE = 'AppType';
  static const String KEY_UNIQUE_ID = 'MSCId';
  static const String KEY_CELLPHONE = 'CellPhone';
  static const String KEY_DUTY_STATUS_ID = 'DutyStatusId';
  static const String KEY_START_LOCATION = 'StartLocation';
  static const String KEY_END_LOCATION = 'EndLocation';
  static const String KEY_START_TIME = 'StartTime';
  static const String KEY_START_TIME_34_HRS = 'StartDate';
  static const String KEY_START_TIME_TIMESTAMP = 'StartTimeStamp';
  static const String KEY_END_TIME = 'EndTime';
  static const String KEY_IS_SPECIAL_DRIVING_MODE = 'IsSpecialDrivingMode';
  static const String KEY_IS_YARD_MOVE_STARTED = 'IsYardMoveStarted';
  static const String KEY_YARD_MOVE_STARTED_DISTANCE = 'IsYardMoveStartedDistance';
  static const String KEY_IS_YARD_MOVE_ENDED = 'IsYardMoveEnded';
  static const String KEY_ODOMETER = 'OdoMeter';
  static const String KEY_IS_GPS_BASED_CALCULATION = 'EstimatedOdometer';
  static const String KEY_LAST_TIME_DUTY_STATU_FIRED = 'lastimedutystatuswasfired';
  static const String KEY_ODOMETER_WS_LAST_SENT = 'OdoMeterlastSendToWS';
  static const String KEY_ODOMETER_AUTO_UPDATE = 'keyodometerautoupdate';
  static const String KEY_REST_BREAK_START_TIME = 'keyrestbreakstarttime';
  static const String KEY_LAST_JSON_FOR_ROAD_DISTANCE = 'keylastjsonforcalculatingroaddistance';
  static const String KEY_LAST_TIME_GMAP_API_CALLED = 'keylasttimegMapApicalled';
  static const String KEY_NOTE = 'Note';
  static const String KEY_LAST_SHIFT_TO_PORTAL = 'keyLastDutyStatusToPortal';
  static const String KEY_OLD_PW = 'OldPassword';
  static const String KEY_NEW_PW = 'NewPassword';
  static const String KEY_SIGNATURE_FILE = 'SignatureFile';
  static const String KEY_FEEDBACK_IMAGE_FILE = 'ImageFile';
  static const String KEY_DATE = 'Date';
  static const String KEY_EVENT_DATE = 'EventTime';
  static const String KEY_TIME = 'Time';
  static const String KEY_LOCATION = 'Location';
  static const String PREVIOUS_LOCATION = 'KeyPreviousLocation';
  static const String KEY_PREVIOUS_ODOMETER_BEFORE_ESTIMATED_ODOMETER = 'keypreviousodometerbeforecalculation';
  static const String KEY_LOCATION_USED_IN_ESTIMATED_DISTANCE = 'LocationUsedInEstimagedLocation';
  static const String KEY_ODOMETER_WS = 'odometerWSReported';
  static const String KEY_ODOMETER_REST = 'odometerWSReportedRest';
  static const String KEY_INSPECTOR_NAME = 'InspectorName';
  static const String KEY_FOUND_DEFECTS = 'FoundDefects';
  static const String KEY_IMAGE_SIGNATURE = 'ImageSignature';
  static const String KEY_START_DATE = 'StartDate';
  static const String KEY_END_DATE = 'EndDate';
  static const String KEY_LATITUDE = 'Latitude';
  static const String KEY_IS_16_HRS_SHIFT = 'Is16Hrs';
  static const String KEY_LONGITUDE = 'Longitude';
  static const String KEY_LATITUDE_LONGITUDE = 'LatLong';
  static const String KEY_SAFE_HAVEN_DESCRIPTION = 'seekHeavenDescription';
  static const String KEY_SAFE_HAVEN_TYPE = 'seekHeavenType';
  static const String KEY_DATE_TIME = 'DateTime';
  static const String KEY_COMMENT = 'Comment';
  static const String KEY_DUTY_CYCLE_ID = 'DutyCycleId';
  static const String KEY_DUTY_STATUS = 'DutyStatus';
  static const String KEY_SHIFT_STARTED = 'ShiftStarted';
  static const String KEY_SHIFT_ENDED = 'ShiftEnded';
  static const String KEY_CYCLE_ID = 'CycleId';
  static const String KEY_EVENT_ID = 'EventId';
  static const String KEY_SHIFT_ID = 'ShiftId';
  static const String KEY_EVENT_TYPE = 'EventType';
  static const String KEY_EVENT_CODE = 'EventCode';
  static const String KEY_START_ADDRESS = 'StartAddress';
  static const String KEY_IS_MALFUNCTION_RECORD = 'IsMalfunctionRecord';
  static const String KEY_CERTIFIED_BY = 'CertifiedBy';
  static const String KEY_IS_CYCLE_STATUS_COMPLETED = 'IsCycleStatusCompleted';
  static const String KEY_IS_YARD_MOVE = 'IsYardMove';
  static const String KEY_IS_ENGINE_SHUT_DOWN_RECORD = 'IsEngineShutDownRecord';
  static const String KEY_IS_INTERMEDIATE_LOG = 'IsIntermediatelog';
  static const String KEY_IS_DUTY_STATUS_CHANGED_MANUALLY = 'isDutyStatusChangeManually';
  static const String KEY_CURRENT_DATE_TIME = 'CurrentDateTime';
  static const String KEY_IS_PERSONAL_CONVEYANCE = 'ISPC';
  static const String KEY_PGN = 'PGN';
  static const String KEY_ENGINE_HOURS = 'EngineHours';
  static const String KEY_HEX_CODE = 'HaxCode';
  static const String KEY_CURRENT_DATE = 'CurrentDate';
  static const String KEY_FROM_DATE = 'FromDate';
  static const String KEY_RESET_10_HRS_TIME = 'Reset10hrtime';
  static const String KEY_RESET_14_HRS_TIME = 'Start14hrtime';
  static const String KEY_RESET_2_HRS_TIME = 'Reset2hrtime';
  static const String KEY_RESET_3_HRS_TIME = 'Reset3hrtime';
  static const String KEY_RESET_7_HRS_TIME = 'Reset7hrtime';
  static const String KEY_RESET_8_HRS_TIME = 'Reset8hrtime';
  static const String KEY_RESET_10_HRS_FLAG = 'Flag10hr';
  static const String KEY_RESET_14_HRS_FLAG = 'Flag14hr';
  static const String KEY_RESET_2_HRS_FLAG = 'Flag2hr';
  static const String KEY_RESET_3_HRS_FLAG = 'Flag3hr';
  static const String KEY_RESET_7_HRS_FLAG = 'Flag7hr';
  static const String KEY_RESET_8_HRS_FLAG = 'Flag8hr';
  static const String KEY_TO_DATE = 'ToDate';
  static const String KEY_CURRENT_LATITUDE = 'CurrentLatitude';
  static const String KEY_CURRENT_LONGITUDE = 'CurrentLongitude';

  static final ApiUtils _instance = ApiUtils._internal();

  factory ApiUtils() {
    return _instance;
  }

  ApiUtils._internal();

  Map<String, dynamic> bundle = {};

  static const String HELP_URL = "https://logistiwerx.com/elog/helpdroid.html";

  Map<String, dynamic> getValue() {
    return bundle;
  }

  void setValue(Map<String, dynamic> bundle) {
    this.bundle = bundle;
  }
}
