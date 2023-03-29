class AppEndpoints {
  const AppEndpoints._();

  static const String baseUrl = "https://api.openai.com/v1";

// receiveTimeout
  static const Duration receiveTimeout = Duration(milliseconds: 30000);

  // connectTimeout
  static const Duration connectionTimeout = Duration(milliseconds: 30000);

  static const String completion = "$baseUrl/chat/completions";
}
