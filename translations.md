# Flutter AppBack Translations

Translations are useful when you upload your app to the AppStore or PlayStore but you want to change a string copy without the struggle of re-uploading it again.

### Fetch Translations

```text
AppBack.instance.getToggles("MY_ROUTER", _onSuccess, _onFailure)
```

As you can see, there are some closures called `_onSuccess` and `_onFailure` which will be handle the possible responses from the `getToggles` method.
The first one receives a list of `Toggle` containing all the necessary information about a certain toggle and the other one will receive an `AppBackException` containing an error message.

### Example
```text
class TogglesView extends StatefulWidget {
    @override
    _TogglesViewState createState() => _TogglesViewState();
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
    }
```

**NOTE:** You must have a router previously defined in the [AppBack Dashboard](https://appback.io/).

## Next Steps
That's it, you can now proceed to our modules guide.

- [Feature Toggles](feature_toggles.md)
- [Event Logs](event_logs.md)
