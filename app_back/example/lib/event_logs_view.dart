import 'package:appback_sdk/app_back.dart';
import 'package:appback_sdk/exceptions/app_back_exception.dart';
import 'package:flutter/material.dart';

class EventLogsView extends StatefulWidget {
    @override
    _EventLogsViewState createState() => _EventLogsViewState();
}

class _EventLogsViewState extends State<EventLogsView> {
    TextEditingController _controller1 = TextEditingController();
    TextEditingController _controller2 = TextEditingController();
    TextEditingController _controller3 = TextEditingController();
    
    void _onSuccess() {
        final snackBar = SnackBar(content: Text('Event Logged!'));
        Scaffold.of(context).showSnackBar(snackBar);
    }
    
    void _onFailure(AppBackException appBackException) {
        final snackBar = SnackBar(content: Text('Event Not Logged!\n${appBackException.reason}'));
        Scaffold.of(context).showSnackBar(snackBar);
    }
    
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: Center(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                        TextField(
                            controller: _controller1,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter value 1"
                            ),
                        ),
                        TextField(
                            controller: _controller2,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter value 2"
                            ),
                        ),
                        TextField(
                            controller: _controller3,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter value 3"
                            ),
                        ),
                    ],
                ),
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: () => AppBack.instance.addEventLog(
                    "event_logs_flutter_test",
                    "fabTapped",
                    { "key1": _controller1.text, "key2": _controller2.text, "key3": _controller3.text },
                    _onSuccess,
                    _onFailure,
                ),
            ),
        );
    }
}
