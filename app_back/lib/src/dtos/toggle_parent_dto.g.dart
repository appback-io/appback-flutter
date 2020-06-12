// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toggle_parent_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ToggleParentDto _$ToggleParentDtoFromJson(Map<String, dynamic> json) {
  return ToggleParentDto(
    (json['toggles'] as List)
        ?.map((e) =>
            e == null ? null : ToggleDto.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ToggleParentDtoToJson(ToggleParentDto instance) =>
    <String, dynamic>{
      'toggles': instance.toggles,
    };
