# Flutter AppBack Feature Toggles
Whenever you need to update the list of feature toggles and values registered in your AppBack dashboard you can use the getToggles method. This method will require a router, if you don't know what a router is check out [Key Concepts on our Overview](https://appback.io/docs/1.0/overview#concepts)

### Fetch Feature Toggles
First add our SDK to your pubspec.yaml file

```text
AppBack.instance.getTranslations("MY_ROUTER", "MY_LANGUAGE_ID", _onSuccess, _onFailure)
```

As you can see, there are some closures called `_onSuccess` and `_onFailure` which will be handle the possible responses from the `getTranslations` method.
The first one receives a list of `Translation` containing all the necessary information about a certain translation and the other one will receive an `AppBackException` containing an error message.

### Example
```text
class TranslationsView extends StatefulWidget {
    @override
    _TranslationsViewState createState() => _TranslationsViewState();
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

**NOTE:** You must have a router previously defined in the [AppBack Dashboard](https://appback.io/).

## Next Steps
That's it, you can now proceed to our modules guide.

- [Translations](translations.md)
- [Event Logs](event_logs.md)
