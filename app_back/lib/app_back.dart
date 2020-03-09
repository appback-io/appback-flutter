library app_back;
import 'package:app_back/exceptions/app_back_exception.dart';
import 'package:app_back/models/toggle.dart';
import 'package:app_back/models/token.dart';
import 'package:app_back/models/translation.dart';
import 'package:app_back/repository/auth/i_token_repository.dart';
import 'package:app_back/repository/auth/token_repository.dart';
import 'package:app_back/repository/toggle/i_toggle_repository.dart';
import 'package:app_back/repository/toggle/toggle_repository.dart';
import 'package:app_back/repository/translation/i_translation_repository.dart';
import 'package:app_back/repository/translation/translation_repository.dart';
import 'package:flutter/foundation.dart';

/// Class that contains the public API for the Flutter library. This is a singleton and it's the entry point of
/// the Flutter AppBack SDK.
/// Author: nicdamun

class AppBack {
    static final AppBack instance = AppBack._();
    Token _token;
    ITokenRepository _tokenRepository;
    ITranslationRepository _translationRepository;
    IToggleRepository _toggleRepository;
    
    AppBack._() {
        _tokenRepository = TokenRepository();
        _translationRepository = TranslationRepository();
        _toggleRepository = ToggleRepository();
    }
    
    /// This method configures the instance of [AppBack] by identifying the current session with
    /// the [secretKey].
    Future<void> configure(String secretKey) async {
        try {
            _token = await _tokenRepository.getToken(secretKey);
        } on AppBackException catch (error) {
            debugPrint(error.reason);
            throw error;
        }
    }
    
    /// Gets the translations of [router]
    /// [onSuccess] called when the translations were successfully retrieved and contains the list as an argument.
    /// [onFailure] called when there was an error getting the translations and a [AppBackException] with more information is returned.
    void getTranslations(String router, Function(List<Translation>) onSuccess, Function(AppBackException) onFailure) {
        _translationRepository.getTranslations(_token?.accessToken ?? "", router, onSuccess, onFailure);
    }

    /// Gets the toggles of [router]
    /// [onSuccess] called when the toggles were successfully retrieved and contains the list as an argument.
    /// [onFailure] called when there was an error getting the toggles and a [AppBackException] with more information is returned.
    void getToggles(String router, Function(List<Toggle>) onSuccess, Function(AppBackException) onFailure) {
        _toggleRepository.getToggles(_token?.accessToken ?? "", router, onSuccess, onFailure);
    }
}