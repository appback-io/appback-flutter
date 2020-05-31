import 'package:app_back/exceptions/app_back_exception.dart';
import 'package:app_back/models/toggle.dart';

abstract class IToggleRepository {
    void getToggles(
        String endpoint,
        String token,
        String router,
        Function(List<Toggle>) onSuccess,
        Function(AppBackException) onFailure
        );
}