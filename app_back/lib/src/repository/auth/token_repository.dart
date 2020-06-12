import 'dart:convert';
import 'package:app_back/src/constants/constants.dart';
import 'package:app_back/src/dtos/auth_dto.dart';
import 'package:app_back/exceptions/app_back_exception.dart';
import 'package:app_back/src/converters/auth_converter.dart';
import 'package:app_back/models/auth.dart';
import 'package:app_back/models/endpoint.dart';
import 'package:app_back/models/token.dart';
import 'package:app_back/src/repository/auth/i_token_repository.dart';
import 'package:http/http.dart' as http;

class TokenRepository implements ITokenRepository {
    
    final _client = http.Client();
    
    @override
    void getToken(String secretKey, Function(Auth) onSuccess) {
        _client.post(kAPI_URL + kTOKEN_URL, body: {"key": secretKey}).then((response) {
            if (response.statusCode == 200) {
                AuthDto authDto = AuthDto.fromJson(jsonDecode(response.body));
                Token token = authDto.convertAuthDtoToTokenModel();
                Endpoint endpoint = authDto.convertAuthDtoToEndPointModel();
                onSuccess(Auth(token, endpoint));
            } else if (response.statusCode == 400) {
                throw AppBackException("Bad request");
            } else if (response.statusCode == 401) {
                throw AppBackException("Auth error, please verify your API_KEY");
            } else if (response.statusCode == 404) {
                throw AppBackException("Resource Not Found");
            } else {
                throw AppBackException("Error getting the access token, this should never happen. Code: ${response.statusCode}");
            }
        }).catchError((error) => throw AppBackException(error.toString()));
    }
}