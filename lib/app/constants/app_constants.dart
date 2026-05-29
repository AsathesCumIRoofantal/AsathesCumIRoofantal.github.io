// ============================================================
//  AIR App – App Constants
//  Centralised config keys, feature-flags & dummy-mode toggle
// ============================================================

class AppConstants {
  AppConstants._();

  // ── App Info ────────────────────────────────────────────────
  static const String appName      = 'AIR-Space';
  static const String appVersion   = '1.0.0';
  static const String packageName  = 'air_app';

  // ── Feature Flags ──────────────────────────────────────────
  /// Set [true] to run fully on dummy/local data (no backend needed)
  static const bool isDummyMode    = true;

  /// Primary video engine toggle  (false = Agora, true = Flutter WebRTC)
  static const bool isAgoraNotUsed = false;

  /// Enable dark-mode persistence
  static const bool persistTheme   = true;

  // ── Supabase ────────────────────────────────────────────────
  static const String supabaseUrl      = String.fromEnvironment('SUPABASE_URL',  defaultValue: '');
  static const String supabaseAnonKey  = String.fromEnvironment('SUPABASE_ANON', defaultValue: '');

  // ── Agora ───────────────────────────────────────────────────
  static const String agoraAppId    = String.fromEnvironment('AGORA_APP_ID',   defaultValue: '');
  static const String agoraTempToken = String.fromEnvironment('AGORA_TOKEN',    defaultValue: '');

  // ── Cloudflare R2 ───────────────────────────────────────────
  static const String r2AccountId   = String.fromEnvironment('R2_ACCOUNT_ID',  defaultValue: '');
  static const String r2AccessKey   = String.fromEnvironment('R2_ACCESS_KEY',  defaultValue: '');
  static const String r2SecretKey   = String.fromEnvironment('R2_SECRET_KEY',  defaultValue: '');
  static const String r2BucketName  = String.fromEnvironment('R2_BUCKET',      defaultValue: 'air-app-assets');
  static const String cdnBaseUrl    = String.fromEnvironment('CDN_URL',        defaultValue: '');

  // ── Timing ──────────────────────────────────────────────────
  static const Duration apiTimeout          = Duration(seconds: 30);
  static const Duration tokenRefreshBuffer  = Duration(minutes: 5);
  static const Duration otpExpiry           = Duration(minutes: 10);
  static const Duration sessionExpiry       = Duration(days: 30);
  static const Duration tempFileCleanup     = Duration(minutes: 10);

  // ── Pagination ──────────────────────────────────────────────
  static const int defaultPageSize     = 20;
  static const int chatMessagePageSize = 40;
  static const int meetingPageSize     = 15;

  // ── Media Limits ────────────────────────────────────────────
  static const int maxImageSizeMB      = 10;
  static const int maxVideoSizeMB      = 100;
  static const int maxFileSizeMB       = 50;
  static const int maxVoiceNoteSecs    = 300;

  // ── Storage Folder Paths ────────────────────────────────────
  static const String folderUsers     = 'users';
  static const String folderChats     = 'chats';
  static const String folderMeetings  = 'meetings';
  static const String folderProfiles  = 'profile';
  static const String folderCompany   = 'company';
  static const String folderTemp      = 'temp';

  // ── Local Storage Keys ──────────────────────────────────────
  static const String keyThemeMode    = 'theme_mode';
  static const String keyAccessToken  = 'access_token';
  static const String keyRefreshToken = 'refresh_token';
  static const String keyUserId       = 'user_id';
  static const String keyUserRole     = 'user_role';
  static const String keyOnboarded    = 'is_onboarded';
  static const String keyLastRoute    = 'last_route';
}
