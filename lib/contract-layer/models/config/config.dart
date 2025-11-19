//// Burda config class'i olusturulur,


// Config Model https://docs.google.com/document/d/1APiSxhHYixLapmIOYgImip4WaLFZJ6ZS5jPymIQoi8I/edit?hl=tr&tab=t.0

class Config {
  // --- SABİT YAPILANDIRMA AYARLARI (Örn. Keycloak, OIDC) ---

  /// Uygulamanın benzersiz tanımlayıcısı (Örn: com.example.app).
  final String bundleIdentifier;

  /// OIDC isteklerinde ve Keycloak veritabanında istemciyi tanımlamak için kullanılan alfanümerik ID dizesi.
  final String clientId;


  /// Frontend istekleri için sabit temel URL.
  final String frontendUrl;

  /// Realm (alan) adı.
  final String realm;

  /// Claim'leri istemek için kullanılan isteğe bağlı kapsam değerleri (scope values).
  final List<String>? additionalScopes;

  /// İstemcinin kimliğini Server'da  kanıtlamak için kullanılan parola.
  final String? clientSecret;

  /// Güvenli olmayan bağlantılara izin verilip verilmeyeceği.
  final bool _allowInsecureConnections;

  // --- UYGULAMA VE CİHAZ BİLGİLERİ ---

  /// Uygulama sürüm numarası (Örn: 1.0.0).
  final String appVersion;

  /// Uygulama dil ayarı (Örn: tr, en).
  final String language;

  /// Uygulamanın debug modunda olup olmadığı.
  final bool isDebug;

  /// Cihaz kimliği (Platforma özel ID).
  final String? deviceId;

  /// Cihazın IMEI kodu (Dikkat: Genellikle modern cihazlarda doğrudan erişilemez).
  final String? imei;

  /// Cihazın NFC özelliği desteği.
  final bool supportNFC;

  /// Cihazın GPS (Konum) desteği.
  final bool supportGPS;

  /// Cihazın işletim sistemi türü (Örn: Android, iOS, Web, Windows).
  final String deviceOSType;

  /// Uygulamanın bir emülatörde mi yoksa gerçek cihazda mı çalıştığı.
  final bool isEmulator;

  // DİNAMİK CİHAZ BİLGİLERİ (Çalışma anında değişebilir)

  /// Cihazın anlık bağlantı türü (Örn: Wifi, Mobile, None).
  final String connectionType;

  /// Cihaz ekranının genişliği ve yüksekliği (Örn: 1080x1920).
  final String screenSize;

  /// Cihazın bildirim izni durumu.
 final bool notificationPermission;

  // Yapılandırıcı (Constructor)
  Config({
    required this.bundleIdentifier,
    required this.clientId,
    required this.frontendUrl,
    required this.realm,
    this.additionalScopes,
    this.clientSecret,
    bool? allowInsecureConnections,

    // Cihaz/Uygulama Bilgileri için varsayılanlar/placeholdırlar
    required this.appVersion,
    required this.language,
    required this.isDebug,
    this.deviceId,
    this.imei,
    required this.supportNFC,
    required this.supportGPS,
    required this.deviceOSType,
    required this.isEmulator,
    required this.connectionType,
    required this.screenSize,
    required this.notificationPermission
  }) : _allowInsecureConnections =
  allowInsecureConnections ?? !frontendUrl.startsWith('https://'),
  assert(
  RegExp(r'^(?=.{1,255}$)[0-9A-Za-z](?:(?:[0-9A-Za-z]|-){0,61}[0-9A-Za-z])?(?:\.[0-9A-Za-z](?:(?:[0-9A-Za-z]|-){0,61}[0-9A-Za-z])?)*$')
      .hasMatch(bundleIdentifier),
  'Invalid bundle identifier: must be a valid hostname (no spaces, underscores, etc.).',
  );



  /// 📤 Config objesinin tüm alanlarını Map<String, dynamic> formatına dönüştürür.
  Map<String, dynamic> toJson() {
    return {
      'bundleIdentifier': bundleIdentifier,
      'clientId': clientId,
      'frontendUrl': frontendUrl,
      'realm': realm,
      'additionalScopes': additionalScopes,
      // clientSecret gibi hassas veriler genellikle request gövdesinde gönderilmez.
      // Ancak siz talep ettiğiniz için ekliyorum, dikkatli kullanılmalıdır.
      'clientSecret': clientSecret,
      'allowInsecureConnections': _allowInsecureConnections,

      // Cihaz/Uygulama Bilgileri
      'appVersion': appVersion,
      'language': language,
      'isDebug': isDebug,
      'deviceId': deviceId,
      'imei': imei,
      'supportNFC': supportNFC,
      'supportGPS': supportGPS,
      'deviceOSType': deviceOSType,
      'isEmulator': isEmulator,
      'connectionType': connectionType,
      'screenSize': screenSize,
    };
  }
// Not: _allowInsecureConnections yerine getter/setter olmadan doğrudan final
// 'allowInsecureConnections' kullandım, çünkü final bir değişkenin değeri
// constructorda belirlenir ve sonradan değiştirilemez.
}