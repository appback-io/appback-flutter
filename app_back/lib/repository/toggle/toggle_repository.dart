import 'dart:convert';

import 'package:app_back/constants/constants.dart';
import 'package:app_back/dtos/toggle_parent_dto.dart';
import 'package:app_back/exceptions/app_back_exception.dart';
import 'package:app_back/interactors/toggle_interactor.dart';
import 'package:app_back/models/toggle.dart';
import 'package:app_back/repository/toggle/i_toggle_repository.dart';
import 'package:http/http.dart' as http;

class ToggleRepository implements IToggleRepository {
    
    @override
    void getToggles(String token, String router, Function(List<Toggle>) onSuccess, Function(AppBackException) onFailure) {
        http.Client().get("$kTOGGLE_URL$router", headers: {"Authorization": kBEARER + token}).then((response) {
            if (response.statusCode == 200) {
                final jsonResponse = jsonDecode(response.body);
                ToggleParentDto toggleParentDto = ToggleParentDto.fromJson(jsonResponse);
                List<Toggle> toggles = toggleParentDto.toggles.map((toggleDto) =>
                    ToggleInteractor.convertToggleDtoToToggleModel(toggleDto))
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