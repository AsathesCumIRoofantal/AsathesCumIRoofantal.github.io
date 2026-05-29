// ============================================================
//  AIR App – API Client  (Supabase + HTTP abstraction)
// ============================================================
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../app/constants/app_constants.dart';
import '../storage/local_storage.dart';

class ApiClient extends GetxService {
  static ApiClient get to => Get.find();

  final _client = http.Client();

  // ── Base headers ──────────────────────────────────────────
  Map<String, String> get _headers => {
    'Content-Type':  'application/json',
    'apikey':        AppConstants.supabaseAnonKey,
    'Authorization': 'Bearer ${LocalStorage.to.accessToken ?? AppConstants.supabaseAnonKey}',
    'Prefer':        'return=representation',
  };

  String get _base => '${AppConstants.supabaseUrl}/rest/v1';

  // ── GET ───────────────────────────────────────────────────
  Future<dynamic> get(String path, {Map<String, String>? query}) async {
    if (AppConstants.isDummyMode) return null;
    try {
      final uri = Uri.parse('$_base/$path').replace(queryParameters: query);
      final res = await _client.get(uri, headers: _headers)
          .timeout(AppConstants.apiTimeout);
      return _parse(res);
    } catch (e) {
      _log('GET $path', e);
      rethrow;
    }
  }

  // ── POST ──────────────────────────────────────────────────
  Future<dynamic> post(String path, Map<String, dynamic> body) async {
    if (AppConstants.isDummyMode) return null;
    try {
      final uri = Uri.parse('$_base/$path');
      final res = await _client
          .post(uri, headers: _headers, body: jsonEncode(body))
          .timeout(AppConstants.apiTimeout);
      return _parse(res);
    } catch (e) {
      _log('POST $path', e);
      rethrow;
    }
  }

  // ── PATCH ─────────────────────────────────────────────────
  Future<dynamic> patch(String path, Map<String, dynamic> body,
      {Map<String, String>? query}) async {
    if (AppConstants.isDummyMode) return null;
    try {
      final uri = Uri.parse('$_base/$path').replace(queryParameters: query);
      final res = await _client
          .patch(uri, headers: _headers, body: jsonEncode(body))
          .timeout(AppConstants.apiTimeout);
      return _parse(res);
    } catch (e) {
      _log('PATCH $path', e);
      rethrow;
    }
  }

  // ── DELETE ────────────────────────────────────────────────
  Future<dynamic> delete(String path, {Map<String, String>? query}) async {
    if (AppConstants.isDummyMode) return null;
    try {
      final uri = Uri.parse('$_base/$path').replace(queryParameters: query);
      final res = await _client.delete(uri, headers: _headers)
          .timeout(AppConstants.apiTimeout);
      return _parse(res);
    } catch (e) {
      _log('DELETE $path', e);
      rethrow;
    }
  }

  // ── Edge Function ─────────────────────────────────────────
  Future<dynamic> callEdgeFunction(String fnName, Map<String, dynamic> body) async {
    if (AppConstants.isDummyMode) return null;
    try {
      final uri = Uri.parse('${AppConstants.supabaseUrl}/functions/v1/$fnName');
      final res = await _client
          .post(uri, headers: _headers, body: jsonEncode(body))
          .timeout(AppConstants.apiTimeout);
      return _parse(res);
    } catch (e) {
      _log('EDGE $fnName', e);
      rethrow;
    }
  }

  // ── Response parser ───────────────────────────────────────
  dynamic _parse(http.Response res) {
    if (res.statusCode >= 200 && res.statusCode < 300) {
      if (res.body.isEmpty) return null;
      return jsonDecode(res.body);
    }
    throw ApiException(res.statusCode, res.body);
  }

  void _log(String tag, Object e) {
    if (kDebugMode) debugPrint('❌ ApiClient [$tag]: $e');
  }
}

class ApiException implements Exception {
  final int    statusCode;
  final String message;
  ApiException(this.statusCode, this.message);
  @override String toString() => 'ApiException($statusCode): $message';
}
