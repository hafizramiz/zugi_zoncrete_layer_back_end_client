/// 🚀 Uygulama içindeki ana istek tiplerini (metot kodlarını) tanımlayan
/// abstract sınıf.
///
/// Tüm kodlar, sınıfın adıyla doğrudan erişilebilen static const int
/// değişkenler olarak tanımlanmıştır.
abstract class MethodIds {
  // Bu sınıf abstract olduğu için instance (örnek) oluşturulamaz.
  // Private constructor ekleyerek bu durumu pekiştirebiliriz.
  const MethodIds._();

  // --- UYGULAMA YAŞAM DÖNGÜSÜ (0 - 99) ---

  /// Uygulama açılışındaki ilk veri çekme/hazırlık isteği.
  static const int splashInit = 0;

  /// Config ayarlarını sunucudan çekme (varsa).
  static const int fetchRemoteConfig = 1;

  /// Giriş ekranı (Login) sırasında kimlik doğrulama isteği (OIDC Token alma).
  static const int userLogin = 10;

  /// Çıkış yapma (Logout) isteği.
  static const int userLogout = 11;

  /// Yenileme tokeni (Refresh Token) ile yeni erişim tokeni alma isteği.
  static const int exchangeToken = 12;

  // --- KULLANICI İŞLEMLERİ (100 - 199) ---

  /// Kullanıcı profil bilgilerini çekme isteği.
  static const int fetchUserProfile = 100;

  /// Kullanıcı şifresini güncelleme isteği.
  static const int updatePassword = 101;

  /// Kayıtlı cihaz listesini çekme.
  static const int fetchRegisteredDevices = 110;

  // --- ANA EKRAN / DASHBOARD (200 - 299) ---

  /// Dashboard (Ana Sayfa) verilerini çekme.
  static const int fetchDashboardData = 200;

  /// Bildirim listesini çekme.
  static const int fetchNotifications = 201;

  /// Belirli bir bildirimi okundu olarak işaretleme.
  static const int markNotificationAsRead = 202;

  // --- VERİ İŞLEMLERİ / CRUD ÖRNEĞİ (300 - 399) ---

  /// Yeni bir kayıt oluşturma isteği.
  static const int createRecord = 300;

  /// Mevcut bir kaydı güncelleme isteği.
  static const int updateRecord = 301;

  /// Kayıt detaylarını çekme isteği.
  static const int fetchRecordDetails = 302;

  /// Kayıt listesini çekme isteği.
  static const int fetchRecordList = 303;
}


/// Ornek o numarali request atildiginda 0 numarali response donecek.