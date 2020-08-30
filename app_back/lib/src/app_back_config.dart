import 'package:appback_sdk/models/endpoint.dart';

class AppBackConfig {
    static final AppBackConfig instance = AppBackConfig._internal();
    
    Endpoint endpoint;
    Map<String, String> routers;
    String token;
    
    factory AppBackConfig() => instance;
    
    AppBackConfig._internal();
}