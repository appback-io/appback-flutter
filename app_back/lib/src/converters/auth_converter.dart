import 'package:app_back/src/dtos/auth_dto.dart';
import 'package:app_back/models/endpoint.dart';
import 'package:app_back/models/token.dart';

extension AuthConverter on AuthDto {
    Token convertAuthDtoToTokenModel() => Token(this.accessToken);
    Endpoint convertAuthDtoToEndPointModel() => Endpoint(this.endpoint);
}