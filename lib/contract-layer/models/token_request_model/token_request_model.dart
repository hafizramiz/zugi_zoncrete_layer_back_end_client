// TOKEN EXCHANGE REQUEST MODEL

import 'package:zugi_zoncrete_layer_back_end_client/contract-layer/methodids/method_ids.dart';

/// Uygulamadan sunucuya gönderilen genel API İstek Modelini temsil eden sınıfın
/// Token Değişim İsteği (Token Request) için özelleştirilmiş hali.
///
/// Bu model, hem genel istek standartlarını (type, methodId) hem de
/// OAuth 2.0 Token Değişimi için gerekli alanları kapsar.
class TokenRequestModel {
  // Genel API İstek Alanları (Orijinal InitRequestModel'den)
  final String type; // Örn: 'TRequest' veya OAuth için 'TokenRequest'
  final String requestTag; // Hangi sayfadan/işlemden geldiği
  final int methodId; // API metot kimliği (Örn: MethodIds.exchangeToken)
  // OAuth 2.0 Token Değişimine Özel Alanlar (TokenRequest'ten)
  final String clientId;
  final String? clientSecret;
  final String? refreshToken;
  static const String _typeKey = '__type';

  TokenRequestModel({
    required this.type,
    required this.requestTag,
    required this.methodId,
    required this.clientId,
    this.clientSecret,
    this.refreshToken,
  });
}



///
/// Ornek cikti
//{
//   "type": "TokenRequest",
//   "requestTag": "login_process",
//   "methodId": 1001,
//   "clientId": "my-app-client-id",
//   "clientSecret": "my-app-client-secret",
//   "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
// }


//How to use --- Örnek Kullanım ---
void main() {
  // Authorization Code Grant (Yetkilendirme Kodu Verme) akışı için örnek
  const String authCode = 'ey...auth_code...jkl';

  final tokenRequest = TokenRequestModel(
    type: 'TokenRequest',
    // Temsilci türü
    requestTag: 'TokenExchangeService',
    methodId: MethodIds.exchangeToken,
    // Örn: Token Exchange için özel bir ID
    clientId: 'my_app_client_id_123',
  );

  print('--- TOKEN EXCHANGE REQUEST GÖVDESİ (AUTHORIZATION CODE) ---');
}
