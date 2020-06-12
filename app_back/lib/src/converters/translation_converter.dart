import 'package:appback_sdk/src/dtos/translation_dto.dart';
import 'package:appback_sdk/models/translation.dart';

extension TranslationConverter on TranslationDto {
  Translation convertTranslationDtoToTranslationModel() =>
      Translation(this.key, this.value);
}
