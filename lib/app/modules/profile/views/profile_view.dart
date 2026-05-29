// ============================================================
//  AIR App – Profile View
// ============================================================
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import '../../../../core/animations/app_animations.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl  = Get.put(ProfileController());
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w700)),
        actions: [
          Obx(() => TextButton(
            onPressed: ctrl.isEditing.value ? ctrl.saveProfile : ctrl.toggleEdit,
            child: ctrl.isSaving.value
                ? SizedBox(width: 18.r, height: 18.r,
                    child: const CircularProgressIndicator(strokeWidth: 2))
                : Text(ctrl.isEditing.value ? 'Save' : 'Edit',
                    style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600)),
          )),
        ],
      ),
      body: Obx(() {
        final user = ctrl.user.value;
        if (user == null) return const Center(child: CircularProgressIndicator());

        return ListView(
          padding: EdgeInsets.all(20.r),
          children: [
            // ── Avatar ──────────────────────────────────
            Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 100.r, height: 100.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
                        begin: Alignment.topLeft, end: Alignment.bottomRight,
                      ),
                      boxShadow: [BoxShadow(
                        color: theme.colorScheme.primary.withOpacity(0.4),
                        blurRadius: 20, offset: const Offset(0, 8),
                      )],
                    ),
                    child: Center(
                      child: Text(ctrl.initials,
                          style: TextStyle(color: Colors.white, fontSize: 36.sp,
                              fontWeight: FontWeight.w800)),
                    ),
                  ),
                  Positioned(
                    bottom: 0, right: 0,
                    child: GestureDetector(
                      onTap: ctrl.changeAvatar,
                      child: Container(
                        padding: EdgeInsets.all(6.r),
                        decoration: BoxDecoration(
                          color:  theme.colorScheme.primary,
                          shape:  BoxShape.circle,
                          border: Border.all(
                              color: theme.scaffoldBackgroundColor, width: 2),
                        ),
                        child: Icon(Icons.camera_alt_rounded,
                            color: Colors.white, size: 16.r),
                      ),
                    ),
                  ),
                ],
              ),
            ).fadeSlideIn(),
            SizedBox(height: 12.h),
            Center(child: Text(user.name,
                style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w800))).fadeSlideIn(delay: 60),
            Center(child: Text(user.userRoleTitle ?? 'Member',
                style: TextStyle(fontSize: 13.sp, color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600))).fadeSlideIn(delay: 80),

            SizedBox(height: 28.h),

            // ── Info fields ─────────────────────────────
            _InfoSection('Personal Info', [
              _InfoField(label: 'Full Name',    value: user.name,   icon: Icons.person_rounded,   editing: ctrl.isEditing.value),
              _InfoField(label: 'Mobile',       value: user.mobile, icon: Icons.phone_rounded,    editing: ctrl.isEditing.value),
              _InfoField(label: 'Address',      value: user.address ?? '–', icon: Icons.location_on_rounded, editing: ctrl.isEditing.value),
            ]).fadeSlideIn(delay: 120),

            SizedBox(height: 16.h),

            _InfoSection('Account', [
              _InfoField(label: 'User ID',      value: user.userId, icon: Icons.badge_rounded,    editing: false, readOnly: true),
              _InfoField(label: 'Role',         value: user.userRoleTitle ?? 'Member', icon: Icons.shield_rounded, editing: false, readOnly: true),
              _InfoField(label: 'Status',       value: user.isActive ? 'Active' : 'Inactive', icon: Icons.circle_rounded, editing: false, readOnly: true),
            ]).fadeSlideIn(delay: 180),

            SizedBox(height: 16.h),

            // ── Badges ──────────────────────────────────
            _InfoSection('Badges & Status', [
              _BadgeTile('Verified Member',   user.isMember,  Icons.verified_rounded,        Colors.blue),
              _BadgeTile('Approved Account',  user.isApproved,Icons.check_circle_rounded,    Colors.green),
              _BadgeTile('Paid Subscriber',   user.isPaid,    Icons.star_rounded,            Colors.amber),
              _BadgeTile('DB Insert Access',  user.isCanInsertInDb, Icons.storage_rounded,   Colors.purple),
            ]).fadeSlideIn(delay: 240),

            SizedBox(height: 32.h),
          ],
        );
      }),
    );
  }
}

class _InfoSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _InfoSection(this.title, this.children);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.only(left: 4.w, bottom: 10.h),
        child: Text(title, style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700,
            color: theme.colorScheme.primary, letterSpacing: 0.5)),
      ),
      Container(
        decoration: BoxDecoration(
          color:        theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16.r),
          border:       Border.all(color: theme.dividerColor.withOpacity(0.3)),
        ),
        child: Column(children: children),
      ),
    ]);
  }
}

class _InfoField extends StatelessWidget {
  final String label, value;
  final IconData icon;
  final bool editing, readOnly;
  const _InfoField({required this.label, required this.value, required this.icon,
      required this.editing, this.readOnly = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(children: [
        Icon(icon, color: theme.colorScheme.primary, size: 20.r),
        SizedBox(width: 12.w),
        Expanded(
          child: editing && !readOnly
              ? TextFormField(
                  initialValue: value,
                  decoration: InputDecoration(
                    labelText: label, isDense: true,
                    border: const OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                  ),
                )
              : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(label, style: TextStyle(fontSize: 11.sp, color: theme.hintColor)),
                  Text(value, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
                ]),
        ),
        if (readOnly)
          Icon(Icons.lock_outline_rounded, size: 14.r, color: theme.hintColor),
      ]),
    );
  }
}

class _BadgeTile extends StatelessWidget {
  final String label;
  final bool   active;
  final IconData icon;
  final Color  color;
  const _BadgeTile(this.label, this.active, this.icon, this.color);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Icon(icon, color: active ? color : theme.hintColor, size: 22.r),
      title:   Text(label, style: TextStyle(fontSize: 13.sp,
          color: active ? null : theme.hintColor)),
      trailing: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
        decoration: BoxDecoration(
          color:        (active ? Colors.green : Colors.grey).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Text(active ? 'Active' : 'Inactive',
            style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w700,
                color: active ? Colors.green : Colors.grey)),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
      dense: true,
    );
  }
}
