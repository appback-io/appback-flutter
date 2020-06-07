import 'package:app_back/src/dtos/toggle_dto.dart';
import 'package:app_back/models/toggle.dart';

extension ToggleConverter on ToggleDto {
    Toggle convertToggleDtoToToggleModel() {
        String key = this.key;
        dynamic value = this.value;
        return Toggle(key, value);
    }
}