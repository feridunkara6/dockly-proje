import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

/// Ağsız test için sahte HttpClientAdapter (yalnız testte mock kuralı, docs/15).
/// Sıraya konan yanıtları döndürür; istekleri kaydeder.
class FakeAdapter implements HttpClientAdapter {
  final List<_Canned> _queue = <_Canned>[];
  final List<RequestOptions> received = <RequestOptions>[];

  void enqueueJson(int statusCode, Object body, {String? contentType}) {
    _queue.add(_Canned(statusCode, jsonEncode(body), contentType ?? 'application/json'));
  }

  void enqueueProblem(int statusCode, Map<String, dynamic> problem) {
    _queue.add(_Canned(statusCode, jsonEncode(problem), 'application/problem+json'));
  }

  void enqueueEmpty(int statusCode) {
    _queue.add(_Canned(statusCode, '', 'application/json'));
  }

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    received.add(options);
    if (_queue.isEmpty) {
      throw StateError('FakeAdapter: sıraya konmuş yanıt yok (${options.path})');
    }
    final canned = _queue.removeAt(0);
    return ResponseBody.fromString(
      canned.body,
      canned.statusCode,
      headers: <String, List<String>>{
        Headers.contentTypeHeader: <String>[canned.contentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

class _Canned {
  _Canned(this.statusCode, this.body, this.contentType);

  final int statusCode;
  final String body;
  final String contentType;
}
