import 'package:app_back/exceptions/app_back_exception.dart';
import 'package:app_back/models/translation.dart';

abstract class ITranslationRepository {
    
    /// Gets the list of translations from [router] with the authorization [token]
    /// [onSuccess] called when the translations were successfully retrieved and returns them as an argument
    /// [onFailure] called when there was an error getting the translations with [AppBackException] as an argument.
    void getTranslations(
        String token,
        String router,
        Function(List<Translation>) onSuccess,
        Function(AppBackException) onFailure
        );
}