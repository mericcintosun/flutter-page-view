import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notificationsEnabled = true;
  bool darkMode = false;
  bool fingerPrintEnabled = false;
  bool autoSync = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ExpansionTile(
            title: Text('Notifications'),
            children: [
              SwitchListTile(
                title: Text('Notifications'),
                value: notificationsEnabled,
                onChanged: (value) {
                  setState(() {
                    notificationsEnabled = value;
                  });
                },
              ),
              SwitchListTile(
                title: Text('Dark Mode'),
                value: darkMode,
                onChanged: (value) {
                  setState(() {
                    darkMode = value;
                  });
                },
              ),
            ],
          ),
          ExpansionTile(
            title: Text('Notifications'),
            children: [
              SwitchListTile(
                title: Text('Notifications'),
                value: notificationsEnabled,
                onChanged: (value) {
                  setState(() {
                    notificationsEnabled = value;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
