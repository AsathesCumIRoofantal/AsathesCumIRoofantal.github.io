import 'dart:convert';
import 'package:http/http.dart' as http;

/// Calls YOUR token server. Replace [endpoint].
class TokenService {
  static const endpoint = 'https://YOUR-TOKEN-SERVER.example.com';

  /// TODO(backend): implement /rtc-token returning { token, expiresAt }
  static Future<({String token, DateTime expiresAt})> fetchRtcToken({
    required String channel, required int uid, required String role,
  }) async {
    final r = await http.get(Uri.parse('$endpoint/rtc-token?channel=$channel&uid=$uid&role=$role'));
    final j = jsonDecode(r.body);
    return (token: j['token'] as String, expiresAt: DateTime.parse(j['expiresAt']));
  }

  /// TODO(backend): /rtm-token for chat/data-stream auth
  static Future<String> fetchRtmToken(String userId) async {
    final r = await http.get(Uri.parse('$endpoint/rtm-token?uid=$userId'));
    return jsonDecode(r.body)['token'] as String;
  }
}
