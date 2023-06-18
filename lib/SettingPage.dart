import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ... قائمة اللغات
            // ... خيارات أخرى

            Divider(),

            Text(
              'Dark Mode',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Consumer<ThemeProvider>(
              builder: (context, themeProvider, _) => Row(
                children: [
                  Text('Off'),
                  Switch(
                    value: themeProvider.isDarkMode,
                    onChanged: (value) {
                      themeProvider.isDarkMode = value; // تحديث وضع الليلي في مقدم الخدمة
                    },
                  ),
                  Text('On'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
