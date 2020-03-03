import 'package:get_it/get_it.dart';

/// The service locator instance that contains all LazySingletons that will be reused
/// across the application.
/// Author: nicdamun

GetIt locator = GetIt.instance;

void setUpLocator() {
    locator.allowReassignment = true;
}

void addInstance<T>(T dependency) {
    locator.registerLazySingleton<T>(() => dependency);
}