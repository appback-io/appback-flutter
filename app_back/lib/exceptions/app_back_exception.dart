class AppBackException implements Exception {
    String reason;
    
    AppBackException(this.reason);
    
    @override
  String toString() =>
        "AppBackException: Reason: $reason.";
}