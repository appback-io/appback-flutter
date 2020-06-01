library app_back;
import 'package:app_back/exceptions/app_back_exception.dart';
import 'package:app_back/models/auth.dart';
import 'package:app_back/models/endpoint.dart';
import 'package:app_back/models/toggle.dart';
import 'package:app_back/models/token.dart';
import 'package:app_back/models/translation.dart';
import 'package:app_back/repository/auth/i_token_repository.dart';
import 'package:app_back/repository/auth/token_repository.dart';
import 'package:app_back/repository/toggle/i_toggle_repository.dart';
import 'package:app_back/repository/toggle/toggle_repository.dart';
import 'package:app_back/repository/translation/i_translation_repository.dart';
import 'package:app_back/repository/translation/translation_repository.dart';
import 'package:flutter/services.dart';

/// Class that contains the public API for the Flutter library. This is a singleton and it's the entry point of
/// the Flutter AppBack SDK.
/// Author: nicdamun

class AppBack {
    static final AppBack instance = AppBack._();
    static const platform = const MethodChannel('appback.io/battery');
    Endpoint _endpoint;
    Token _token;
    ITokenRepository _tokenRepository;
    IToggleRepository _toggleRepository;
    ITranslationRepository _translationRepository;
    
    AppBack._() {
        _tokenRepository = TokenRepository();
        _translationRepository = TranslationRepository();
        _toggleRepository = ToggleRepository();
    }

    void checkAppBackIsConfigured() {
        if (_endpoint == null || _token == null) {
            throw AppBackException("AppBack is not initialized.\nEnsure secretKey is correct.");
        }
    }
    
    /// This method configures the instance of [AppBack] by identifying the current session with
    /// the [secretKey].
    /// Throws an [AppBackException] for the following reasons:
    /// 400 There was a 'Bad request',
    /// 404 The resource was not found, this happens e.g when the api router identifier doesn't exist.
    void configure(String apiKey) =>
        _tokenRepository.getToken(apiKey, _onAppBackConfigured);

    /// Gets the toggles of [router]
    /// [onSuccess] called when the toggles were successfully retrieved and contains the list as an argument.
    /// [onFailure] called when there was an error getting the toggles and a [AppBackException] with more information is returned.
    void getToggles(String router, Function(List<Toggle>) onSuccess, Function(AppBackException) onFailure) {
        checkAppBackIsConfigured();
        _toggleRepository.getToggles(_endpoint?.url, _token?.accessToken, router, onSuccess, onFailure);
    }
    
    /// Gets the translations of [router]
    /// [onSuccess] called when the translations were successfully retrieved and contains the list as an argument.
    /// [onFailure] called when there was an error getting the translations and a [AppBackException] with more information is returned.
    void getTranslations(String router, String languageIdentifier, Function(List<Translation>) onSuccess, Function(AppBackException) onFailure) {
        checkAppBackIsConfigured();
        _translationRepository.getTranslations(_endpoint?.url, _token?.accessToken, router, languageIdentifier, onSuccess, onFailure);
    }
    
    void logEvent() {
        //checkAppBackIsConfigured();
        _getBatteryLevel();
    }
    
    void _getBatteryLevel() async {
        String batteryLevel;
        try {
            final int result = await platform.invokeMethod('getBatteryLevel');
            batteryLevel = 'Battery level at $result%.';
        } on PlatformException catch (error) {
            batteryLevel = "Failed to get battery level: '${error.message}'";
        }
        print(batteryLevel);
    }
    
    void _onAppBackConfigured(Auth auth) {
        _token = auth.token;
        _endpoint = auth.endpoint;
    }
}