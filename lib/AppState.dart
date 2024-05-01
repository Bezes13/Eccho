import 'dart:convert';

import 'package:Eccho/entry.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends ChangeNotifier {
  List<Entry> entries = [];
  int nextNotificationId = 0;
  Future<void> loadEntries() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? entriesJson = prefs.getStringList('entries');
    if (entriesJson != null) {
      entries = entriesJson
          .map((e) => Entry.fromJson((jsonDecode(e)) as Map<String, dynamic>))
          .toList();
    }
    nextNotificationId = prefs.getInt('notificationId')?? 0;
    notifyListeners();
  }

  Future<void> saveEntries() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> entriesJson = entries.map((entry) => jsonEncode(entry)).toList();
    await prefs.setStringList('entries', entriesJson);
    await prefs.setInt('notificationId', nextNotificationId);
  }

  void saveNotification(String title, int hours, int minutes, List<Day> days, List<int> ids, int nextID) {
    entries.add(Entry(title, days.map((e) => e.id).toList(), true, hours, minutes, ids));
    nextNotificationId = nextID;
    saveEntries();
  }
}
