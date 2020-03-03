import 'package:app_back/dtos/token_dto.dart';
import 'package:app_back/models/token.dart';

class TokenInteractor {
    static Token convertTokenDtoToTokenModel(TokenDto tokenDto) {
        return Token(tokenDto.accessToken);
    }
}