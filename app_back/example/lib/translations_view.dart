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
    
    @override
    void initState() {
        AppBack.instance.getTranslations("flutter_colombia_translations", _onSuccess, _onFailure);
        super.initState();
    }
    
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
            body: Center(
                child: ListView.builder(
                    itemCount: _translations.length,
                    itemBuilder: (_, index) =>
                        ListTile(
                            title: Text(_translations[index].key),
                            subtitle: Text(_translations[index].value),
                        )
                ),
            ),
        );
    }
}
