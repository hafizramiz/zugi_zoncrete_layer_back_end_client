import 'dart:convert';

import '../../page_direction_codes/page_direction_codes.dart';
import '../remote_config/remote_config.dart';

/// Init response Model https://docs.google.com/document/d/1DyYZGYsIzhGpybsuvgv_fs_EWtqW_3IsSq1dIov40xQ/edit?hl=tr&tab=t.0

/// 🌐 API veya uygulama içi genel yanıt modelidir.
/// Başarılı veya hatalı tüm isteklerin ortak yapısını temsil eder.





/// 🌐 API veya uygulama içi genel yanıt modelidir.
/// Başarılı veya hatalı tüm isteklerin ortak yapısını temsil eder.
class InitResponseModel {
  final int statusCode;
  final String type;
  final String message;
  final int methodId;
  final int pageDirectionCode;
  final String sessionId;
  final String? idToken;
  final DateTime? lastActivedTime;

  /// Yanıtla birlikte dönen ana veri yükü, artık RemoteConfig tipindedir.
  final RemoteConfigResponseModel? data;

  static const String _typeKey = '__type';

  const InitResponseModel({
    this.statusCode = 200,
    required this.type,
    required this.message,
    required this.methodId,
    required this.pageDirectionCode,
    required this.sessionId,
    this.lastActivedTime,
    this.data,
    this.idToken
  });

  /// 🏭 Fabrika metodu: JSON verisini modele dönüştürür.
  factory InitResponseModel.fromJson(Map<String, dynamic> json) {
    // Gelen JSON'daki 'data' alanı Map<String, dynamic> tipinde varsayılır.
    final Map<String, dynamic>? dataMap = json['data'] != null
        ? Map<String, dynamic>.from(json['data'])
        : null;

    return InitResponseModel(
      idToken: json['idToken'] as String?,
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
      // BURADA GÜNCELLEME YAPILDI: dataMap varsa, RemoteConfigResponseModel'e dönüştürülür.
      data: dataMap != null
          ? RemoteConfigResponseModel.fromJson(dataMap)
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
    'sessionId': sessionId,
    'idToken': idToken,
    if (lastActivedTime != null)
      'lastActivedTime': lastActivedTime!.toIso8601String(),
    // BURADA GÜNCELLEME YAPILDI: data objesinin toJson() metodu çağrılır.
    if (data != null) 'data': data!.toJson(),
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
InitResponseModel(
  statusCode: $statusCode,
  type: $type,
  message: $message,
  methodId: $methodId,
  pageDirectionCode: $pageDirectionCode ($directionName),
  sessionId: $sessionId,
  idToken: ${idToken ?? 'null'},
  lastActivedTime: ${lastActivedTime?.toIso8601String() ?? 'null'},
  data: ${data != null ? jsonEncode(data!.toJson()) : 'null'}
)
''';
}

void main() {
  const Map<String, dynamic> remoteConfigPayload = {
    'apiBaseUrl': 'https://prod.api.com/v1',
    'forceUpdate': true,
  };

  const Map<String, dynamic> sampleResponseJson = {
    'statusCode': 200,
    '_type': 'TResponse',
    'message': 'Yapılandırma başarıyla alındı.',
    'methodId': 1,
    'pageDirection': PageDirectionCodes.home,
    'sessionId': '98f-4d2-f6e',
    'idToken': 'eyJhbGciOiJIUzI1Ni...',
    'data': remoteConfigPayload, // Remote Config verisi
  };

  final responseModel = InitResponseModel.fromJson(sampleResponseJson);

  print(responseModel);
  print('\n--- Remote Config Detayları ---');
  print('API Base URL: ${responseModel.data?.apiBaseUrl}');
  print('Zorunlu Güncelleme: ${responseModel.data?.forceUpdate}');
}



/// 🧭 Örnek kullanım:
///
/// ```dart
/// void main() {
///   const String jsonString = '''
///   {
///     "__type": "TResponse",
///     "message": "Oturum süresi doldu.",
///     "methodId": 10,
///     "pageDirection": 99,
///     "sessionId": "98f.../..."
///   }
///   ''';
///
///   final Map<String, dynamic> jsonMap = json.decode(jsonString);
///   final response = InitResponseModel.fromJson(jsonMap);
///
///   print('--- Gelen Yanıt ---');
///   print(response);
///
///   // Kod tabanlı yönlendirme:
///   switch (response.pageDirectionCode) {
///     case PageDirectionCodes.login_request_model:
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




/// User create, POST,

final Map<String, dynamic> apiResponseJson = {
  "statusCode": 201,  /// Created
  "__type": "InitResponseModel",
  "message": "Kullanici basarili bir sekilde olusturuldu.",
  "methodId": 101, // GetConfig gibi bir metodun ID'si olabilir
  "pageDirection": PageDirectionCodes.home, // Ana sayfaya yönlendir
  "sessionId": "a1b2-c3d4-e5f6-session",
  "idToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...", // Örnek JWT
  "lastActivedTime": "2025-11-19T10:30:00.000",

  // RemoteConfigResponseModel verisi
  "data": {
    "appVersion": "1.2.5",
    "maintenanceMode": false
  }
};





/// Data olarak user Model doneceksin.

final Map<String, dynamic> apiLoginResponse = {
  "statusCode": 200,
  "__type": "TResponse",   /// Data type'i gosterir.
  "message": "Giriş başarılı.",
  "methodId": 1,
  "pageDirection": 1, // Home
  "sessionId": "sess-12345",
  "idToken": "token-xyz",

  // data içinde USER bilgisi var
  "data": {
    "id": 55,
    "firstName": "Ayşe",
    "lastName": "Demir",
    "email": "ayse@test.com",
    "role": "editor",
    "isActive": true
  }
};



//// User Model
{
"id": 55,
"firstName": "Ayşe",
"lastName": "Demir",
"email": "ayse@test.com",
"role": "editor",
"isActive": true
}