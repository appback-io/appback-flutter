import 'package:app_back/app_back.dart';
import 'package:app_back/exceptions/app_back_exception.dart';
import 'package:app_back/models/toggle.dart';
import 'package:flutter/material.dart';

class TogglesView extends StatefulWidget {
    @override
    _TogglesViewState createState() => _TogglesViewState();
}

class _TogglesViewState extends State<TogglesView> {
    List<Toggle> _toggles = [];
    
    @override
    void initState() {
        AppBack.instance.getToggles("flutter_colombia_toggles", _onSuccess, _onFailure);
        super.initState();
    }
    
    void _onSuccess(List<Toggle> toggles) {
        setState(() {
            _toggles = toggles;
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
                    itemCount: _toggles.length,
                    itemBuilder: (_, index) =>
                        ListTile(
                            title: Text(_toggles[index].key),
                            subtitle: Text(_toggles[index].value.toString()),
                        )
                ),
            ),
        );
    }
}
