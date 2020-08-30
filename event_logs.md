# Flutter Event Logs

To use the Event Logs functionality you need to have your SDK configured, if you haven't do so, check out [Installing SDK](README.md)

### Send Event Log

There are times when you want to track your user's events to improve your own product and provide a better user experience.
AppBack can give you a hand with this.

To send an event log we must to the following.
```text
AppBack.instance.addEventLog(
                    "MY_ROUTER",
                    "EVENT_NAME",
                    { 
                        "key1": _controller1.text, 
                        "key2": _controller2.text, 
                        "key3": _controller3.text 
                    },
                    _onSuccess,
                    _onFailure,
                    deviceInformation: true // Default value
                ),
```

**NOTE:** You must have a router previously defined in the [AppBack Dashboard](https://appback.io/).

Where `_controller1`, `_controller2` and `_controller3` are set to some `TextField` widgets for this example like below:

```
TextField(
    controller: _controller1,
    decoration: InputDecoration(
        border: InputBorder.none,
        hintText: "Enter value 1"
    ),
)
```

As you can see, there are some closures called `_onSuccess` and `_onFailure` which will handle the possible responses from the `addEventLog` method.
The first one indicates that the event was successfully sent to AppBack and the other one will receive an `AppBackException` containing an error message.

The `deviceInformation` parameter is used to send the following information about the device.

For iOS:

| Key              | Example                              |
| ---------------- | ------------------------------------ |
| _system_version  | 13.5                                 |
| _app_version     | 1.0 (1)                              |
| _device          | iPhone X                             |
| _orientation     | Portrait                             |
| _storage         | 17,33 GB / 63,93 GB                  |
| _device_ID       | 8B977100-7547-46F4-979C-FAABC4AF104A |
| _battery_level   | 73 %                                 |
| _carrier         | ETB 4G                               |
| _connection_type | WIFI                                 |

For Android:

| Key              | Example                              |
| ---------------- | ------------------------------------ |
| _system_version  | 10                                   |
| _app_version     | 1.0 (1)                              |
| _device          | samsung SM-G975F                     |
| _orientation     | Portrait                             |
| _storage         | 52.15 GB / 118.03 GB                 |
| _device_ID       | 8B977100-7547-46F4-979C-FAABC4AF104A |
| _battery_level   | 78 %                                 |
| _carrier         | Claro                                |
| _connection_type | WIFI                                 |

### Example
```text
class EventLogsView extends StatefulWidget {
    @override
    _EventLogsViewState createState() => _EventLogsViewState();
}

class _EventLogsViewState extends State<EventLogsView> {
        void _onSuccess() {
            final snackBar = SnackBar(content: Text('Event Logged!'));
            Scaffold.of(context).showSnackBar(snackBar);
        }
                
        void _onFailure(AppBackException appBackException) {
            final snackBar = SnackBar(content: Text('Event Not Logged!\n${appBackException.reason}'));
            Scaffold.of(context).showSnackBar(snackBar);
        }
    }
```

## Next Steps
That's it, you can now proceed to our modules guide.

- [Feature Toggles](feature_toggles.md)
- [Translations](translations.md)
