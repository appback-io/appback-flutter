# Flutter Translations

To use the Translations functionality you need to have your SDK configured, if you haven't do so, check out [Installing SDK](README.md)

## Fetch Translations

Translations are useful when you upload your app to the AppStore or PlayStore but you want to change a string copy without the struggle of re-uploading it again.
To get translations of a language, use the following method:

```text
AppBack.instance.getTranslations("MY_ROUTER", "MY_LANGUAGE_ID", _onSuccess, _onFailure)
```

**NOTE:** You must have a router previously defined in the [AppBack Dashboard](https://appback.io/).

As you can see, there are some closures called `_onSuccess` and `_onFailure` which will handle the possible responses from the `getTranslations` method.
The first one receives a list of `Translation` containing all the necessary information about a certain translation and the other one will receive an `AppBackException` containing an error message.

### Example
```text
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
}
```

## Next Steps
That's it, you can now proceed to our modules guide.

- [Event Logs](event_logs.md)
- [Feature Toggles](feature_toggles.md)

