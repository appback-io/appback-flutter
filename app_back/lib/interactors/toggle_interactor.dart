import 'package:app_back/dtos/toggle_dto.dart';
import 'package:app_back/models/toggle.dart';
import 'package:app_back/extensions/string_extensions.dart';

class ToggleInteractor {
    static Toggle convertToggleDtoToToggleModel(ToggleDto toggleDto) {
        String key = toggleDto.key;
        dynamic value = _getValueType(toggleDto.value);
        return Toggle(key, value);
    }
    
    static dynamic _getValueType(String value) {
        final parsedNumber = num.tryParse(value);
        if (parsedNumber != null) {
            return parsedNumber as double;
        } else if (value.equalsIgnoreCase("false")) {
            return false;
        } else if (value.equalsIgnoreCase("true")) {
            return true;
        } else {
            return value;
        }
    }
}