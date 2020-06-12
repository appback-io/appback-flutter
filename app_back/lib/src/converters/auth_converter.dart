import 'package:appback_sdk/src/dtos/auth_dto.dart';
import 'package:appback_sdk/models/endpoint.dart';
import 'package:appback_sdk/models/token.dart';

extension AuthConverter on AuthDto {
  Token convertAuthDtoToTokenModel() => Token(this.accessToken);

  Endpoint convertAuthDtoToEndPointModel() => Endpoint(this.endpoint);
}
