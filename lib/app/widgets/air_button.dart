// ============================================================
//  AIR App – Reusable Button Components
// ============================================================
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Primary gradient button
class AirButton extends StatelessWidget {
  final String     label;
  final VoidCallback? onTap;
  final bool       loading;
  final IconData?  icon;
  final double?    width;
  final Color?     color;

  const AirButton({
    super.key, required this.label, this.onTap,
    this.loading = false, this.icon, this.width, this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme  = Theme.of(context);
    final bg     = color ?? theme.colorScheme.primary;
    return GestureDetector(
      onTap: loading ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width:    width ?? double.infinity,
        height:   52.h,
        decoration: BoxDecoration(
          color:        loading ? bg.withOpacity(0.6) : bg,
          borderRadius: BorderRadius.circular(14.r),
          boxShadow:    loading ? [] : [BoxShadow(
            color:     bg.withOpacity(0.4),
            blurRadius: 16, offset: const Offset(0, 6),
          )],
        ),
        child: Center(
          child: loading
              ? SizedBox(width: 22.r, height: 22.r,
                  child: const CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white))
              : Row(mainAxisSize: MainAxisSize.min, children: [
                  if (icon != null) ...[
                    Icon(icon, color: Colors.white, size: 20.r),
                    SizedBox(width: 8.w),
                  ],
                  Text(label, style: TextStyle(
                    color:      Colors.white,
                    fontSize:   15.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.2,
                  )),
                ]),
        ),
      ),
    );
  }
}

/// Outlined secondary button
class AirOutlinedButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final IconData? icon;
  final double?   width;

  const AirOutlinedButton({super.key, required this.label, this.onTap, this.icon, this.width});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width:  width ?? double.infinity,
        height: 52.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: theme.colorScheme.primary, width: 1.5),
        ),
        child: Center(
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            if (icon != null) ...[
              Icon(icon, color: theme.colorScheme.primary, size: 20.r),
              SizedBox(width: 8.w),
            ],
            Text(label, style: TextStyle(
              color:      theme.colorScheme.primary,
              fontSize:   15.sp,
              fontWeight: FontWeight.w700,
            )),
          ]),
        ),
      ),
    );
  }
}
