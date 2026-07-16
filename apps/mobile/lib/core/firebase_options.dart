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

/// iOS uygulaması yapılandırması (Firebase konsol kaydı 2026-07-16,
/// GoogleService-Info.plist'ten). Bu değerler de gizli değildir — web ile aynı
/// kural: proje adres etiketleridir, erişim güvenliği Authentication
/// kurallarıyla sağlanır. Tip nullable kalır: bootstrap sözleşmesi
/// (null → Firebase başlatılmaz) değişmez.
FirebaseOptions? get mooriraFirebaseOptionsIos => const FirebaseOptions(
      apiKey: 'AIzaSyCNYBliV534O2y15hxYUNYOjYzuH6WtoiY',
      appId: '1:1072474722600:ios:eaa0c6981dd6279986c01d',
      messagingSenderId: '1072474722600',
      projectId: 'moorira',
      storageBucket: 'moorira.firebasestorage.app',
      iosBundleId: 'com.moorira.app',
      iosClientId:
          '1072474722600-kbbiqlhgd991mm46umsnk1h4vu8a5uo9.apps.googleusercontent.com',
    );
