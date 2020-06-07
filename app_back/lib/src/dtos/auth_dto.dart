import 'package:json_annotation/json_annotation.dart';

part 'auth_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AuthDto {
    String accessToken;
    String endpoint;
    AuthDto({this.accessToken, this.endpoint});

    factory AuthDto.fromJson(Map<String, dynamic> json) => _$AuthDtoFromJson(json);

    Map<String, dynamic> toJson() => _$AuthDtoToJson(this);
}