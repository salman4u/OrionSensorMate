import 'dart:async';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../components/background_service.dart';

class EditPgnController extends GetxController {
  var pgns = <Map<String, dynamic>>[].obs;
  var freqControllers = <TextEditingController>[].obs;
  final storageKey = 'saved_pgns';

  @override
  void onInit() {
    super.onInit();
    _loadPgns();
     Timer(const Duration(seconds: 3), () {
       ever(pgns, (_) async {
         await savePgns();
         BackgroundService().onPgnsUpdated(pgns);
       });      // Perform actions here
    });

  }

  /// Load PGNs from SharedPreferences
  Future<void> _loadPgns() async {
    final prefs = await SharedPreferences.getInstance();
    String? saved = prefs.getString(storageKey);

    List<Map<String, dynamic>> initialList;

    if (saved != null) {
      List<dynamic> decoded = jsonDecode(saved);
      initialList = decoded
          .map((e) => {"pgn": e["pgn"], "freq": e["freq"]})
          .toList();
    } else {
       final initialPgns = [
        65263, 65520, 65265, 65132, 65215, 65256,
        65267, 65262, 65266, 65253, 65217, 65260,
        65248, 60416, 60160, 65210, 64914, 65134,
        65206, 65269, 65279, 65271, 65268
      ];
      initialList = initialPgns.map((pgn) => {"pgn": pgn, "freq": 10}).toList();
    }

    pgns.value = initialList;
    freqControllers.value = pgns
        .map((e) => TextEditingController(text: e["freq"].toString()))
        .toList();

    _sortPgns();
  }

  void updateFrequency(int index, String value) {
    int freq = int.tryParse(value) ?? 10;
    pgns[index]["freq"] = freq;
    savePgns(); // Auto-save after change
  }

  void deletePgn(int index) {
    pgns.removeAt(index);
    freqControllers.removeAt(index);
    _sortPgns();
    savePgns();
  }

  int addPgn(int pgn, int freq) {
    pgns.add({"pgn": pgn, "freq": freq});
    freqControllers.add(TextEditingController(text: freq.toString()));
    _sortPgns();
    savePgns();
    return pgns.indexWhere((element) => element["pgn"] == pgn);
  }

  /// Save PGNs into SharedPreferences
  Future<void> savePgns() async {
    final prefs = await SharedPreferences.getInstance();
    String encoded = jsonEncode(pgns);
    await prefs.setString(storageKey, encoded);
    BackgroundService().onPgnsUpdated(pgns);

  }

  void _sortPgns() {
    final combined = List.generate(
      pgns.length,
          (i) => {
        "pgn": pgns[i]["pgn"],
        "freq": pgns[i]["freq"],
        "controller": freqControllers[i]
      },
    );

    combined.sort((a, b) => (a["pgn"] as int).compareTo(b["pgn"] as int));

    pgns.value =
        combined.map((e) => {"pgn": e["pgn"], "freq": e["freq"]}).toList();
    freqControllers.value =
        combined.map((e) => e["controller"] as TextEditingController).toList();
  }
}

