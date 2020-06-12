// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthDto _$AuthDtoFromJson(Map<String, dynamic> json) {
  return AuthDto(
    accessToken: json['access_token'] as String,
    endpoint: json['endpoint'] as String,
  );
}

Map<String, dynamic> _$AuthDtoToJson(AuthDto instance) => <String, dynamic>{
      'access_token': instance.accessToken,
      'endpoint': instance.endpoint,
    };
