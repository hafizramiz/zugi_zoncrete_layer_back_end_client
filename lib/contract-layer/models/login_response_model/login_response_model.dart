import 'dart:convert';

import '../../page_direction_codes/page_direction_codes.dart';

/// 🌐 Başarılı bir Login (Giriş) isteği sonrasında dönen yanıt modelidir.
/// InitResponseModel yapısını temel alır ve token detaylarını içerir.
class LoginResponseModel {
  // --- InitResponseModel'den Gelen Temel Yanıt Alanları ---

  /// HTTP veya uygulama içi işlem sonucu durum kodu (Örn: 200, 401).
  final int statusCode;

  /// Yanıt tipini belirtir (genellikle "TResponse").
  final String type;

  /// İşlem veya hata mesajını içerir.
  final String message;

  /// Bu yanıtın hangi isteğe ait olduğunu belirten kod. (Login: 10)
  final int methodId;

  /// Yönlendirme kodu (örn: home, password reset).
  final int pageDirectionCode;

  /// Oturum kimliği.
  final String sessionId;

  /// Oturumun en son aktif olduğu zaman (opsiyonel).
  final DateTime? lastActivedTime;

  // --- Token ve Yetkilendirme Alanları (Başarılı Girişte Kritik) ---

  /// Back-end'e erişim için kullanılan asıl token. (Database erişimi için kullanılır).
  final String? accessToken;

  /// Access Token süresi dolduğunda yeni Access Token almak için kullanılır.
  final String? refreshToken;

  /// Access Token'in geçerlilik süresi.
  final DateTime? accessTokenExpirationDateTime;

  /// Kullanıcıyı tanımak ve kısıtlı istekler için kullanılan token (Kimlik için kullanılır).
  final String? idToken;

  /// Token türü (Örn: "Bearer").
  final String? tokenType;

  /// Başarılı girişte dönen ana veri yükü (Opsiyonel, ek bilgiler için).
  final Map<String, dynamic>? data;


  static const String _typeKey = '__type';

  const LoginResponseModel({
    this.statusCode = 200,
    required this.type,
    required this.message,
    required this.methodId,
    required this.pageDirectionCode,
    required this.sessionId,
    this.lastActivedTime,
    this.data,

    // Token Alanları
    this.accessToken,
    this.refreshToken,
    this.accessTokenExpirationDateTime,
    this.idToken,
    this.tokenType,
  });

  /// 🏭 Fabrika metodu: JSON verisini modele dönüştürür.
  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    // Token alanları genellikle ya 'data' içinde ya da doğrudan ana JSON'da olabilir.
    // En esnek yaklaşım için 'data' içini kontrol edelim.
    final Map<String, dynamic> dataPayload = json['data'] != null
        ? Map<String, dynamic>.from(json['data'])
        : json; // Eğer data yoksa, ana gövdeyi kullan.

    final String? accessToken = dataPayload['accessToken'] as String?;
    final int? expiresIn = dataPayload['expires_in'] as int?;

    DateTime? expirationDate;
    if (expiresIn != null) {
      // 'expires_in' saniye cinsinden döndüğü varsayılır
      expirationDate = DateTime.now().add(Duration(seconds: expiresIn));
    }

    return LoginResponseModel(
      statusCode: json['statusCode'] as int? ?? 200,
      type: json[_typeKey] as String? ?? 'TResponse',
      message: json['message'] as String? ?? 'Bilinmeyen hata.',
      methodId: json['methodId'] as int? ?? json['method id'] as int? ?? -1,
      pageDirectionCode:
      json['pageDirection'] as int? ??
          json['Page direction'] as int? ??
          PageDirectionCodes.none,
      sessionId:
      json['sessionId'] as String? ?? json['Session id'] as String? ?? '',
      lastActivedTime: json['lastActivedTime'] != null
          ? DateTime.tryParse(json['lastActivedTime'])
          : null,

      // Token Değerlerini Eşleştirme
      accessToken: accessToken,
      refreshToken: dataPayload['refreshToken'] as String?,
      accessTokenExpirationDateTime: expirationDate,
      idToken: dataPayload['idToken'] as String?,
      tokenType: dataPayload['tokenType'] as String? ?? dataPayload['token_type'] as String?,

      // Geriye Kalan Data Alanı (varsa)
      data: json['data'] != null ? Map<String, dynamic>.from(json['data']) : null,
    );
  }

  /// 🔁 Modeli JSON formatına dönüştürür.
  @override
  Map<String, dynamic> toJson() {
    // Token verilerini genellikle 'data' içine koymak, genel API yanıt yapısını temiz tutar.
    final Map<String, dynamic> tokenData = {
      if (accessToken != null) 'accessToken': accessToken,
      if (refreshToken != null) 'refreshToken': refreshToken,
      // API'ye gönderilirken genellikle DateTime yerine "expires_in" (saniye) kullanılır.
      if (accessTokenExpirationDateTime != null)
        'expiresIn': accessTokenExpirationDateTime!.difference(DateTime.now()).inSeconds,
      if (idToken != null) 'idToken': idToken,
      if (tokenType != null) 'tokenType': tokenType,
      // Ek veriler varsa token datasını genişletiriz
      if (data != null) ...data!,
    };

    return {
      'statusCode': statusCode,
      _typeKey: type,
      'message': message,
      'methodId': methodId,
      'pageDirection': pageDirectionCode,
      'sessionId': sessionId,
      if (lastActivedTime != null)
        'lastActivedTime': lastActivedTime!.toIso8601String(),
      'data': tokenData, // Token verileri ve varsa ek data
    };
  }

  // --- Yardımcı Alanlar ve Metotlar ---

  /// 🎯 Yönlendirme kodunu açıklayıcı bir metne çevirir.
  String get directionName {
    // PageDirectionCodes sınıfınızın doğru import edildiği varsayılır.
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

  /// ❓ İşlemin Başarılı Olup Olmadığını Kontrol Eder.
  bool get isSuccessful => statusCode >= 200 && statusCode < 300 && accessToken != null;

  @override
  String toString() =>
      '''
LoginResponseModel(
  statusCode: $statusCode,
  type: $type,
  message: $message,
  methodId: $methodId,
  pageDirectionCode: $pageDirectionCode ($directionName),
  sessionId: $sessionId,
  isSuccessful: $isSuccessful,
  accessToken: ${accessToken != null ? '...[MEVCUT]' : 'null'},
  refreshToken: ${refreshToken != null ? '...[MEVCUT]' : 'null'},
  idToken: ${idToken != null ? '...[MEVCUT]' : 'null'},
  expiration: ${accessTokenExpirationDateTime?.toIso8601String() ?? 'null'},
  data: ${data != null ? jsonEncode(data) : 'null'}
)
''';
}