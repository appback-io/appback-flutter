import 'package:appback_sdk/exceptions/app_back_exception.dart';
import 'package:appback_sdk/models/translation.dart';

abstract class ITranslationRepository {
  /// Gets the list of translations from [router] with the authorization [token]
  /// [onSuccess] called when the translations were successfully retrieved and returns them as an argument
  /// [onFailure] called when there was an error getting the translations with [AppBackException] as an argument.
  void getTranslations(
      String endpoint,
      String token,
      String router,
      String languageIdentifier,
      Function(List<Translation>) onSuccess,
      Function(AppBackException) onFailure);
}
