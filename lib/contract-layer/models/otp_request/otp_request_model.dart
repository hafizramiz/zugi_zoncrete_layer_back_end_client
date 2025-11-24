
import 'dart:convert';

/// OTP (Tek Kullanımlık Şifre) istek modeli
class OtpRequestModel {
  final String phone;

  const OtpRequestModel({
    required this.phone,
  });

  /// Fabrika metodu: JSON verisini modele dönüştürür.
  factory OtpRequestModel.fromJson(Map<String, dynamic> json) {
    return OtpRequestModel(
      phone: json['phone'] as String,
    );
  }

  /// Modeli JSON formatına dönüştürür.
  Map<String, dynamic> toJson() => {
    'phone': phone,
  };

  @override
  String toString() => 'OtpRequestModel(phone: $phone)';
}
