import 'package:app_back/constants/constants.dart';
import 'package:app_back/locator/locator.dart';

Map<String, String> getAuthHeader() {
    return {kAUTHORIZATION: "$kBEARER${locator<String>()}"};
}