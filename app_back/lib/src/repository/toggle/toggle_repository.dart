import 'dart:convert';

import 'package:appback/src/constants/constants.dart';
import 'package:appback/src/converters/toggle_converter.dart';
import 'package:appback/src/dtos/toggle_parent_dto.dart';
import 'package:appback/exceptions/app_back_exception.dart';
import 'package:appback/models/toggle.dart';
import 'package:appback/src/repository/toggle/i_toggle_repository.dart';
import 'package:http/http.dart' as http;

class ToggleRepository implements IToggleRepository {
    
    final _client = http.Client();
    
    @override
    void getToggles(String endpoint, String token, String router, Function(List<Toggle>) onSuccess, Function(AppBackException) onFailure) {
        _client.get("$endpoint$kTOGGLE_URL$kROUTER_SUFFIX$router", headers: {kAUTHORIZATION: kBEARER + token}).then((response) {
            if (response.statusCode == 200) {
                final jsonResponse = jsonDecode(response.body);
                ToggleParentDto toggleParentDto = ToggleParentDto.fromJson(jsonResponse);
                List<Toggle> toggles = toggleParentDto.toggles.map((toggleDto) => toggleDto.convertToggleDtoToToggleModel())
                    .toList();
                onSuccess(toggles);
            } else if (response.statusCode == 400) {
                onFailure(AppBackException("Bad request"));
            } else if (response.statusCode == 404) {
                onFailure(AppBackException("Resource Not Found"));
            }
        }).catchError((error) => AppBackException(error.toString()));
    }
}