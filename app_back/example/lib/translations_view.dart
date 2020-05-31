import 'package:app_back/app_back.dart';
import 'package:app_back/exceptions/app_back_exception.dart';
import 'package:app_back/models/translation.dart';
import 'package:flutter/material.dart';

class TranslationsView extends StatefulWidget {
    @override
    _TranslationsViewState createState() => _TranslationsViewState();
}

class _TranslationsViewState extends State<TranslationsView> {
    
    List<Translation> _translations = [];
    
    void _onSuccess(List<Translation> translations) {
        setState(() {
            _translations = translations;
        });
    }
    
    void _onFailure(AppBackException appBackException) {
        print(appBackException.reason);
    }
    
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: Column(
                children: [
                    Expanded(
                        flex: 14,
                        child: ListView.builder(
                            itemCount: _translations.length,
                            itemBuilder: (_, index) =>
                                ListTile(
                                    title: Text(_translations[index].key),
                                    subtitle: Text(_translations[index].value),
                                )
                        ),
                    ),
                    Expanded(
                        flex: 1,
                        child: RaisedButton(
                            child: Text('Fetch translations'),
                            onPressed: () => AppBack.instance.getTranslations("translations_flutter_test", "en_US", _onSuccess, _onFailure)
                        ),
                    ),
                    Padding(padding: EdgeInsets.all(8))
                ],
            ),
        );
    }
}
