import 'package:appback_sdk/src/dtos/toggle_dto.dart';
import 'package:appback_sdk/models/toggle.dart';

extension ToggleConverter on ToggleDto {
  Toggle convertToggleDtoToToggleModel() {
    String key = this.key;
    dynamic value = this.value;
    return Toggle(key, value);
  }
}
