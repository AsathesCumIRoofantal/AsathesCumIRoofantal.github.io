// ============================================================
//  AIR App – Loading, Empty & Error state widgets
// ============================================================
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

// ── Shimmer list skeleton ─────────────────────────────────
class AirListSkeleton extends StatelessWidget {
  final int count;
  const AirListSkeleton({super.key, this.count = 6});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView.separated(
      padding:   EdgeInsets.all(16.r),
      itemCount: count,
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
      itemBuilder: (_, __) => Shimmer.fromColors(
        baseColor:      theme.brightness == Brightness.dark
            ? Colors.grey.shade800 : Colors.grey.shade300,
        highlightColor: theme.brightness == Brightness.dark
            ? Colors.grey.shade700 : Colors.grey.shade100,
        child: Container(
          height: 72.h,
          decoration: BoxDecoration(
            color:        Colors.grey,
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
      ),
    );
  }
}

// ── Empty state ───────────────────────────────────────────
class AirEmptyState extends StatelessWidget {
  final IconData icon;
  final String   title;
  final String?  subtitle;
  final String?  actionLabel;
  final VoidCallback? onAction;

  const AirEmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 72.r, color: theme.hintColor.withOpacity(0.5)),
            SizedBox(height: 16.h),
            Text(title, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center),
            if (subtitle != null) ...[
              SizedBox(height: 8.h),
              Text(subtitle!, style: TextStyle(fontSize: 14.sp, color: theme.hintColor),
                  textAlign: TextAlign.center),
            ],
            if (actionLabel != null && onAction != null) ...[
              SizedBox(height: 24.h),
              FilledButton(onPressed: onAction, child: Text(actionLabel!)),
            ],
          ],
        ),
      ),
    );
  }
}

// ── Error state ───────────────────────────────────────────
class AirErrorState extends StatelessWidget {
  final String   message;
  final VoidCallback? onRetry;
  const AirErrorState({super.key, required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: EdgeInsets.all(32.r),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline_rounded, size: 60.r, color: Colors.red.shade300),
          SizedBox(height: 16.h),
          Text('Something went wrong', style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w700)),
          SizedBox(height: 8.h),
          Text(message, style: TextStyle(fontSize: 13.sp,
              color: Theme.of(context).hintColor), textAlign: TextAlign.center),
          if (onRetry != null) ...[
            SizedBox(height: 24.h),
            OutlinedButton.icon(
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Retry'),
              onPressed: onRetry,
            ),
          ],
        ],
      ),
    ),
  );
}

// ── Offline banner ────────────────────────────────────────
class AirOfflineBanner extends StatelessWidget {
  const AirOfflineBanner({super.key});

  @override
  Widget build(BuildContext context) => Container(
    width:   double.infinity,
    padding: EdgeInsets.symmetric(vertical: 6.h),
    color:   Colors.red.shade700,
    child:   Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(Icons.wifi_off_rounded, color: Colors.white, size: 16.r),
      SizedBox(width: 8.w),
      Text('You are offline', style: TextStyle(color: Colors.white, fontSize: 13.sp)),
    ]),
  );
}
