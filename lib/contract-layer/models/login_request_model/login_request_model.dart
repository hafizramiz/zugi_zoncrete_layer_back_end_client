
/// Login olmamis kullanicida access token olmaz. Login olan kullanici access token elde eder.

class LoginRequestModel {
  /// Reguestin type'ini belirtir.
  final String type;

  /// Hangi sayfadan istek atildi.
  final String requestTag;
  final int methodId =
      10; // Genellikle login_request_model için sabit bir MethodId kullanılır, Splash icin 0 kullanilir.

  /// Bunun icinde login_request_model credential ve diger yetkilendirme ayarlari olacak
  final Map<String, dynamic> data;
  static const String _typeKey = '__type';

  LoginRequestModel({
    // InitRequestModel'den alınan zorunlu alanlar
    required this.type,
    required this.requestTag,


    // Login Credential ve Ek Parametreler
    required String username,
    required String password,
    String? clientId, // AuthorizationTokenRequest'ten
    String? loginHint, // AuthorizationTokenRequest'ten
    String? grantType, // Genellikle "password" veya "client_credentials"
    String? scope, // Yetki kapsamı
    Map<String, dynamic>? additionalParameters, // Ek parametreler
  }) : data = {
         'username': username,
         'password': password,
         if (clientId != null) 'clientId': clientId,
         if (loginHint != null) 'loginHint': loginHint,
         if (grantType != null) 'grantType': grantType,
         if (scope != null) 'scope': scope,
         if (additionalParameters != null)
           'additionalParameters': additionalParameters,
       };

  Map<String, dynamic> toJson() {
    return {
      _typeKey: type,
      'request Tag': requestTag,
      'Method id': methodId,
      'data': data, // Login'de data her zaman zorunludur
    };
  }
}


/// Cihaz configleri server'a gonderilirken bir Token olusturulup gonderilir.
/// Geriye idToken doner. Gun icerisinde bu idToken ile 5'ten fazla istek atilmasi engellenir.
/// Password reset'de de ayni islemi yapabiliriz. Id Token istegi atani tanimak icin kullanilir
/// Access token ise database'e erisim icin kullanilir.