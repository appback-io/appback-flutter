import 'package:json_annotation/json_annotation.dart';

part 'translation_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TranslationDto {
    String key;
    String value;

    TranslationDto(this.key, this.value);

    factory TranslationDto.fromJson(Map<String, dynamic> json) => _$TranslationDtoFromJson(json);

    Map<String, dynamic> toJson() => _$TranslationDtoToJson(this);
}