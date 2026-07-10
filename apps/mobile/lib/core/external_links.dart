import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// İletişim değerini (telefon, WhatsApp, web, e-posta) açılabilir bir [Uri]'ye
/// çevirir (P0 — misafir tek dokunuşla ulaşabilsin). Saf fonksiyon: test
/// edilebilir. Açılamayan tür (ör. VHF kanalı) ya da boş değer için `null` döner.
Uri? contactUri(String type, String value) {
  final String v = value.trim();
  if (v.isEmpty) return null;
  switch (type) {
    case 'phone':
    case 'emergency':
      final String d = _telDigits(v);
      return d.isEmpty ? null : Uri.parse('tel:$d');
    case 'whatsapp':
      final String d = _waDigits(v);
      return d.isEmpty ? null : Uri.parse('https://wa.me/$d');
    case 'email':
      return Uri.parse('mailto:$v');
    case 'website':
    case 'reservation_link':
    case 'instagram':
    case 'facebook':
      return _webUri(v);
    default:
      return null;
  }
}

/// Telefon için rakamları ayıklar; başında `+` varsa uluslararası biçimi korur.
String _telDigits(String v) {
  final bool plus = v.trimLeft().startsWith('+');
  final String d = v.replaceAll(RegExp(r'[^0-9]'), '');
  if (d.isEmpty) return '';
  return plus ? '+$d' : d;
}

/// WhatsApp uluslararası biçim ister (yalnızca rakam, `+` yok). Yerel `0` ile
/// başlayan numarayı Türkiye ülke koduyla (90) tamamlar.
String _waDigits(String v) {
  String d = v.replaceAll(RegExp(r'[^0-9]'), '');
  if (d.startsWith('0')) d = '90${d.substring(1)}';
  return d;
}

/// Web/sosyal medya değerini şemayla tamamlar (yoksa `https://` ekler).
Uri? _webUri(String v) {
  final String s =
      (v.startsWith('http://') || v.startsWith('https://')) ? v : 'https://$v';
  return Uri.tryParse(s);
}

/// [contactUri] ile bulunan bağlantıyı harici uygulamada açar (arama,
/// WhatsApp, tarayıcı, e-posta). Açılamazsa nazik bir uyarı gösterir.
Future<void> launchContact(BuildContext context, String type, String value) async {
  final Uri? uri = contactUri(type, value);
  if (uri == null) return;
  final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
  bool ok = false;
  try {
    ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
  } catch (_) {
    ok = false;
  }
  if (!ok) {
    messenger.showSnackBar(
      const SnackBar(content: Text('Bağlantı açılamadı.')),
    );
  }
}
