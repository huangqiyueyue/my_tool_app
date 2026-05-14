class Env {
  static bool _isProduction = false;

  static void init({required bool isProduction}) {
    _isProduction = isProduction;
  }

  static bool get isProduction => _isProduction;
  static String get baseUrl => _isProduction 
      ? 'https://api.example.com' 
      : 'https://dev-api.example.com';
}
