class AppBackException implements Exception {
    int code;
    String message;
    
    AppBackException(this.code, this.message);
    
    @override
  String toString() =>
        "AppBackException: Code: $code with message: $message.";
}