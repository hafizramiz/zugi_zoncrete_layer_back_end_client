/// Error, Warning, Info ve benzeri sekilde geri donusler elde edilir
/// Status koduna gore extension metotlar ile redirection yapilir.
/// Gelen status kodlarina gore otomatik redicetion yapilacak
/// Her response'da bir redirection kod bulunuyor Bu koda gore bir redirection yapilacak

/// 🚦 API yanıtlarında kullanılan standart HTTP Durum Kodlarını tanımlayan abstract sınıf.
///
/// Sayısal değerler yerine anlamlı sabit isimler kullanarak kodun okunabilirliğini artırır.
abstract class HttpStatusCodes {
  const HttpStatusCodes._();

  // --- 1xx Bilgilendirme Yanıtları (Informational responses) ---

  /// İstek alındı ve işlem devam ediyor.
  static const int continueCode = 100;

  // --- 2xx Başarı Yanıtları (Success) ---

  /// İstek başarıyla gerçekleştirildi. (GET, PUT, PATCH, DELETE için yaygın)
  static const int ok = 200;

  /// İstek başarılı oldu ve sonuç olarak yeni bir kaynak oluşturuldu. (POST için yaygın)
  static const int created = 201;

  /// İstek kabul edildi, ancak işleme henüz tamamlanmadı.
  static const int accepted = 202;

  /// İstek başarıyla işlendi ve yanıt gövdesi yok. (DELETE, PUT, PATCH için yaygın)
  static const int noContent = 204;

  // --- 3xx Yönlendirme Yanıtları (Redirection) ---

  /// İstenen kaynak başka bir URI'ye taşındı.
  static const int seeOther = 303;

  /// İstenen kaynak için bir önbellek (cache) kullanılması gerekiyor.
  static const int notModified = 304;

  // --- 4xx İstemci Hata Yanıtları (Client errors) ---

  /// İstek hatalı biçimlendirilmiş. (Genel istemci hatası)
  static const int badRequest = 400;

  /// Kimlik doğrulama bilgisi eksik veya geçersiz. (Giriş yapılmamış)
  static const int unauthorized = 401;

  /// Sunucunun kaynağa erişim yetkisi yok. (Giriş yapılmış ancak yetkisiz)
  static const int forbidden = 403;

  /// İstenen kaynak sunucuda bulunamadı.
  static const int notFound = 404;

  /// İstenen metot (GET, POST vb.) bu kaynak için desteklenmiyor.
  static const int methodNotAllowed = 405;

  /// İstek, sunucunun mevcut durumunda çakışmaya neden oluyor. (Örn: Zaten var olan bir kaynağı tekrar oluşturma)
  static const int conflict = 409;

  /// Sunucu, istekte belirtilen içerik türünü (Content-Type) işleyemiyor.
  static const int unsupportedMediaType = 415;

  // --- 5xx Sunucu Hata Yanıtları (Server errors) ---

  /// Sunucuda beklenmeyen bir hata oluştu. (Genel sunucu hatası)
  static const int internalServerError = 500;

  /// Sunucu, isteği yerine getirmek için gerekli işlevi desteklemiyor.
  static const int notImplemented = 501;

  /// Sunucu, ağ geçidi veya vekil sunucu olarak işlev görürken geçersiz bir yanıt aldı.
  static const int badGateway = 502;

  /// Sunucu şu anda isteği işleyemeyecek durumda (genellikle bakım veya aşırı yüklenme nedeniyle).
  static const int serviceUnavailable = 503;
}
