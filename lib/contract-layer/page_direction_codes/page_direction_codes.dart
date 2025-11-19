/// 🚦 Uygulama içindeki sayfa yönlendirmeleri için kullanılan sabit kodları tanımlayan
/// abstract sınıf.
abstract class PageDirectionCodes {
  // Bu sınıf abstract olduğu için instance (örnek) oluşturulamaz.
  const PageDirectionCodes._();

  // ============================================================
  // 0 - 9: GENEL VE VARSAYILAN DURUMLAR
  // ============================================================

  /// Yönlendirme yok, mevcut sayfada kal.
  static const int none = 0;

  // ============================================================
  // 10 - 49: BAŞARILI İŞLEM VE HESAP YÖNETİMİ
  // ============================================================

  /// Başarılı giriş veya işlem sonrası ana sayfaya yönlendirme.
  static const int home = 10;

  /// Profil düzenleme sayfasına yönlendirme.
  static const int editProfile = 11;

  // ============================================================
  // 50 - 99: GÜVENLİK, HATA VE SİSTEM DURUMLARI
  // ============================================================

  /// Kullanıcının parola sıfırlama sayfasına yönlendirilmesi gerekiyor.
  static const int passwordReset = 50;

  /// Kullanıcının cihaz doğrulaması (OTP, vs.) yapması gerekiyor.
  static const int deviceVerification = 51;

  /// Uygulama bakımdaysa gösterilecek sayfa.
  static const int maintenance = 98;

  /// Giriş sayfasına geri dön (Session timeout vb.).
  static const int login = 99;






  // ============================================================
  // 100 - 199: PREVIEW FEATURES & İÇERİK MODÜLLERİ
  // ============================================================

  /// 📚 Etkinlik Kitapları modülüne yönlendirir.
  /// (PreviewFeature: activity_books)
  static const int activityBooks = 100;

  /// 🎬 Videolar/İzle modülüne yönlendirir.
  /// (PreviewFeature: videos)
  static const int videos = 101;

  /// 🧩 Temel Beceriler (Eğitici Oyunlar/Aktiviteler) modülüne yönlendirir.
  /// (PreviewFeature: basic_skills)
  static const int basicSkills = 102;

  /// 📖 Okuma Listesi / Kütüphane modülüne yönlendirir.
  /// (PreviewFeature: reading_list)
  static const int readingList = 103;

// Gelecekte eklenebilecekler için yer ayrıldı:
// static const int games = 104;
// static const int achievements = 105;
}