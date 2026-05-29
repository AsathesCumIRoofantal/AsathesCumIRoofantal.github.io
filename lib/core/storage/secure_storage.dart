// ============================================================
//  AIR App – Secure Storage  (flutter_secure_storage wrapper)
// ============================================================
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class SecureStorage extends GetxService {
  static SecureStorage get to => Get.find();

  static const _opts = AndroidOptions(encryptedSharedPreferences: true);
  final _storage = const FlutterSecureStorage(aOptions: _opts);

  // ── Keys ─────────────────────────────────────────────────
  static const _kJwt         = 'jwt_token';
  static const _kRefresh     = 'refresh_token';
  static const _kDeviceId    = 'device_id';
  static const _kPinHash     = 'pin_hash';

  // ── JWT ──────────────────────────────────────────────────
  Future<void>   saveJwt(String token)     => _storage.write(key: _kJwt, value: token);
  Future<String?> readJwt()                => _storage.read(key: _kJwt);
  Future<void>   deleteJwt()               => _storage.delete(key: _kJwt);

  // ── Refresh ──────────────────────────────────────────────
  Future<void>   saveRefresh(String token) => _storage.write(key: _kRefresh, value: token);
  Future<String?> readRefresh()            => _storage.read(key: _kRefresh);

  // ── Device ID ────────────────────────────────────────────
  Future<void>   saveDeviceId(String id)   => _storage.write(key: _kDeviceId, value: id);
  Future<String?> readDeviceId()           => _storage.read(key: _kDeviceId);

  // ── App PIN ──────────────────────────────────────────────
  Future<void>   savePinHash(String hash)  => _storage.write(key: _kPinHash, value: hash);
  Future<String?> readPinHash()            => _storage.read(key: _kPinHash);

  // ── Generic ──────────────────────────────────────────────
  Future<void>   write(String key, String value) => _storage.write(key: key, value: value);
  Future<String?> read(String key)               => _storage.read(key: key);
  Future<void>   delete(String key)              => _storage.delete(key: key);

  // ── Full wipe (logout) ───────────────────────────────────
  Future<void>   clearAll()                      => _storage.deleteAll();
}
