import 'dart:convert';
import 'package:app_back/constants/constants.dart';
import 'package:app_back/dtos/token_dto.dart';
import 'package:app_back/exceptions/app_back_exception.dart';
import 'package:app_back/interactors/token_interactor.dart';
import 'package:app_back/models/token.dart';
import 'package:app_back/repository/auth/i_token_repository.dart';
import 'package:http/http.dart' as http;

class TokenRepository implements ITokenRepository {
    
    @override
    Future<Token> getToken(String secretKey) {
        return http.Client().post(kTOKEN_URL, body: {"key": secretKey}).then((response) {
            if (response.statusCode == 200) {
                Token token = TokenInteractor.convertTokenDtoToTokenModel(TokenDto.fromJson(jsonDecode(response.body)));
                return token;
            } else if (response.statusCode == 400) {
                throw AppBackException("Bad request");
            } else if (response.statusCode == 404) {
                throw AppBackException("Resource Not Found");
            }
            throw AppBackException("Error getting the access token, this should never happen. Code: ${response.statusCode}");
        }).catchError((error) => AppBackException(error.toString()));
    }
}