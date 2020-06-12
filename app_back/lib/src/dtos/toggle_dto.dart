import 'package:json_annotation/json_annotation.dart';

part 'toggle_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ToggleDto {
  String key;
  String value;

  ToggleDto({this.key, this.value});

  factory ToggleDto.fromJson(Map<String, dynamic> json) =>
      _$ToggleDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ToggleDtoToJson(this);
}
