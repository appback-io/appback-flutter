import 'dart:convert';

import 'package:appback/src/constants/constants.dart';
import 'package:appback/src/converters/translation_converter.dart';
import 'package:appback/src/dtos/translation_parent_dto.dart';
import 'package:appback/exceptions/app_back_exception.dart';
import 'package:appback/models/translation.dart';
import 'package:appback/src/repository/translation/i_translation_repository.dart';
import 'package:http/http.dart' as http;

class TranslationRepository implements ITranslationRepository {
    
    final _client = http.Client();
    
    @override
    void getTranslations(String endpoint, String token, String router, String languageIdentifier, Function(List<Translation>) onSuccess, Function(AppBackException) onFailure) {
        _client.get("$endpoint$kTRANSLATIONS_URL$kROUTER_SUFFIX$router$kLANGUAGE_IDENTIFIER$languageIdentifier", headers: {kAUTHORIZATION: kBEARER + token}).then((response) {
            if (response.statusCode == 200) {
                final jsonResponse = jsonDecode(response.body);
                TranslationParentDto translationParentDto = TranslationParentDto.fromJson(jsonResponse);
                List<Translation> translations = translationParentDto.translations.map((translationDto) => translationDto.convertTranslationDtoToTranslationModel())
                    .toList();
                onSuccess(translations);
            } else if (response.statusCode == 400) {
                onFailure(AppBackException("Bad request"));
            } else if (response.statusCode == 404) {
                onFailure(AppBackException("Resource Not Found"));
            }
        }).catchError((error) => onFailure(AppBackException(error.toString())));
    }
}