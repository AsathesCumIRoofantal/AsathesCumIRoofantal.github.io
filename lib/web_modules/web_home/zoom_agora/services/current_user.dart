import 'package:supabase_flutter/supabase_flutter.dart';

/// `user_table.user_id` (its own internal PK) is what `meetings.host_id`
/// and `meeting_participants.user_id` actually store — it is **not** the
/// same value as `auth.uid()`. The link between them is
/// `user_table.auth_user_id`. So getting "the current user" for this
/// module means: read the auth session, then resolve the matching
/// `user_table.user_id` through `auth_user_id` — not assume the two ids
/// are interchangeable.
class CurrentUser {
  CurrentUser._();
  static SupabaseClient get _client => Supabase.instance.client;

  static bool get isSignedIn => _client.auth.currentUser != null;

  /// Raw Supabase Auth id (`auth.users.id` / `auth.uid()`). Rarely what
  /// you actually want downstream in this schema — see [id].
  static String get authUid {
    final u = _client.auth.currentUser;
    if (u == null) throw StateError('No authenticated user.');
    return u.id;
  }

  static String? _resolvedUserId; // user_table.user_id
  static String? _resolvedName;

  /// `user_table.user_id` — the id every relevant FK in this schema
  /// (`meetings.host_id`, `meeting_participants.user_id`) wants. Throws
  /// if [ensureProfileLoaded] hasn't resolved it yet: that's intentional,
  /// sending the wrong id into a NOT NULL foreign key is worse than
  /// failing loudly.
  static String get id {
    final resolved = _resolvedUserId;
    if (resolved == null) {
      throw StateError(
        'CurrentUser.id not resolved yet — call '
        '`await CurrentUser.ensureProfileLoaded()` once after sign-in '
        '(e.g. right after your OTP-verify step) before creating or '
        'joining a meeting.',
      );
    }
    return resolved;
  }

  /// Best-known display name; falls back to auth metadata until
  /// [ensureProfileLoaded] resolves the real `user_table.name`.
  static String get name =>
      _resolvedName ??
      (_client.auth.currentUser?.userMetadata?['name'] as String?) ??
      'Guest';

  /// Resolves `user_table.user_id` + `name` via `auth_user_id = auth.uid()`.
  /// Call this once after sign-in, and again here in `zoom_agora`'s own
  /// binding before every join (cheap once cached — pass `force: true`
  /// only if the profile might have changed since).
  static Future<void> ensureProfileLoaded({bool force = false}) async {
    if (!isSignedIn) return;
    if (_resolvedUserId != null && !force) return;

    final row = await _client
        .from('user_table')
        .select('user_id, name')
        .eq('auth_user_id', authUid)
        .maybeSingle();

    if (row == null) {
      throw StateError(
        'No user_table row found for auth_user_id=$authUid. Your signup '
        '/ verify_otp flow needs to insert a user_table row linked via '
        'auth_user_id before this user can create or join a meeting — '
        'see supabase_patch_meeting_live.sql for a trigger that does '
        'this automatically going forward.',
      );
    }
    _resolvedUserId = row['user_id'] as String;
    _resolvedName = row['name'] as String?;
  }

  /// Call on sign-out so a next sign-in doesn't reuse a stale profile.
  static void clear() {
    _resolvedUserId = null;
    _resolvedName = null;
  }
}
