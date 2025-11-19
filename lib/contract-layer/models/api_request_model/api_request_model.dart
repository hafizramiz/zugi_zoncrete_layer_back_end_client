import 'dart:convert';

/// API İsteklerinde Kullanılan Metot Kimliklerini Temsil Eden Sabitler.
/// Gerçek uygulamada ayrı bir dosyadan içe aktarılır, burada sadeleştirme için tanımlanmıştır.
abstract class MethodIds {
  static const int splashInit = 0;
  static const int userLogin = 10;
// Diğer tüm metot kimlikleri buraya eklenecektir.
}

/// Uygulamanın Başlangıç Yapılandırma Bilgilerini Temsil Eden Sınıf.
/// Bu veriler genellikle ilk (Init) istek içinde sunucuya gönderilir.
class Config {
  final String bundleIdentifier;
  final String clientId;
  final String frontendUrl;
  final String realm;
  final String appVersion;
  final String language;
  final bool isDebug;
  final String deviceId;
  final String? imei;
  final bool supportNFC;
  final bool supportGPS;
  final String deviceOSType;
  final bool isEmulator;
  final String connectionType;
  final String screenSize;
  final bool notificationPermission;

  Config({
    required this.bundleIdentifier,
    required this.clientId,
    required this.frontendUrl,
    required this.realm,
    required this.appVersion,
    required this.language,
    required this.isDebug,
    required this.deviceId,
    this.imei,
    required this.supportNFC,
    required this.supportGPS,
    required this.deviceOSType,
    required this.isEmulator,
    required this.connectionType,
    required this.screenSize,
    required this.notificationPermission,
  });

  /// Config nesnesini JSON (Map) formatına dönüştürür.
  Map<String, dynamic> toJson() {
    return {
      'bundleId': bundleIdentifier,
      'clientId': clientId,
      'frontendUrl': frontendUrl,
      'realm': realm,
      'appVersion': appVersion,
      'language': language,
      'isDebug': isDebug,
      'deviceId': deviceId,
      if (imei != null) 'imei': imei,
      'supportNFC': supportNFC,
      'supportGPS': supportGPS,
      'deviceOSType': deviceOSType,
      'isEmulator': isEmulator,
      'connectionType': connectionType,
      'screenSize': screenSize,
      'notificationPermission': notificationPermission,
    };
  }
}

/// Uygulamadan sunucuya gönderilen genel API İstek Modelini temsil eden sınıf.
///
/// Bu model, tüm API çağrılarının gövdesini (body) standartlaştırır.
/// Buradaki 'token' alanı, tekrarlanan istekleri engellemek (idToken)
/// veya oturum kimliğini doğrulamak (Auth Token) için kullanılabilir.
class ApiRequestModel {
  /// Sabit istek türü: TRequest (Genellikle sunucu tarafında kullanılan bir tür bilgisidir)
  static const String _typeKey = '__type';

  final String type;

  /// Hangi sayfadan veya bileşenden istek atıldığını belirten etiket. (Hata ayıklama için faydalı)
  final String requestTag;

  /// Gerçekleştirilecek işlemi belirten metot kimliği. (Örn: Giriş yap, Ürünleri getir)
  final int methodId;

  /// Oturum kimliği. Kullanıcı girişi sonrası veya Init isteği sonrası atanır.
  final String? sessionId;

  /// Tekrarlı isteği engellemek için (idToken) veya kimlik doğrulaması için kullanılan token.
  final String? token;

  /// İsteğin ana veri yükü. Giriş bilgileri, Config detayları veya diğer payload'lar buraya gelir.
  final Map<String, dynamic>? data;

  ApiRequestModel({
    required this.type,
    required this.requestTag,
    required this.methodId,
    this.sessionId,
    this.token,
    this.data,
  });

  /// ApiRequestModel nesnesini sunucuya gönderilmeye hazır JSON (Map) formatına dönüştürür.
  Map<String, dynamic> toJson() {
    return {
      _typeKey: type,
      'request Tag': requestTag,
      'Method id': methodId,
      if (sessionId != null) 'SessionId': sessionId,
      // 'token' alanı, isteğin türüne göre Auth Token veya idToken olabilir.
      if (token != null) 'token': token,
      if (data != null) 'data': data,
    };
  }
}

/// Kullanım Örneği
void main() {
  // 1. Cihazdan ve paketlerden alınan Config objesi oluşturulur (Splash Ekranı için)
  final appConfig = Config(
    bundleIdentifier: 'com.app.example',
    clientId: 'mobile_client_id',
    frontendUrl: 'https://api.example.com',
    realm: 'myrealm',
    appVersion: '1.5.0',
    language: 'tr',
    isDebug: true,
    deviceId: 'ABC-DEVICE-ID',
    imei: null,
    supportNFC: true,
    supportGPS: true,
    deviceOSType: 'Android',
    isEmulator: false,
    connectionType: 'Wifi',
    screenSize: '1080x1920',
    notificationPermission: true,
  );

  // 2. Başlangıç (Init) isteği Modelini oluşturma
  final initRequest = ApiRequestModel(
    type: 'TRequest',
    requestTag: 'SplashView',
    methodId: MethodIds.splashInit, // 0
    sessionId: null, // İlk istek olduğu için null
    token: null, // İlk istek olduğu için null
    data: appConfig.toJson(), // Config verisi data alanına yerleştirildi
  );

  // 3. Login isteği Modelini oluşturma (Auth Token ve SessionID ile)
  const String currentSessionId = '98f.../..._singleton';
  const String userAuthToken = 'eyJhbGciOiJIUzI1Ni...';

  final Map<String, dynamic> loginData = {
    'username': 'ali_coder',
    'password': 'super_secure_password',
  };

  final loginRequest = ApiRequestModel(
    type: 'TRequest',
    requestTag: 'LoginPage',
    methodId: MethodIds.userLogin, // 10
    sessionId: currentSessionId,
    token: userAuthToken,
    data: loginData,
  );

  // 4. JSON'a dönüştür ve yazdır
  print('--- 1. Başlangıç (Init) Request Gövdesi ---');
  final String initJson = json.encode(initRequest.toJson());
  print(initJson);

  print('\n--- 2. Giriş (Login) Request Gövdesi ---');
  final String loginJson = json.encode(loginRequest.toJson());
  print(loginJson);
}