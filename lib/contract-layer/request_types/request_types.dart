/// 📦 API isteğindeki 'Type' (Veri Yükü Türü) alanını tanımlayan abstract sınıf.
///
/// Sunucuya gönderilen data'nın yapısını (Payload Type) belirtmek için kullanılır.
/// Bu türler genellikle bir kayıt oluşturma/güncelleme (Create/Update),
/// sorgulama (Query) veya özel eylemler (Action) için kullanılır.

abstract class RequestTypes {
  const RequestTypes._();

  // --- Kullanıcı ve Kimlik Doğrulama Türleri ---

  /// İstek, yeni bir kullanıcı kaydı oluşturma verilerini içerir (Örn: Kayıt Ol).
  static const String userCreateType = 'UserCreateRequest';

  /// İstek, mevcut bir kullanıcının profil bilgilerini güncelleme verilerini içerir.
  static const String userUpdateType = 'UserUpdateRequest';

  /// İstek, kimlik doğrulama için gerekli bilgileri (Örn: e-posta, şifre) içerir (Örn: Giriş Yap).
  static const String authLoginType = 'AuthLoginRequest';

  /// İstek, unutulan şifre sıfırlama talebi için gerekli bilgileri (Örn: e-posta) içerir.
  static const String forgotPasswordType = 'ForgotPasswordRequest';

  /// İstek, kimlik doğrulama tokenlerini yenileme verilerini (Refresh Token) içerir.
  static const String tokenRefreshType = 'TokenRefreshRequest';

  // --- Veri Yönetimi Türleri (CRUD İşlemleri) ---

  /// İstek, yeni bir kaynak (ürün, makale, sipariş vb.) oluşturma verilerini içerir.
  static const String createRecordType = 'CreateRecordRequest';

  /// İstek, mevcut bir kaynağı (ürün, makale, sipariş vb.) güncelleme verilerini içerir.
  static const String updateRecordType = 'UpdateRecordRequest';

  /// İstek, bir kaynak listesini filtreleme, sayfalama veya sıralama parametrelerini içerir.
  static const String queryListType = 'QueryListRequest';

  // --- Özel Eylem Türleri ---

  /// İstek, sunucuda özel bir eylem başlatmak için gereken parametreleri içerir (Örn: Ödeme Yap, Bildirim Gönder).
  static const String actionType = 'ActionRequest';
}