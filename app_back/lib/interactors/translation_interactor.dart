import 'package:app_back/dtos/translation_dto.dart';
import 'package:app_back/models/translation.dart';

class TranslationInteractor {
    static Translation convertTranslationDtoToTranslationModel(TranslationDto translationDto) {
        return Translation(
            translationDto.key,
            translationDto.value
        );
    }
}