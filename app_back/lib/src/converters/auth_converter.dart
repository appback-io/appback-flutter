import 'package:appback/src/dtos/auth_dto.dart';
import 'package:appback/models/endpoint.dart';
import 'package:appback/models/token.dart';

extension AuthConverter on AuthDto {
    Token convertAuthDtoToTokenModel() => Token(this.accessToken);
    Endpoint convertAuthDtoToEndPointModel() => Endpoint(this.endpoint);
}