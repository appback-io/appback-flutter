## Configure Initial Call
Flutter SDK is implemented through the pubspec.yaml. If you are not familiar with Flutter/Dart packages, check them out [here](https://pub.dev).

1. First add our SDK to your pubspec.yaml file

```text
dependencies:
    appback_sdk: ^0.0.1+1
```

2. Run from the terminal

```text
$ flutter pub get
```

## Configure the SDK

Open your `main.dart` file since we want AppBack to be ready as soon as your app starts.

And add the configure method from AppBack to your `main` method like this:

```text
void main() {
    AppBack.instance.configure("YOUR_API_KEY");
    runApp(AppBackExample());
}
```

As you see above, the method expect an API Key, you can grab one from the dashboard, more information [here](https://appback.io/docs/1.0/apiKeys)

## Next Steps
That's it, you can now proceed to our modules guide.

- [Feature Toggles](feature_toggles.md)
- [Translations](translations.md)
- [Event Logs](event_logs.md)
