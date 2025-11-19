import 'dart:convert';

/// Backend'den Splash Screen aşamasında alınan tüm uzaktan yapılandırma (Remote Config)
/// ayarlarını ve Feature Flags'i tutan model.
class RemoteConfigResponseModel {
  // 1. Sürüm Kontrolü ve Yönlendirme
  final String minSupportedVersion;
  final bool forceUpdate;
  final String apiBaseUrl;

  // 2. Uygulama Ayarları
  final int timeoutSeconds; // Örn: Sonraki istekler için zaman aşımı
  final int sessionTimeoutMinutes; // Örn: Yerel oturum süresi
  final String configHash; // Önbellek kontrolü için

  // 3. Özellik Bayrakları (Feature Flags)
  final Map<String, bool> featureFlags;

  // Eğer sunucunuz bu ayarları kök dizinde değil de 'data' içinde gönderiyorsa,
  // bu model 'data' alanındaki içeriği temsil eder.

  RemoteConfigResponseModel({
    required this.minSupportedVersion,
    required this.forceUpdate,
    required this.apiBaseUrl,
    required this.timeoutSeconds,
    required this.sessionTimeoutMinutes,
    required this.configHash,
    required this.featureFlags,
  });

  /// Gelen JSON verisinden modeli oluşturan factory constructor.
  factory RemoteConfigResponseModel.fromJson(Map<String, dynamic> json) {
    return RemoteConfigResponseModel(
      minSupportedVersion: json['minSupportedVersion'] as String,
      forceUpdate: json['forceUpdate'] as bool,
      apiBaseUrl: json['apiBaseUrl'] as String,
      timeoutSeconds: json['timeoutSeconds'] as int? ?? 15, // Varsayılan değer 15 saniye
      sessionTimeoutMinutes: json['sessionTimeoutMinutes'] as int? ?? 30, // Varsayılan değer 30 dakika
      configHash: json['configHash'] as String? ?? '',

      // Feature Flags haritasını güvenli bir şekilde ayrıştırma
      featureFlags: Map<String, bool>.from(
        json['featureFlags'] as Map<String, dynamic>? ?? {},
      ),
    );
  }

  // Modeli JSON formatına geri dönüştürme (Örn: Yerel önbelleğe kaydetmek için)
  Map<String, dynamic> toJson() {
    return {
      'minSupportedVersion': minSupportedVersion,
      'forceUpdate': forceUpdate,
      'apiBaseUrl': apiBaseUrl,
      'timeoutSeconds': timeoutSeconds,
      'sessionTimeoutMinutes': sessionTimeoutMinutes,
      'configHash': configHash,
      'featureFlags': featureFlags,
    };
  }
}


// --- Örnek Kullanım (Simülasyon) ---
void main() {
  // Backend'den gelen varsayımsal JSON yanıtı
  const String remoteConfigJson = '''
  {
    "minSupportedVersion": "1.4.2",
    "forceUpdate": false,
    "apiBaseUrl": "https://api.myapp.com/v1/",
    "timeoutSeconds": 20,
    "sessionTimeoutMinutes": 45,
    "configHash": "XYZ123ABC",
    "featureFlags": {
      "isNewUiEnabled": true,
      "isNfcPaymentActive": false,
      "isPromoBannerVisible": true
    }
  }
  ''';

  final Map<String, dynamic> jsonMap = json.decode(remoteConfigJson) as Map<String, dynamic>;

  // Modeli oluştur
  final config = RemoteConfigResponseModel.fromJson(jsonMap);

  print('--- REMOTE CONFIG ALINDI ---');
  print('API Adresi: ${config.apiBaseUrl}');
  print('Zorunlu Güncelleme: ${config.forceUpdate ? 'EVET' : 'HAYIR'}');
  print('Yeni UI Aktif mi? ${config.featureFlags['isNewUiEnabled']}');

  // Uygulama Sürüm Kontrolü Örneği
  const String currentAppVersion = '1.4.1';

  if (currentAppVersion.compareTo(config.minSupportedVersion) < 0 || config.forceUpdate) {
    print('\n⚠️ UYARI: Uygulama sürümü (${currentAppVersion}) eskimiş. Güncelleme gerekli!');
    // Flutter: Kullanıcıyı Store'a yönlendir.
  } else {
    print('\n✅ Yapılandırma Başarılı. Uygulama çalışmaya devam edebilir.');
  }
}