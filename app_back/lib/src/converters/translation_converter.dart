import 'package:appback/src/dtos/translation_dto.dart';
import 'package:appback/models/translation.dart';

extension TranslationConverter on TranslationDto {
    Translation convertTranslationDtoToTranslationModel() => Translation(this.key, this.value);
}