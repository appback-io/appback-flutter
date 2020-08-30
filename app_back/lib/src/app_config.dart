import 'package:appback_sdk/models/endpoint.dart';

class AppConfig {
    static final AppConfig instance = AppConfig._internal();
    
    Endpoint endpoint;
    Map<String, String> routers;
    String token;
    
    factory AppConfig() => instance;
    
    AppConfig._internal();
}