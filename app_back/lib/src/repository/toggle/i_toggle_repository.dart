import 'package:appback_sdk/exceptions/app_back_exception.dart';
import 'package:appback_sdk/models/toggle.dart';

abstract class IToggleRepository {
  
  Future<bool> getBoolToggle(String key);
  
  Future<num> getNumToggle(String key);
  
  Future<String> getStringToggle(String key);
  
  void getToggles(String endpoint, String token, String router,
      Function(List<Toggle>) onSuccess, Function(AppBackException) onFailure);
  
  Future<List<Toggle>> getTogglesAsync({String endpoint, String token, String router});
}
