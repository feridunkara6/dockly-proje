/// Karşılama sorusunun ("Teknen kaç metre?") yalnız BİR KEZ sorulmasını sağlayan
/// kalıcı bayrak. En iyi çaba: depolama çalışmıyorsa kullanıcıyı her açılışta
/// rahatsız etmemek için "soruldu" varsayılır (asla fırlatmaz).
abstract interface class WelcomeStore {
  Future<bool> wasShown();
  Future<void> markShown();
}
