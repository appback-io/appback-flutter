import 'package:json_annotation/json_annotation.dart';

part 'token_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TokenDto {
    String accessToken;
    
    TokenDto({this.accessToken});

    factory TokenDto.fromJson(Map<String, dynamic> json) => _$TokenDtoFromJson(json);

    Map<String, dynamic> toJson() => _$TokenDtoToJson(this);
}