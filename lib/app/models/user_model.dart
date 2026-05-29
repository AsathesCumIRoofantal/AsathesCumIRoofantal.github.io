// ============================================================
//  AIR App – User Model  (mirrors Supabase user_table)
// ============================================================
class UserModel {
  final String   userId;
  final int      userRole;
  final List<String> assignedUserIds;
  final String   name;
  final String   mobile;
  final String?  profilePhotoUrl;
  final String?  companyLogoUrl;
  final String?  address;
  final double?  latitude;
  final double?  longitude;
  final String?  userRoleTitle;
  final String?  userRoleSubTitle;
  final bool     isCanInsertInDb;
  final bool     isActive;
  final bool     isBlocked;
  final bool     isApproved;
  final bool     isPaid;
  final bool     isMember;
  final int      createdAt;   // epoch
  final String?  createdBy;
  final int      updatedAt;   // epoch
  final String?  updatedBy;
  final int      timeSlotForBatchChat;
  final String?  userLastLoginLogsId;

  const UserModel({
    required this.userId,
    required this.userRole,
    this.assignedUserIds = const [],
    required this.name,
    required this.mobile,
    this.profilePhotoUrl,
    this.companyLogoUrl,
    this.address,
    this.latitude,
    this.longitude,
    this.userRoleTitle,
    this.userRoleSubTitle,
    this.isCanInsertInDb = false,
    this.isActive        = true,
    this.isBlocked       = false,
    this.isApproved      = false,
    this.isPaid          = false,
    this.isMember        = false,
    required this.createdAt,
    this.createdBy,
    required this.updatedAt,
    this.updatedBy,
    this.timeSlotForBatchChat = 1,
    this.userLastLoginLogsId,
  });

  factory UserModel.fromJson(Map<String, dynamic> j) => UserModel(
    userId:               j['user_id']          as String,
    userRole:             j['user_role']         as int,
    assignedUserIds:      (j['assigned_userIds'] as List? ?? []).cast<String>(),
    name:                 j['name']              as String,
    mobile:               j['mobile']            as String,
    profilePhotoUrl:      j['profile_photo_url'] as String?,
    companyLogoUrl:       j['company_logo_url']  as String?,
    address:              j['address']           as String?,
    latitude:             (j['latitude']         as num?)?.toDouble(),
    longitude:            (j['longitude']        as num?)?.toDouble(),
    userRoleTitle:        j['user_role_title']   as String?,
    userRoleSubTitle:     j['user_role_Sub_title'] as String?,
    isCanInsertInDb:      (j['is_can_insert_in_db'] as int? ?? 0) == 1,
    isActive:             (j['isActive']          as int? ?? 1) == 1,
    isBlocked:            (j['is_blocked']        as int? ?? 0) == 1,
    isApproved:           (j['isApproved']        as int? ?? 0) == 1,
    isPaid:               (j['is_paid']           as int? ?? 0) == 1,
    isMember:             (j['is_member']         as int? ?? 0) == 1,
    createdAt:            j['created_at']         as int,
    createdBy:            j['created_by']         as String?,
    updatedAt:            j['updated_at']         as int,
    updatedBy:            j['updated_by']         as String?,
    timeSlotForBatchChat: j['time_slot_for_batch_chat_allow_1_to_48'] as int? ?? 1,
    userLastLoginLogsId:  j['user_last_logingLogsId'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'user_id':           userId,
    'user_role':         userRole,
    'assigned_userIds':  assignedUserIds,
    'name':              name,
    'mobile':            mobile,
    'profile_photo_url': profilePhotoUrl,
    'company_logo_url':  companyLogoUrl,
    'address':           address,
    'latitude':          latitude,
    'longitude':         longitude,
    'user_role_title':   userRoleTitle,
    'user_role_Sub_title': userRoleSubTitle,
    'is_can_insert_in_db': isCanInsertInDb ? 1 : 0,
    'isActive':          isActive   ? 1 : 0,
    'is_blocked':        isBlocked  ? 1 : 0,
    'isApproved':        isApproved ? 1 : 0,
    'is_paid':           isPaid     ? 1 : 0,
    'is_member':         isMember   ? 1 : 0,
    'created_at':        createdAt,
    'created_by':        createdBy,
    'updated_at':        updatedAt,
    'updated_by':        updatedBy,
    'time_slot_for_batch_chat_allow_1_to_48': timeSlotForBatchChat,
    'user_last_logingLogsId': userLastLoginLogsId,
  };

  /// Dummy user for testing
  static UserModel get dummy => UserModel(
    userId:    'usr_demo_001',
    userRole:  1,
    name:      'Demo User',
    mobile:    '+91 98765 43210',
    isActive:  true,
    isApproved: true,
    createdAt: DateTime.now().millisecondsSinceEpoch,
    updatedAt: DateTime.now().millisecondsSinceEpoch,
  );
}
