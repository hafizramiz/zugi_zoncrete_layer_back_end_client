/// 📤 Uygulamadan sunucuya gönderilen genel API İstek Modelini temsil eden sınıf.
///
/// Bu model, tüm API çağrılarının gövdesini (body) standartlaştırır.
import 'dart:convert';


import '../../methodids/method_ids.dart';
import '../config/config.dart';

/// Burda idToken'da olacak. Bu token ile ikinci istegin gelmemesi saglanacak
/// Yani iki tane arka arkaya sms istegi atamayacak.


// import 'config.dart'; // Config sınıfının olduğu dosya
// import 'request_codes.dart'; // RequestCodes abstract sınıfının olduğu dosya
/// Init request atilirken client side'da bir token olusturulacak
/// Server side'a gonderilecek.
// Önceki konuşmamızdaki InitRequestModel yapısını tekrar kullanıyoruz
/// Request icinde idToken olacak. Bu token ile ikinci istegin gelmemesini saglayacak
/// Client splash ekraninda iken cihaz bilgilerini toplayip server'a gonderiyor
/// Bi de token gonderiyor ve server tokeni onaylayio idToken veriyor.
/// Passsword reset ve diger islemler ornegin otp request idToken ile yapilacak
/// Birden fazla kez Passsword reset istegi engellenecek.
class InitRequestModel {
  final String type;
  /// Hangi sayfadan istek atildi.
  final String requestTag;
  final int methodId;
  final String? sessionId;
  final String? token;

  /// Bunun icinde config ayarlari olacak
  final Map<String, dynamic>? data;
  static const String _typeKey = '__type';

  InitRequestModel({
    required this.type,
    required this.requestTag,
    required this.methodId,
    this.sessionId,
    this.token,
    this.data,
  });

  Map<String, dynamic> toJson() {
    return {
      _typeKey: type,
      'request Tag': requestTag,
      'Method id': methodId,
      if (sessionId != null) 'SessionId': sessionId,
      if (token != null) 'token': token,
      if (data != null) 'data': data,
    };
  }
}


/// Bunlarin bazilari device acilirken elde edilecek.
void main() {
  // 1. Cihazdan ve paketlerden alınan Config objesi oluşturulur.
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

  // 2. Config objesi JSON'a dönüştürülür ve InitRequestModel'in 'data' alanına eklenir.
  final initRequest = InitRequestModel(
    type: 'TRequest',
    requestTag: 'SplashView',
    methodId: MethodIds.splashInit,
    // 0 numaralı request
    sessionId: null,
    // İlk istek olduğu için Session ID olmayabilir.
    token: null,
    // İlk istek olduğu için Token olmayabilir.
    data: appConfig.toJson(), // Config verisi buraya yerleştirildi!
  );

  // 3. JSON'a dönüştür ve yazdır
  final Map<String, dynamic> jsonBody = initRequest.toJson();
  final String jsonString = json.encode(jsonBody);

  print('--- INIT REQUEST GÖVDESİ (CONFIG DATASI İLE) ---');
  print(jsonString);

  // Kontrol: Data alanındaki bir Config bilgisini yazdıralım
  print(
    '\nKontrol: Data içindeki App Versiyonu: ${jsonBody['data']!['appVersion']}',
  );
}

/// How to use

// void main() {
//   // Varsayımsal Singleton (Oturum Yöneticisi) verileri
//   const String currentSessionId = '98f.../..._singleton';
//   const String userAuthToken = 'eyJhbGciOiJIUzI1Ni...';
//
//   // 1. Login isteği için veri yükünü (payload) hazırla
//   final Map<String, dynamic> loginData = {
//     'username': 'ali_coder',
//     'password': 'super_secure_password',
//   };
//
//   // 2. Request Modelini oluştur
//   final loginRequest = InitRequestModel(
//     type: 'TRequest',
//     requestTag: 'LoginPage', // İsteğin geldiği yer
//     methodId: RequestCodes.userLogin, // Örn: 10
//     sessionId: currentSessionId,
//     token: userAuthToken,
//     data: loginData,
//   );
//
//   // 3. Modeli JSON formatına dönüştür
//   final Map<String, dynamic> jsonBody = loginRequest.toJson();
//
//   // 4. JSON'ı String'e çevir (API çağrısı için)
//   final String jsonString = json.encode(jsonBody);
//
//   print('--- Oluşturulan JSON Request Body ---');
//   print(jsonString);
//
//   /*
//   Beklenen JSON Çıktısı (Okunabilirlik için formatlanmıştır):
//   {
//     "__type": "TRequest",
//     "request Tag": "LoginPage",
//     "Method id": 10,
//     "SessionId": "98f.../..._singleton",
//     "token": "eyJhbGciOiJIUzI1Ni...",
//     "data": {
//       "username": "ali_coder",
//       "password": "super_secure_password"
//     }
//   }
//   */
//
//   print('\n--- Model Detayları ---');
//   print(loginRequest.toString());
// }







