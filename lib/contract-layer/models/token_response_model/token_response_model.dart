import 'dart:convert';

/// From https://help.akana.com/content/current/cm/api_oauth/oauth_oauth20/m_oauth20_getTokenPOST.htm


import '../../page_direction_codes/page_direction_codes.dart';

/// Token Response Model
/// IdToken ile user credential bilgileri elde edilir. Bunlar Session Service icinde tutulur.
/// Ram'de tutulur yani.
class TokenResponseModel {
  /// HTTP veya uygulama içi işlem sonucu durum kodu (Örn: 200, 401, 500).
  final int statusCode;

  /// Yanıt tipini belirtir (genellikle "TResponse" olarak gelir).
  final String type;

  /// İşlem veya hata mesajını içerir.
  final String message;

  /// Bu yanıtın hangi isteğe ait olduğunu belirten kod.
  final int methodId;

  /// Yönlendirme kodu (örn: login_request_model, home, password reset).
  final int pageDirectionCode;

  /// Erişim token'ı (ana token) - Yetkilendirme sunucusu tarafından döndürülen erişim token'ı.
  final String? accessToken;

  /// Yenileme token'ı (opsiyonel) - Yetkilendirme sunucusu tarafından döndürülen yenileme token'ı.
  final String? refreshToken;

  /// Token türünü belirtir (örn: 'Bearer') - Yetkilendirme sunucusu tarafından döndürülen token türü.
  final String? tokenType;

  /// Erişim token'ının son kullanma tarihi (opsiyonel, expiresIn'den hesaplanabilir)
  /// - [accessToken]'ın ne zaman sona ereceğini belirtir. Uygulamalar genellikle
  /// yenileme token'ını kullanarak token'ı sona ermeden önce yeniler.
  final DateTime? accessTokenExpirationDateTime;

  /// Kimlik token'ı (ID token, opsiyonel) - Yetkilendirme sunucusu tarafından döndürülen ID token.
  final String? idToken;

  /// Oturumun en son aktif olduğu zaman (opsiyonel).
  final DateTime? lastActivedTime;

  static const String _typeKey = '__type';

  const TokenResponseModel({
    this.statusCode = 200,
    required this.type,
    required this.message,
    required this.methodId,
    required this.pageDirectionCode,
    this.accessToken,
    this.refreshToken,
    this.tokenType,
    this.accessTokenExpirationDateTime,
    this.idToken,
    this.lastActivedTime,
  });

  /// 🏭 Fabrika metodu: JSON verisini modele dönüştürür.
  factory TokenResponseModel.fromJson(Map<String, dynamic> json) {
    return TokenResponseModel(
      statusCode: json['statusCode'] as int? ?? 200,
      type: json[_typeKey] as String? ?? 'TResponse',
      message: json['message'] as String? ?? 'Bilinmeyen hata.',
      methodId: json['methodId'] as int? ?? json['method id'] as int? ?? -1,
      pageDirectionCode:
          json['pageDirection'] as int? ??
          json['Page direction'] as int? ??
          PageDirectionCodes.none,

      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
      tokenType: json['tokenType'] as String?,

      accessTokenExpirationDateTime:
          json['accessTokenExpirationDateTime'] != null
          ? DateTime.tryParse(json['accessTokenExpirationDateTime'])
          : null,

      idToken: json['idToken'] as String?,

      lastActivedTime: json['lastActivedTime'] != null
          ? DateTime.tryParse(json['lastActivedTime'])
          : null,
    );
  }

  /// 🔁 Modeli JSON formatına dönüştürür.
  Map<String, dynamic> toJson() => {
    'statusCode': statusCode,
    _typeKey: type,
    'message': message,
    'methodId': methodId,
    'pageDirection': pageDirectionCode,
    if (accessToken != null) 'accessToken': accessToken,
    if (refreshToken != null) 'refreshToken': refreshToken,
    if (tokenType != null) 'tokenType': tokenType,
    if (accessTokenExpirationDateTime != null)
      'accessTokenExpirationDateTime': accessTokenExpirationDateTime!
          .toIso8601String(),
    if (idToken != null) 'idToken': idToken,
    if (lastActivedTime != null)
      'lastActivedTime': lastActivedTime!.toIso8601String(),
  };

  /// 🎯 Yönlendirme kodunu açıklayıcı bir metne çevirir.
  String get directionName {
    switch (pageDirectionCode) {
      case PageDirectionCodes.login:
        return 'Giriş Sayfası';
      case PageDirectionCodes.home:
        return 'Ana Sayfa';
      case PageDirectionCodes.passwordReset:
        return 'Parola Sıfırlama';
      default:
        return 'Bilinmeyen Sayfa';
    }
  }

  @override
  String toString() =>
      '''
TokenResponseModel(
  statusCode: $statusCode,
  type: $type,
  message: $message,
  methodId: $methodId,
  pageDirectionCode: $pageDirectionCode ($directionName),
  accessToken: ${accessToken?.substring(0, 20) ?? 'null'}...,
  refreshToken: ${refreshToken?.substring(0, 20) ?? 'null'}...,
  tokenType: ${tokenType ?? 'null'},
  accessTokenExpirationDateTime: ${accessTokenExpirationDateTime?.toIso8601String() ?? 'null'},
  idToken: ${idToken?.substring(0, 20) ?? 'null'}...,
  lastActivedTime: ${lastActivedTime?.toIso8601String() ?? 'null'},
)
''';
}

/// 🧭 Örnek Cikti:
///
/// ```dart
/// void main() {
///   const String jsonString = '''
///   {
///     "__type": "TokenResponse",
///     "message": "Token başarıyla yenilendi.",
///     "methodId": 1001,
///     "pageDirection": 1,
///     "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
///     "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
///     "tokenType": "Bearer",
///     "accessTokenExpirationDateTime": "2025-11-18T12:00:00Z",
///     "idToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
///   }
///   ''';
///
///   final Map<String, dynamic> jsonMap = json.decode(jsonString);
///   final response = TokenResponseModel.fromJson(jsonMap);
///
///   print('--- Token Yanıtı ---');
///   print(response);
///
///   // Token kullanım örneği:
///   if (response.accessToken != null) {
///     print('🔑 Erişim Token: ${response.accessToken}');
///     print('⏱️ Süre: ${response.expiresIn} saniye');
///     print('📅 Son Kullanma: ${response.accessTokenExpirationDateTime}');
///     print('📋 Kapsamlar: ${response.scopes?.join(', ') ?? 'Yok'}');
///   }
///
///   // Ek parametreler:
///   if (response.tokenAdditionalParameters != null) {
///     print('🔧 Token Ek Parametreleri: ${jsonEncode(response.tokenAdditionalParameters)}');
///   }
///   if (response.authorizationAdditionalParameters != null) {
///     print('🔧 Yetkilendirme Ek Parametreleri: ${jsonEncode(response.authorizationAdditionalParameters)}');
///   }
///
///   // Kod tabanlı yönlendirme:
///   switch (response.pageDirectionCode) {
///     case PageDirectionCodes.login:
///       print('🚨 Kullanıcı Giriş Sayfasına yönlendiriliyor.');
///       break;
///     case PageDirectionCodes.home:
///       print('✅ Kullanıcı Ana Sayfaya yönlendiriliyor.');
///       break;
///     default:
///       print('⚙️ Yönlendirme yok veya bilinmiyor.');
///   }
/// }
/// ```
