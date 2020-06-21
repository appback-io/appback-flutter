# Flutter Feature Toggles

To use the Feature Toggles functionality you need to have your SDK configured, if you haven't do so, check out [Installing SDK](README.md).

## Configure Initial Call

Whenever you need to update the list of feature toggles and values registered in your AppBack dashboard you can use the getToggles method. This method will require a router, if you don't know what a router is check out [Key Concepts on our Overview](https://appback.io/docs/1.0/overview#concepts)

```text
AppBack.instance.getToggles("MY_ROUTER", _onSuccess, _onFailure)
```

**NOTE:** You must have a router previously defined in the [AppBack Dashboard](https://appback.io/).

As you can see, there are some closures called `_onSuccess` and `_onFailure` which will be handle the possible responses from the `getToggles` method.
The first one receives a list of `Toggle` containing all the necessary information about a certain toggle and the other one will receive an `AppBackException` containing an error message.

### Example
```text
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
}
```

## Next Steps
That's it, you can now proceed to our modules guide.

- [Event Logs](event_logs.md)
- [Translations](translations.md)