/// 🏷️ API yanıtındaki 'Type' (Veri Yükü Türü) alanını tanımlayan abstract sınıf.
///
/// Sunucudan gelen data'nın yapısını (Payload Type) belirtmek için kullanılır.
/// Modeller onceden belirlenir. Back'endden bu modellerinden birini donmesi istenir.

abstract class ResponseTypes {
  const ResponseTypes._();

  // --- Kullanıcı ve Kimlik Doğrulama Türleri ---

  /// Yanıt, kullanıcı profil bilgilerini içerir.
  static const String userResponseType = 'UserResponse';

  /// Yanıt, kimlik doğrulama tokenlerini (JWT, Refresh) içerir.
  static const String authResponseType = 'AuthResponse';

  /// Yanıt, kullanıcı oturum durumunu (Session Status) içerir.
  static const String sessionResponseType = 'SessionStatusResponse';

  // --- Veri Listesi Türleri ---

  /// Yanıt, bir kayıt listesi içerir (Örn: ürünler, siparişler).
  static const String listResponseType = 'ListResponse';

  /// Yanıt, tek bir kayıt veya detayı içerir.
  static const String detailResponseType = 'DetailResponse';
}


