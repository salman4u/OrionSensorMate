
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../utility/Utility.dart';
import '../models/dutystatus_item.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('dutystatus.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'STRING';
    const boolType = 'BOOLEAN NOT NULL';
    const intType = 'INTEGER NOT NULL';
    const doubleType = 'REAL NOT NULL';
    await db.execute('''
    CREATE TABLE $tableDutyStatus (
      id $idType,
      startTime $textType,
      dutyStatus $intType,
      latitude $doubleType,
      longitude $doubleType,
      location $textType,
      driverId $intType,
      endCoordinate $textType,
      isDutyStatusCompleted $boolType,
      isDutyStatusChangedManually $boolType,
      isIntermediatelog $boolType,
      isYardMove $boolType,
      isEngineShutDownRecord $boolType,
      isCertifiedRecord $boolType,
      certifiedBy $textType,
      isMalfunctionRecord $boolType,
      startAddress $textType,
      endAddress $textType,
      shiftId $intType,
      endTime $textType,
      isCycleStatusCompleted $boolType,
      eventId $intType,
      eventType $intType,
      dutyStatusId $intType UNIQUE,
      note $textType,
      shiftStarted $textType,
      shiftEnded $textType,
      isPc $intType,
      odoMeter $textType,
      vehicleId $intType,
      isPreTrip $boolType,
      is16Hrs $boolType,
      duration $intType
    )
    ''');

    // Create another table with fields WSName and WSResponse
    await db.execute('''
    CREATE TABLE $tableWSResponse (
      id $idType,
      WSName $textType UNIQUE,
      WSResponse $textType
    )
    ''');
  }
  // Insert or update data in WSResponseTable
  Future<void> insertOrUpdateWSResponse(String wsName, String wsResponse) async {
    final db = await instance.database;
    await db.insert(
      'WSResponseTable',
      {'WSName': wsName, 'WSResponse': wsResponse},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  Future<String> fetchWSResponse(String wsName) async {
    final db = await instance.database;
    final result = await db.query(
      'WSResponseTable',
      where: 'WSName = ?',
      whereArgs: [wsName],
    );
    if (result.isNotEmpty) {
      final Object? response = result.first['WSResponse'] ;
      return response.toString();
    }
    return '';
  }
  Future<int> getLastDutyStatus() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> lastRecord = await db.query(
      'DutyStatus',
      orderBy: 'id DESC',
      limit: 1,
    );
    if (lastRecord.isNotEmpty) {
      final int lastDutyStatus = lastRecord.first['dutyStatus'];
      return lastDutyStatus;
    } else {
      print('No records found in the table.');
    }
    return 4;
  }
  Future<Map<String, dynamic>> getLastDutyStatusDetails() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> lastRecord = await db.query(
      'DutyStatus',
      orderBy: 'id DESC',
      limit: 1,
    );
    if (lastRecord.isNotEmpty) {
      final int lastDutyStatus = lastRecord.first['dutyStatus'];
      final int lastDutyStatusId = lastRecord.first['dutyStatusId'];
      final String lastLocation = lastRecord.first['location'];
      final String lastStartTime = lastRecord.first['startTime'];
      final String lastNote = lastRecord.first['note'].toString();
      return {
        'dutyStatus': lastDutyStatus,
        'location': lastLocation,
        'note': lastNote,
        'dutyStatusId': lastDutyStatusId,
        'startTime': lastStartTime,
      };
    } else {
      print('No records found in the table.');
    }
    return {
      'dutyStatus': 4,  // Default duty status
      'location': '',   // Default empty location
      'note': '',       // Default empty note
      'dutyStatusId': 0,       // Default empty note
      'startTime':''
    };
  }

  Future<int> create(DutyStatusItem dutyStatus) async {
    final db = await instance.database;
    return await db.insert('DutyStatus', dutyStatus.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }
  Future<List<Map<String, dynamic>>> fetchAllWithNotes() async {
    final db = await instance.database;
    final result = await db.query(
      'DutyStatus',
      where: 'note IS NOT NULL AND note != ?',
      whereArgs: [''],
    );
    return result;
  }
  Future close() async {
    final db = await instance.database;
    db.close();
  }
  Future<List<Map<String, dynamic>>> findAllData() async {
    final db = await instance.database;
    return await db.query('DutyStatus');
  }
  Future<List<Map<String, dynamic>>> findShiftsWithLongDutyStatus() async {
    final db = await instance.database;
    final result = await db.rawQuery('''
      WITH RECURSIVE ShiftDurations AS (
        SELECT 
          id,
          shiftId,
          startTime,
          dutyStatus,
          duration,
          startTime AS originalStartTime,
          duration AS totalDuration
        FROM DutyStatus
        WHERE dutyStatus IN (3, 4)
        
        UNION ALL
        
        SELECT 
          ds.id,
          ds.shiftId,
          ds.startTime,
          ds.dutyStatus,
          ds.duration,
          sd.originalStartTime,
          sd.totalDuration + ds.duration
        FROM DutyStatus ds
        JOIN ShiftDurations sd ON ds.shiftId = sd.shiftId
        WHERE ds.startTime > sd.startTime
        AND ds.dutyStatus IN (3, 4)
        AND sd.totalDuration + ds.duration >= 36000
      )
      SELECT * FROM ShiftDurations WHERE totalDuration >= 36000
    ''');

    return result;
  }
  Future<List<Map<String, dynamic>>> getDutyStatusByStartTime(String startTime) async {
    final db = await database;
    return await db.query(
      'DutyStatus',
      where: 'id = ?',
      whereArgs: [startTime],
    );
  }
  Future<void> updateLastDutyStatus(int newDutyStatus) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> lastRecord = await db.query(
      'DutyStatus',
      orderBy: 'id DESC',
      limit: 1,
    );
    if (lastRecord.isNotEmpty) {
      final int lastId = lastRecord.first['id'];
      await db.update(
        'DutyStatus',
        {'dutyStatus': newDutyStatus},
        where: 'id = ?',
        whereArgs: [lastId],
      );
    } else {
      print('No records found in the table.');
    }
  }

  Future<Map<String, dynamic>> findDataAndSumDurations(int id) async {
    final db = await instance.database;
    final result = await db.rawQuery('''
    SELECT * 
    FROM DutyStatus 
    WHERE id >= ? 
  ''', [id]);
    final sumResult = await db.rawQuery('''
    SELECT SUM(duration) AS totalDuration
    FROM DutyStatus
    WHERE id >= ?
    AND dutyStatus = 1
  ''', [id]);
    return {
      'data': result,
      'totalDuration': sumResult.isNotEmpty ? sumResult.first['totalDuration'] : 0
    };
  }

  Future<List<Map<String, dynamic>>> findFirstDutyStatusAfterThreshold1() async {
    final db = await instance.database;
    final result = await db.rawQuery('''
   WITH ConsecutiveShifts AS (
   SELECT
    id,
    dutyStatus,
    startTime,
    endTime,
    duration,
    SUM(duration) OVER (ORDER BY startTime) AS cumulative_duration
  FROM DutyStatus
  WHERE dutyStatus IN (3, 4)
  ),
  FirstOverLimit AS (
  SELECT
    id,
    dutyStatus,
    startTime,
    endTime,
    cumulative_duration
  FROM ConsecutiveShifts
  WHERE cumulative_duration >= 36000
  ORDER BY cumulative_duration
  LIMIT 1
)
 SELECT *
FROM DutyStatus
WHERE dutyStatus IN (1, 2)
AND startTime > (SELECT startTime FROM FirstOverLimit)
ORDER BY startTime;
''');

    return result;
  }
  Future<bool> isDurationGreaterThanTime(int time) async {
    final db = await instance.database;
    final result = await db.rawQuery('''
      SELECT *
      FROM $tableDutyStatus
      ORDER BY id DESC
    ''');
    List<Map<String, dynamic>> filteredResult = [];
    for (var row in result) {
      if (row['dutyStatus'] == 3 || row['dutyStatus'] == 4) {
        filteredResult.add(row);
      }
      if (row['dutyStatus'] == 1 || row['dutyStatus'] == 2) {
        break;
      }
    }
    num sum = 0;
    for (var row in filteredResult) {
      sum += row['duration'] as num;
      if ( sum > time) {
        break;
      }
    }
    return sum > time;
  }

  Future<num> findCurrentDrivingTimeWithoutBreak() async {
    final db = await instance.database;
    final result = await db.rawQuery('''
      SELECT *
      FROM $tableDutyStatus
    ''');
    List<Map<String, dynamic>> filteredResult = [];
    num sum = 0;
    String lastStartTime = "";
    for (var row in result) {
      if (row['dutyStatus'] == 1) {
        lastStartTime = row['startTime'].toString();
        filteredResult.add(row);
      }
      else if (row['dutyStatus'] != 1){
       sum += row['duration'] as num;
     if(sum > 1800) {
       filteredResult.clear();
      }
     }
    }
    num totalDuration = 0;
    for (var row in filteredResult) {
      totalDuration += row['duration'] as num;
    }

    return totalDuration;
  }

  Future<List<Map<String, dynamic>>> findFirstDutyStatusAfterThreshold(int time) async {
    final db = await instance.database;
    final result = await db.rawQuery('''
      SELECT *
      FROM $tableDutyStatus
    ''');
    List<Map<String, dynamic>> filteredResult = [];
    num sum = 0;
    for (var row in result) {
      if (row['dutyStatus'] == 3 || row['dutyStatus'] == 4) {
        sum += row['duration'] as num;
        if(sum > time){
          filteredResult.clear();
        }
      }
      else{
        sum = 0;
        filteredResult.add(row);
      }
    }
    return filteredResult;
  }
  Future<Map<String, dynamic>> checkIfTwoSplitExists(resultData) async {
    var result = checkSplit(resultData);
    int splitSleeper = result['splitSleeper'];
    List<Map<String, dynamic>> filteredResult = result['filteredResult'];
    List<Map<String, dynamic>> filteredResultFirstSplit = filteredResult;
    int remainingSplit = 10 - splitSleeper;
    if (splitSleeper > 0) {
      remainingSplit = 10 - splitSleeper;
    }
    String startTimeOfFirstSplit = "";
    if (remainingSplit > 0) {
      filteredResultFirstSplit = filteredResult;
      result = checkSecondSplit(resultData, remainingSplit);
      splitSleeper = result['splitSleeper'];
      filteredResult = result['filteredResult'];
      startTimeOfFirstSplit = result['startTimeOfRest'] ?? '';
      if (splitSleeper > 0) {
        return {
          'startTimeOfFirstSplit': startTimeOfFirstSplit,
          'filteredResultFirstSplit': filteredResultFirstSplit,
          'dataAfterSecondSplit':filteredResult
        };
      }
    }

    return {
      'startTimeOfFirstSplit': '',
      'filteredResultFirstSplit': filteredResultFirstSplit,
      'dataAfterSecondSplit':filteredResult
    };
  }
  Map<String, dynamic> checkSecondSplit(List<Map<String, Object?>> result, int splitCheck) {
    int splitSleeper = 0;
    List<Map<String, dynamic>> filteredResult = [];
    num sum = 0;
    String startTimeOfFirstRest = "";
    if(splitCheck == 2) {
      int checkSplit = 0;
      for (var row in result) {
        if (row['dutyStatus'] == 3 || row['dutyStatus'] == 4) {
          sum += row['duration'] as num;
          if (sum >= 2 * 3600 && sum < 3 * 3600) {
            if (startTimeOfFirstRest.isEmpty) {
              startTimeOfFirstRest = row['startTime'].toString();
              filteredResult.clear();
              splitSleeper = 2;
              checkSplit = 2;
            }
            filteredResult.add(row);
          }
        } else {
          if(checkSplit == 0) {
            startTimeOfFirstRest = "";
            sum = 0;
          }
          filteredResult.add(row);
        }
      }
    }
    if(splitCheck == 3 && splitSleeper == 0){
      int checkSplit = 0;
      for (var row in result) {
        if (row['dutyStatus'] == 3 || row['dutyStatus'] == 4) {
          sum += row['duration'] as num;
          if (sum >= 3 * 3600 && sum < 7 * 3600) {
            if (startTimeOfFirstRest.isEmpty) {
              startTimeOfFirstRest = row['startTime'].toString();
              filteredResult.clear();
              splitSleeper = 3;
              checkSplit = 3;
            }
            filteredResult.add(row);
          }
        } else {
          if(checkSplit == 0) {
            startTimeOfFirstRest = "";
            sum = 0;
          }
          filteredResult.add(row);
        }
      }
    }
    if(splitCheck == 7 && splitSleeper == 0){
      int checkSplit = 0;
      for (var row in result) {
        if (row['dutyStatus'] == 3 || row['dutyStatus'] == 4) {
          sum += row['duration'] as num;
          if (sum >= 7 * 3600 && sum < 8 * 3600) {
            if (startTimeOfFirstRest.isEmpty) {
              startTimeOfFirstRest = row['startTime'].toString();
              filteredResult.clear();
              splitSleeper = 7;
              checkSplit = 7;
            }
          }
          filteredResult.add(row);
        } else {
          if(checkSplit == 0) {
            startTimeOfFirstRest = "";
            sum = 0;
          }
          filteredResult.add(row);
        }
      }
    }
    if(splitCheck == 8 && splitSleeper == 0){
      int checkSplit = 0;
      for (var row in result) {
        if (row['dutyStatus'] == 3 || row['dutyStatus'] == 4) {
          sum += row['duration'] as num;
          if (sum >= 8 * 3600 && sum < 10 * 3600) {
            if (startTimeOfFirstRest.isEmpty) {
              startTimeOfFirstRest = row['startTime'].toString();
              filteredResult.clear();
              splitSleeper = 8;
              checkSplit = 8;
            }
          }
          filteredResult.add(row);
        } else {
          if(checkSplit == 0) {
            startTimeOfFirstRest = "";
            sum = 0;
          }
          filteredResult.add(row);
        }
      }
    }

    return {
      'splitSleeper': splitSleeper,
      'filteredResult': filteredResult,
      'startTimeOfRest':startTimeOfFirstRest
    };
  }
  String findEarliestStartTime(List<String> startTimes) {
    List<String> validTimes = startTimes.where((time) => time.isNotEmpty).toList();
    if (validTimes.isEmpty) return "";
    validTimes.sort(); // ISO 8601 date-time strings can be sorted lexicographically
    return validTimes.first;
  }


  Map<String, dynamic> checkSplit(List<Map<String, Object?>> result) {
    int splitSleeper = 0;
    List<Map<String, dynamic>> filteredResult = [];
    String startTimeOfFirstRest = "";

    // Check split for different hours
    Map<String, dynamic> resultData_2 = checkSplitNow(2, 3, result);
    String startTimeOfFirstRest_hours_2 = resultData_2['startTimeOfFirstRest'];

    Map<String, dynamic> resultData_3 = checkSplitNow(3, 7, result);
    String startTimeOfFirstRest_hours_3 = resultData_3['startTimeOfFirstRest'];

    Map<String, dynamic> resultData_7 = checkSplitNow(7, 8, result);
    String startTimeOfFirstRest_hours_7 = resultData_7['startTimeOfFirstRest'];

    Map<String, dynamic> resultData_8 = checkSplitNow(8, 10, result);
    String startTimeOfFirstRest_hours_8 = resultData_8['startTimeOfFirstRest'];

    // Find the earliest start time among all
    startTimeOfFirstRest = findEarliestStartTime([
      startTimeOfFirstRest_hours_2,
      startTimeOfFirstRest_hours_3,
      startTimeOfFirstRest_hours_7,
      startTimeOfFirstRest_hours_8
    ]);
    if(startTimeOfFirstRest == startTimeOfFirstRest_hours_2){
      filteredResult = resultData_2['filteredResult'];
      startTimeOfFirstRest = resultData_2['startTimeOfFirstRest'];
      splitSleeper = resultData_2['splitSleeper'];
    }
    else if(startTimeOfFirstRest == startTimeOfFirstRest_hours_3){
      filteredResult = resultData_3['filteredResult'];
      startTimeOfFirstRest = resultData_3['startTimeOfFirstRest'];
      splitSleeper = resultData_3['splitSleeper'];
    }
    else if(startTimeOfFirstRest == startTimeOfFirstRest_hours_7){
      filteredResult = resultData_7['filteredResult'];
      startTimeOfFirstRest = resultData_7['startTimeOfFirstRest'];
      splitSleeper = resultData_7['splitSleeper'];
    }
    else if(startTimeOfFirstRest == startTimeOfFirstRest_hours_8){
      filteredResult = resultData_8['filteredResult'];
      startTimeOfFirstRest = resultData_8['startTimeOfFirstRest'];
      splitSleeper = resultData_8['splitSleeper'];
    }
    return {
      'splitSleeper': splitSleeper,
      'filteredResult': filteredResult,
      'startTimeOfRest': startTimeOfFirstRest
    };
  }




  String findCurrentRestStartTime(List<Map<String, Object?>> result) {
    String lastStartTime = "";
    List<Map<String, dynamic>> filteredResult = [];
    num sum = 0;
    for (var row in result) {
      if (row['dutyStatus'] == 3 || row['dutyStatus'] == 4) {
        sum += row['duration'] as num;
        lastStartTime = row['startTime'].toString();
      }
      else{
        lastStartTime = "";
        sum = 0;
        filteredResult.add(row);
      }
    }
    return lastStartTime;
  }

  Map<String, dynamic> checkSplitNow(int checkSplit, int maxTime, List<Map<String, Object?>> result) {
    List<Map<String, dynamic>> filteredResult = [];
    num sum = 0;
    int splitSleeper = 0;
    String startTimeOfFirstRest = "";
    for (var row in result) {
      if (row['dutyStatus'] == 3 || row['dutyStatus'] == 4) {
        sum += row['duration'] as num;
        if (sum >= checkSplit * 3600 && sum < maxTime * 3600) {
          if (startTimeOfFirstRest.isEmpty) {
            splitSleeper = checkSplit;
            startTimeOfFirstRest = row['startTime'].toString();
          }
          filteredResult.clear();
        }
        filteredResult.add(row);
      } else {
        if(splitSleeper == 0) {
          startTimeOfFirstRest = "";
          sum = 0;
        }
        filteredResult.add(row);
      }
    }

    return {
      'filteredResult': filteredResult,
      'startTimeOfFirstRest': startTimeOfFirstRest,
      'splitSleeper': splitSleeper,
    };
  }

}

const String tableDutyStatus = 'dutyStatus';
const String tableWSResponse = 'WSResponseTable';
