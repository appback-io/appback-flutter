import 'package:app_back/dtos/toggle_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'toggle_parent_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ToggleParentDto {
    List<ToggleDto> toggles;
    
    ToggleParentDto(List<ToggleDto> toggles):
            toggles = toggles ?? <ToggleDto>[];
    
    factory ToggleParentDto.fromJson(Map<String, dynamic> json) => _$ToggleParentDtoFromJson(json);
    
    Map<String, dynamic> toJson() => _$ToggleParentDtoToJson(this);
}