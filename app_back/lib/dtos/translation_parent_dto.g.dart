// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translation_parent_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TranslationParentDto _$TranslationParentDtoFromJson(Map<String, dynamic> json) {
  return TranslationParentDto(
    (json['translations'] as List)
        ?.map((e) => e == null
            ? null
            : TranslationDto.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$TranslationParentDtoToJson(
        TranslationParentDto instance) =>
    <String, dynamic>{
      'translations': instance.translations,
    };
