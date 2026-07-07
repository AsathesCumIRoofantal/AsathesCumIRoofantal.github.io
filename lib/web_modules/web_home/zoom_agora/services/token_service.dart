import 'dart:convert';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Token service — calls the Supabase Edge Function `agora_token_generator`
/// which runs server-side and never exposes your Agora App Certificate to
/// the client.
///
/// The WebRTC backend (Supabase Realtime signaling) does NOT need a token
/// at all — token renewal is only exercised when RtcConfig.backend is
/// switched back to RtcBackend.agora.
///
/// Edge function expected request body:  { channel, uid, role }
/// Edge function expected response body: { token, expiresAt }
///   where expiresAt is an ISO-8601 string, e.g. "2026-07-07T00:00:00Z"
class TokenService {
  static SupabaseClient get _client => Supabase.instance.client;

  /// Calls the `agora_token_generator` Supabase Edge Function.
  /// [role] is "publisher" or "subscriber".
  static Future<({String token, DateTime expiresAt})> fetchRtcToken({
    required String channel,
    required int uid,
    required String role,
  }) async {
    final response = await _client.functions.invoke(
      'agora_token_generator',
      body: {'channel': channel, 'uid': uid, 'role': role},
    );

    if (response.status != 200) {
      throw Exception(
        'agora_token_generator returned ${response.status}: ${response.data}',
      );
    }

    final data = response.data is String
        ? jsonDecode(response.data as String) as Map<String, dynamic>
        : response.data as Map<String, dynamic>;

    return (
      token: data['token'] as String,
      expiresAt: DateTime.parse(data['expiresAt'] as String),
    );
  }

  /// Calls `agora_token_generator` with role="subscriber" to get an RTM token.
  /// RTM tokens share the same Edge Function — the function checks the role
  /// field and returns an RTM-scoped token when role == "rtm".
  static Future<String> fetchRtmToken(String userId) async {
    final response = await _client.functions.invoke(
      'agora_token_generator',
      body: {'channel': userId, 'uid': 0, 'role': 'rtm'},
    );

    if (response.status != 200) {
      throw Exception(
        'agora_token_generator (rtm) returned ${response.status}: ${response.data}',
      );
    }

    final data = response.data is String
        ? jsonDecode(response.data as String) as Map<String, dynamic>
        : response.data as Map<String, dynamic>;

    return data['token'] as String;
  }
}
