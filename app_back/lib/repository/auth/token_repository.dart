import 'dart:convert';
import 'package:app_back/constants/constants.dart';
import 'package:app_back/dtos/token_dto.dart';
import 'package:app_back/exceptions/app_back_exception.dart';
import 'package:app_back/interactors/token_interactor.dart';
import 'package:app_back/locator/locator.dart';
import 'package:app_back/models/token.dart';
import 'package:app_back/repository/auth/i_token_repository.dart';
import 'package:http/http.dart' as http;

class TokenRepository implements ITokenRepository {
    
    final _client = http.Client();
    
    @override
    Future<bool> getToken(String secretKey) {
        final call = _client.post(kTOKEN_URL, body: {"key": secretKey});
        return call.then((response) {
            if (response.statusCode == 200) {
                final jsonResponse = jsonDecode(response.body);
                Token token = TokenInteractor.convertTokenDtoToTokenModel(TokenDto.fromJson(jsonResponse));
                addInstance<Token>(token);
                return true;
            } else if (response.statusCode == 400) {
                throw AppBackException(response.statusCode, "Bad request");
            } else if (response.statusCode == 404) {
                throw AppBackException(response.statusCode, "Resource Not Found");
            }
            return false;
        }).catchError((_) => false);
    }
}