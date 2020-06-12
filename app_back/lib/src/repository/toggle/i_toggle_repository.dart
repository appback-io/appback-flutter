import 'package:appback/exceptions/app_back_exception.dart';
import 'package:appback/models/toggle.dart';

abstract class IToggleRepository {
    void getToggles(
        String endpoint,
        String token,
        String router,
        Function(List<Toggle>) onSuccess,
        Function(AppBackException) onFailure
        );
}