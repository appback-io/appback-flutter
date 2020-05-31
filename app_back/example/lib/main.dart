import 'package:app_back/app_back.dart';
import 'package:example/toggles_view.dart';
import 'package:example/translations_view.dart';
import 'package:flutter/material.dart';

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
            default:
                return TranslationsView();
        }
    }
}
