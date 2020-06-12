library appback;
import 'package:appback/exceptions/app_back_exception.dart';
import 'package:appback/models/auth.dart';
import 'package:appback/models/endpoint.dart';
import 'package:appback/models/toggle.dart';
import 'package:appback/models/token.dart';
import 'package:appback/models/translation.dart';
import 'package:appback/src/repository/auth/i_token_repository.dart';
import 'package:appback/src/repository/auth/token_repository.dart';
import 'package:appback/src/repository/logger/i_logger_repository.dart';
import 'package:appback/src/repository/logger/logger_repository.dart';
import 'package:appback/src/repository/toggle/i_toggle_repository.dart';
import 'package:appback/src/repository/toggle/toggle_repository.dart';
import 'package:appback/src/repository/translation/i_translation_repository.dart';
import 'package:appback/src/repository/translation/translation_repository.dart';
import 'package:appback/src/helpers/event_log_mapper.dart';

/// Class that contains the public API for the Flutter library. This is a singleton and it's the entry point of
/// the Flutter AppBack SDK.
/// Author: nicdamun

class AppBack {
    static final AppBack instance = AppBack._();
    Endpoint _endpoint;
    Token _token;
    ITokenRepository _tokenRepository;
    IToggleRepository _toggleRepository;
    ITranslationRepository _translationRepository;
    ILoggerRepository _loggerRepository;
    
    AppBack._() {
        _tokenRepository = TokenRepository();
        _translationRepository = TranslationRepository();
        _toggleRepository = ToggleRepository();
        _loggerRepository = LoggerRepository();
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
    
    void addEventLog(String router, String eventName, Map<String, String> parameters, Function onSuccess, Function(AppBackException) onFailure, {bool deviceInformation = true} ) {
        checkAppBackIsConfigured();
        EventLogMapper.mapParameters(eventName, router, parameters, deviceInformation)
            .then((mappedParameters) => _loggerRepository.logEvent(_endpoint?.url, _token?.accessToken, mappedParameters, onSuccess, onFailure))
            .catchError((error) => onFailure(AppBackException(error.toString())));
    }
    
    void _onAppBackConfigured(Auth auth) {
        _token = auth.token;
        _endpoint = auth.endpoint;
    }
}