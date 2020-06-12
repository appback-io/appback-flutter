import 'package:appback/app_back.dart';
import 'package:flutter/material.dart';
import 'package:hello_example/event_logs_view.dart';

import 'toggles_view.dart';
import 'translations_view.dart';

void main() async {
    AppBack.instance.configure("YOUR_API_KEY");
    runApp(AppBackExample());
}

class AppBackExample extends StatefulWidget {
    @override
    _AppBackExampleState createState() => _AppBackExampleState();
}

class _AppBackExampleState extends State<AppBackExample> {
    
    int _currentIndex = 0;
    
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            home: Scaffold(
                body: _getCurrentScreen(),
                bottomNavigationBar: BottomNavigationBar(
                    items: <BottomNavigationBarItem>[
                        BottomNavigationBarItem(
                            icon: Icon(Icons.translate),
                            title: Text('Translations'),
                        ),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.power_settings_new),
                            title: Text('Toggles'),
                        ),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.event_note),
                            title: Text('Event Log'),
                        ),
                    ],
                    currentIndex: _currentIndex,
                    onTap: (newIndex) => setState(() => _currentIndex = newIndex),
                ),
            ),
        );
    }
    
    Widget _getCurrentScreen() {
        switch(_currentIndex) {
            case 0:
                return TranslationsView();
            case 1:
                return TogglesView();
            case 2:
                return EventLogsView();
            default:
                return TranslationsView();
        }
    }
}