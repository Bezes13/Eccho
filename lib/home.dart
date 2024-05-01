import 'package:Eccho/entry.dart';
import 'package:flutter/material.dart';

import 'package:Eccho/local_notifications.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

import 'AppState.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Day> selectedDays = [];
  int hour = 12;
  int minute = 30;
  String newTitle = "";

  @override
  void initState() {
    listenToNotifications();
    super.initState();
  }

  listenToNotifications() {
    LocalNotifications.onClickNotification.stream.listen((event) {
      Navigator.pushNamed(context, '/another', arguments: event);
    });
  }

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Eccho")),
      body: SizedBox(
        height: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                title: TextField(
                  controller: TextEditingController(text: newTitle),
                  onChanged: (value) {
                    newTitle = value;
                  },
                  textAlign: TextAlign.center,
                ),
                onTap: () {},
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NumberPicker(
                    value: hour,
                    minValue: 0,
                    maxValue: 23,
                    onChanged: (value) => setState(() => hour = value),
                    infiniteLoop: true,
                  ),
                  const Text(":"),
                  NumberPicker(
                    value: minute,
                    minValue: 0,
                    maxValue: 59,
                    onChanged: (value) => setState(() => minute = value),
                    infiniteLoop: true,
                  ),
                ],
              ),
              Wrap(
                spacing: 0.0,
                children: Day.values
                    .map((day) => FilterChip(
                    label: Text(day.short),
                    showCheckmark: false,
                    selected: selectedDays.contains(day),
                    onSelected: (a) => {
                      setState(() {
                        if (selectedDays.contains(day)) {
                          selectedDays.remove(day);
                        } else {
                          selectedDays.add(day);
                        }
                      })
                    }))
                    .toList(),
              ),
              ElevatedButton(
                  onPressed: () async {
                    Navigator.pushNamed(context, "/another");
                    await LocalNotifications.showScheduleNotification(
                        title: newTitle,
                        body: "Just do it!",
                        hours: hour,
                        minutes: minute,
                        days: selectedDays,
                        appState: appState
                        );
                  },
                  child: const Text("Save")),
            ],
          ),
        ),
      ),
    );
  }
}
