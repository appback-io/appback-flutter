import 'dart:convert';

import 'package:app_back/constants/constants.dart';
import 'package:app_back/dtos/toggle_parent_dto.dart';
import 'package:app_back/exceptions/app_back_exception.dart';
import 'package:app_back/helpers/network_helper.dart';
import 'package:app_back/interactors/toggle_interactor.dart';
import 'package:app_back/models/toggle.dart';
import 'package:app_back/repository/toggle/i_toggle_repository.dart';
import 'package:http/http.dart' as http;

class ToggleRepository implements IToggleRepository {
    final _client = http.Client();
    
    @override
    void getToggles(String router, Function(List<Toggle>) onSuccess, Function(AppBackException) onFailure) {
        _client.get("$kTOGGLE_URL$router", headers: getAuthHeader()).then((response) {
            if (response.statusCode == 200) {
                final jsonResponse = jsonDecode(response.body);
                ToggleParentDto toggleParentDto = ToggleParentDto.fromJson(jsonResponse["toggles"]);
                List<Toggle> toggles = toggleParentDto.toggles.map((toggleDto) =>
                    ToggleInteractor.convertToggleDtoToToggleModel(toggleDto))
                    .toList();
                onSuccess(toggles);
            } else if (response.statusCode == 400) {
                onFailure(AppBackException(response.statusCode, "Bad request"));
            } else if (response.statusCode == 404) {
                onFailure(AppBackException(response.statusCode, "Resource Not Found"));
            }
        }).catchError((error) => AppBackException(0, error.toString()));
    }
}