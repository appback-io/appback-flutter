import 'dart:convert';

import 'package:app_back/constants/constants.dart';
import 'package:app_back/dtos/translation_parent_dto.dart';
import 'package:app_back/exceptions/app_back_exception.dart';
import 'package:app_back/helpers/network_helper.dart';
import 'package:app_back/interactors/translation_interactor.dart';
import 'package:app_back/models/translation.dart';
import 'package:app_back/repository/translation/i_translation_repository.dart';
import 'package:http/http.dart' as http;

class TranslationRepository implements ITranslationRepository {
    
    final _client = http.Client();
    
    @override
    void getTranslations(String router, Function(List<Translation>) onSuccess, Function(AppBackException) onFailure) {
        _client.get("$kTRANSLATIONS_URL$router", headers: getAuthHeader()).then((response) {
            if (response.statusCode == 200) {
                final jsonResponse = jsonDecode(response.body);
                TranslationParentDto translationParentDto = TranslationParentDto.fromJson(jsonResponse["translations"]);
                List<Translation> translations = translationParentDto.translations.map((translationDto) =>
                    TranslationInteractor.convertTranslationDtoToTranslationModel(translationDto))
                    .toList();
                onSuccess(translations);
            } else if (response.statusCode == 400) {
                onFailure(AppBackException(response.statusCode, "Bad request"));
            } else if (response.statusCode == 404) {
                onFailure(AppBackException(response.statusCode, "Resource Not Found"));
            }
        }).catchError((error) {
            onFailure(AppBackException(0, error.toString()));
        });
    }
}