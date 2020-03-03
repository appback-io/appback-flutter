import 'package:app_back/dtos/translation_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'translation_parent_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TranslationParentDto {
    List<TranslationDto> translations;
    
    TranslationParentDto(List<TranslationDto> translations):
            translations = translations ?? <TranslationDto>[];

    factory TranslationParentDto.fromJson(Map<String, dynamic> json) => _$TranslationParentDtoFromJson(json);

    Map<String, dynamic> toJson() => _$TranslationParentDtoToJson(this);
}