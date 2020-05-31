import 'package:app_back/dtos/translation_dto.dart';
import 'package:app_back/models/translation.dart';

extension TranslationConverter on TranslationDto {
    Translation convertTranslationDtoToTranslationModel() => Translation(this.key, this.value);
}