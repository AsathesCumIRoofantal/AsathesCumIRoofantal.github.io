import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/rtc_config.dart';
import '../services/rtc_backend_manager.dart';
import 'zoom_theme.dart';

/// Animated pill that toggles the active RTC engine at runtime.
/// Drop it anywhere — top chrome, home top-bar, settings.
///
///   BackendToggle()                  // full pill with both labels
///   BackendToggle(compact: true)     // icon-only chip for tight toolbars
class BackendToggle extends StatelessWidget {
  const BackendToggle({super.key, this.compact = false, this.onChanged});
  final bool compact;
  final ValueChanged<RtcBackend>? onChanged;

  RtcBackendManager get _mgr => Get.isRegistered<RtcBackendManager>()
      ? Get.find<RtcBackendManager>()
      : Get.put(RtcBackendManager(), permanent: true);

  @override
  Widget build(BuildContext c) {
    final mgr = _mgr;
    return Obx(() {
      final isAgora = mgr.backend.value == RtcBackend.agora;
      if (compact) {
        return Tooltip(
          message: 'Engine: ${isAgora ? "Agora" : "WebRTC"} (tap to switch)',
          child: InkWell(
            onTap: () { mgr.toggle(); onChanged?.call(mgr.backend.value); },
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: (isAgora ? ZoomTheme.primary : ZoomTheme.accent).withOpacity(.18),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isAgora ? ZoomTheme.primary : ZoomTheme.accent),
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(isAgora ? Icons.cloud_outlined : Icons.hub_outlined,
                  size: 14, color: isAgora ? ZoomTheme.primary : ZoomTheme.accent),
                const SizedBox(width: 6),
                Text(isAgora ? 'Agora' : 'WebRTC',
                  style: TextStyle(
                    color: isAgora ? ZoomTheme.primary : ZoomTheme.accent,
                    fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: .3)),
              ]),
            ),
          ),
        );
      }
      return Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: ZoomTheme.surface2,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: ZoomTheme.stroke),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          _seg(label: 'Agora', icon: Icons.cloud_outlined,
            selected: isAgora, color: ZoomTheme.primary,
            onTap: () { if (!isAgora) { mgr.toggle(); onChanged?.call(mgr.backend.value); } }),
          _seg(label: 'WebRTC', icon: Icons.hub_outlined,
            selected: !isAgora, color: ZoomTheme.accent,
            onTap: () { if (isAgora) { mgr.toggle(); onChanged?.call(mgr.backend.value); } }),
        ]),
      );
    });
  }

  Widget _seg({
    required String label, required IconData icon,
    required bool selected, required Color color, required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap, borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? color : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          boxShadow: selected
            ? [BoxShadow(color: color.withOpacity(.45), blurRadius: 12)]
            : const [],
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, size: 14,
            color: selected ? Colors.white : ZoomTheme.textMuted),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(
            color: selected ? Colors.white : ZoomTheme.textMuted,
            fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: .3)),
        ]),
      ),
    );
  }
}
