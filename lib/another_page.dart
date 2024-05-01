

import 'package:Eccho/AppState.dart';
import 'package:Eccho/entry.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AnotherPage extends StatelessWidget {
  const AnotherPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final data = ModalRoute.of(context)!.settings.arguments;
    var appState = Provider.of<AppState>(context);
    final itemStyle = theme.textTheme.displayMedium!;
    return Scaffold(

      appBar: AppBar(title: Text("Eccho")),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: appState.entries.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(appState.entries[index].title,
                                style: itemStyle),
                            onTap: () {},
                          ),
                          Text(
                              "${appState.entries[index].hour}:  ${appState.entries[index].minute}"),
                          Wrap(
                            spacing: 0.0,
                            children: Day.values
                                .map((day) => FilterChip(
                                label: Text(day.short),
                                onSelected: (a) => {}))
                                .toList(),
                          )
                        ],
                      ),
                    );
                  }))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add Entry',
        child: const Icon(Icons.add),
      ),
    );
  }
}
