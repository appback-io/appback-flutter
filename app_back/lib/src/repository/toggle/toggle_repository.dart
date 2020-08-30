import 'dart:convert';

import 'package:appback_sdk/src/app_back_config.dart';
import 'package:appback_sdk/src/constants/constants.dart';
import 'package:appback_sdk/src/converters/toggle_converter.dart';
import 'package:appback_sdk/src/dtos/toggle_parent_dto.dart';
import 'package:appback_sdk/exceptions/app_back_exception.dart';
import 'package:appback_sdk/models/toggle.dart';
import 'package:appback_sdk/src/repository/toggle/i_toggle_repository.dart';
import 'package:http/http.dart' as http;

class ToggleRepository implements IToggleRepository {
  
  final _client = http.Client();
  
  static List<Toggle> _toggles;
  
  @override
  Future<bool> getBoolToggle(String key) async {
    if (_toggles == null) {
      await getTogglesAsync();
    }
    final boolToggle = _toggles.firstWhere((toggle) => toggle.key == key, orElse: () => null)?.value;
    if (boolToggle is bool) return boolToggle;
    else if (boolToggle is num) return boolToggle == 1;
    else return null;
  }
  
  @override
  Future<num> getNumToggle(String key) async {
    if (_toggles == null) {
      await getTogglesAsync();
    }
    final numericToggle = _toggles.firstWhere((toggle) => toggle.key == key, orElse: () => null)?.value;
    if (numericToggle is num) return numericToggle;
    return null;
  }
  
  @override
  Future<String> getStringToggle(String key) async {
    if (_toggles == null) {
      await getTogglesAsync();
    }
    final stringToggle = _toggles.firstWhere((toggle) => toggle.key == key, orElse: () => null)?.value;
    if (stringToggle is String) return stringToggle;
    return null;
  }
  
  @override
  void getToggles(String endpoint, String token, String router,
      Function(List<Toggle>) onSuccess, Function(AppBackException) onFailure) {
    AppBackConfig.instance.routers["toggles"] = router;
    _client.get("$endpoint$kTOGGLE_URL$kROUTER_SUFFIX$router",
        headers: {kAUTHORIZATION: kBEARER + token}).then((response) {
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        ToggleParentDto toggleParentDto =
        ToggleParentDto.fromJson(jsonResponse);
        List<Toggle> toggles = toggleParentDto.toggles
            .map((toggleDto) => toggleDto.convertToggleDtoToToggleModel())
            .toList();
        _toggles = toggles;
        onSuccess(_toggles);
      } else if (response.statusCode == 400) {
        onFailure(AppBackException("Bad request"));
      } else if (response.statusCode == 404) {
        onFailure(AppBackException("Resource Not Found"));
      }
    }).catchError((error) => AppBackException(error.toString()));
  }
  
  @override
  Future<List<Toggle>> getTogglesAsync({String endpoint, String token, String router}) {
    endpoint = endpoint ?? AppBackConfig.instance.endpoint.url;
    router = router ?? AppBackConfig.instance.routers["toggles"];
    token = token ?? AppBackConfig.instance.token;
    return _client.get("$endpoint$kTOGGLE_URL$kROUTER_SUFFIX$router", headers: {kAUTHORIZATION: kBEARER + token}).then((response) {
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        ToggleParentDto toggleParentDto =
        ToggleParentDto.fromJson(jsonResponse);
        _toggles = toggleParentDto.toggles
            .map((toggleDto) => toggleDto.convertToggleDtoToToggleModel())
            .toList();
        return _toggles;
      }
    }).catchError((_) => <Toggle>[]);
  }
}
