import 'package:appback/app_back.dart';
import 'package:appback/exceptions/app_back_exception.dart';
import 'package:appback/models/toggle.dart';
import 'package:flutter/material.dart';

class TogglesView extends StatefulWidget {
    @override
    _TogglesViewState createState() => _TogglesViewState();
}

class _TogglesViewState extends State<TogglesView> {
    List<Toggle> _toggles = [];
    
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
            body: Column(
                children: [
                    Expanded(
                        flex: 14,
                        child: ListView.builder(
                            itemCount: _toggles.length,
                            itemBuilder: (_, index) =>
                                ListTile(
                                    title: Text(_toggles[index].key),
                                    subtitle: Text(_toggles[index].value.toString()),
                                )
                        ),
                    ),
                    Expanded(
                        flex: 1,
                        child: RaisedButton(
                            child: Text('Fetch toggles'),
                            onPressed: () => AppBack.instance.getToggles("toggles_flutter_test", _onSuccess, _onFailure)
                        ),
                    ),
                    Padding(padding: EdgeInsets.all(8))
                ],
            ),
        );
    }
}