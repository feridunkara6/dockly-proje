import 'package:firebase_core/firebase_core.dart';

/// Moorira Firebase projesi — WEB uygulaması yapılandırması (proje: moorira).
///
/// Bu değerler GİZLİ DEĞİLDİR (docs/24 §7.1): şifre/anahtar değil, projenin
/// adres etiketleridir; Google bunların istemciye gömülmesini öngörür. Erişim
/// güvenliği Authentication kuralları + yetkili alan adları (moorira.com) ile
/// sağlanır.
const FirebaseOptions mooriraFirebaseOptionsWeb = FirebaseOptions(
  apiKey: 'AIzaSyCU-b560CUR29mPETh27mEZxVbFmrVBuRU',
  authDomain: 'moorira.firebaseapp.com',
  projectId: 'moorira',
  storageBucket: 'moorira.firebasestorage.app',
  messagingSenderId: '1072474722600',
  appId: '1:1072474722600:web:d68770dca002165486c01d',
  measurementId: 'G-KMZXH18WNW',
);

/// iOS uygulaması yapılandırması (mağaza fazı). Değerler, Firebase konsolunda
/// iOS uygulaması (bundle: com.moorira.app) kaydedilince buraya yazılacak —
/// rehberdeki "Firebase'e iOS ekle" adımı. NULL iken bootstrap Firebase'i
/// mobilde HİÇ başlatmaz: uygulama misafir modda tam çalışır, giriş düğmeleri
/// nazik mesaj gösterir (çökme yok). Bu değerler de gizli değildir.
FirebaseOptions? get mooriraFirebaseOptionsIos => null;
