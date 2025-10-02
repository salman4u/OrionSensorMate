
const String HEADER_TEXT="Version: 1.0.0\nElectronic Logging Device";
const String ELD_TEXT = "For use as ABORD or ELD with\nXCOM5G or VLINK/CANBUS";
const String WELCOME_BUTTOM_TEXT = 'Driver Hours of Service(HOS) Logs, Behavior, and Maintenance Reporting';

const String  SEND_REPORT_BY_EMAIL_API = "ELDLoginLogoutSubmissionByEmail";
const String SEND_REPORT_BY_WS_API = "ELDLoginLogoutSubmission";

 const baseUrl2 = 'https://elog.alwaysaware.org/api/';
 const login = baseUrl2 + 'Login';
const dutyStatus = baseUrl2 + 'DutyStatus';
const dutyStatusEdit = baseUrl2 + 'dutystatusedit';// (pc to drive , drive to pc)

const durationLogData = baseUrl2 + 'DurationLogData';
const driverDutyDetails = baseUrl2 + 'DriverDutyDetails';
const stripChartWS = baseUrl2 + 'StripChartData';
const headerInfoData = baseUrl2 + 'HeaderInfoData';
const driverLatLongWS = baseUrl2 + 'DriverLatLogWithTime';
const certificationHistoryWS = baseUrl2 + 'CertificationHistory';
const fmcsaDriverInspectionViaWebService = baseUrl2 + SEND_REPORT_BY_WS_API;
const fmcsaDriverInspectionViaEmail = baseUrl2 + SEND_REPORT_BY_EMAIL_API;

const inspectionHistoryWS = baseUrl2 + 'InspectionHistory';
const days14DutyStatusDetails = baseUrl2 + 'Days14DutyStatusDetails';
const ADD_VIOLATION = baseUrl2 + "DailyViolationLog/AddViolation";

const CONFIRMATION_VEHICLE_DEVICE_API = baseUrl2 + "DriverWithVehicleCanBusVLink";
const LOG_OUT = baseUrl2 + "Logout";

const ASSIGN_VEHICLE_API = baseUrl2 + "AssignVehicleToDriver";
const MALFUNCTION_API = baseUrl2 + "MalFunction";

const  vehicleList = baseUrl2 + 'DriverVehicleList';
const  signout = baseUrl2 + 'DriverVehicleList';
const  sendFeedback = baseUrl2 + 'DriverImagewithNote';
const  signDailyLog = baseUrl2 + 'SignDailyLog';

const  unDrivervehicleList = baseUrl2 + 'unDriverVehicleList';

const  driverProfileDetail = baseUrl2 + 'driverProfileDetail';
const  uploadDataToPortal = baseUrl2 + 'UplinkDataToParseData';
const  inspection = baseUrl2 + 'Inspection';

const  forgotLogginPassword = baseUrl2 + 'ForgetLoginPassword';

const  eldList = baseUrl2 + 'CradlesCanHubList';

const submitInspection = baseUrl2+ 'SubmitInspection';
 const inspectionHistory = baseUrl2+ 'InspectionHistory';
 const uploadImages = baseUrl2+ 'UploadImage';
 const validateAssignedId = baseUrl2+ 'ValidateAssignedId';
 const signUp = baseUrl2+ 'Register';
 const deleteAccount = baseUrl2+ 'DeleteAccount';
const  yardMove = baseUrl2 + 'UpdateYardMove';
