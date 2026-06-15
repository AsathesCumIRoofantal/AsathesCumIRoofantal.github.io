enum UserRole { superAdmin, admin, manager, agent, member, guest }

class AirUser {
  final String userId;

  final int userRole;

  final List<String> assignedUserIds;

  final String name;

  final String mobile;

  String? password;

  final String? profilePhotoUrl;

  final String? companyLogoUrl;

  final String? address;

  final double? latitude;

  final double? longitude;

  final String? userRoleTitle;

  final String? userRoleSubTitle;

  final int isCanInsertInDb;

  final int isActive;

  final int isBlocked;

  final int isApproved;

  final int isPaid;

  final int isMember;

  final int timeSlotForBatchChatAllow1To48;

  final String? userLastLoginLogsId;

  final String? fcmToken;

  final int createdAt;

  final String? createdBy;

  final int updatedAt;

  final String? updatedBy;

  AirUser({
    required this.userId,
    required this.userRole,
    required this.assignedUserIds,
    required this.name,
    required this.mobile,
    this.password,
    this.profilePhotoUrl,
    this.companyLogoUrl,
    this.address,
    this.latitude,
    this.longitude,
    this.userRoleTitle,
    this.userRoleSubTitle,
    required this.isCanInsertInDb,
    required this.isActive,
    required this.isBlocked,
    required this.isApproved,
    required this.isPaid,
    required this.isMember,
    required this.timeSlotForBatchChatAllow1To48,
    this.userLastLoginLogsId,
    this.fcmToken,
    required this.createdAt,
    this.createdBy,
    required this.updatedAt,
    this.updatedBy,
  });

  factory AirUser.fromJson(Map<String, dynamic> json) {
    return AirUser(
      userId: json['user_id'] ?? '',
      userRole: json['user_role'] ?? 5,
      assignedUserIds: (json['assigned_user_ids'] ?? [])
          .map<String>((e) => e.toString())
          .toList(),
      name: json['name'] ?? '',
      mobile: json['mobile'] ?? '',
      password: json['password'],
      profilePhotoUrl: json['profile_photo_url'],
      companyLogoUrl: json['company_logo_url'],
      address: json['address'],
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      userRoleTitle: json['user_role_title'],
      userRoleSubTitle: json['user_role_sub_title'],
      isCanInsertInDb: json['is_can_insert_in_db'] ?? 0,
      isActive: json['is_active'] ?? 1,
      isBlocked: json['is_blocked'] ?? 0,
      isApproved: json['is_approved'] ?? 0,
      isPaid: json['is_paid'] ?? 0,
      isMember: json['is_member'] ?? 0,
      timeSlotForBatchChatAllow1To48:
          json['time_slot_for_batch_chat_allow_1_to_48'] ?? 1,
      userLastLoginLogsId: json['user_last_login_logs_id'],
      fcmToken: json['fcm_token'],
      createdAt: json['created_at'] ?? 0,
      createdBy: json['created_by']?.toString(),
      updatedAt: json['updated_at'] ?? 0,
      updatedBy: json['updated_by']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'user_role': userRole,
      'assigned_user_ids': assignedUserIds,
      'name': name,
      'mobile': mobile,
      'password': password,
      'profile_photo_url': profilePhotoUrl,
      'company_logo_url': companyLogoUrl,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'user_role_title': userRoleTitle,
      'user_role_sub_title': userRoleSubTitle,
      'is_can_insert_in_db': isCanInsertInDb,
      'is_active': isActive,
      'is_blocked': isBlocked,
      'is_approved': isApproved,
      'is_paid': isPaid,
      'is_member': isMember,
      'time_slot_for_batch_chat_allow_1_to_48': timeSlotForBatchChatAllow1To48,
      'user_last_login_logs_id': userLastLoginLogsId,
      'fcm_token': fcmToken,
      'created_at': createdAt,
      'created_by': createdBy,
      'updated_at': updatedAt,
      'updated_by': updatedBy,
    };
  }

  bool get isSuperAdmin => userRole == 1;

  bool get isAdmin => userRole == 2;

  bool get isManager => userRole == 3;

  bool get isAgent => userRole == 4;

  bool get isMemberRole => userRole == 5;

  bool get isGuest => userRole == 6;

  bool get canLogin => isActive == 1 && isBlocked == 0;

  bool get canUseApp => isApproved == 1 && isActive == 1 && isBlocked == 0;
}
