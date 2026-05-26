import 'package:flutter/material.dart';

/// Where this strip appears so the copy matches navigation (drawer vs home tabs).
enum AirHomeContextPlacement {
  /// Full-screen route opened from the navigation drawer.
  drawerPush,

  /// ENTITIES, UNIONS, or IDENTITY on the All-Space home [TabBarView].
  homeTab,

  /// In-app tabs under a drawer module (e.g. Wisdom, Projects & Assessments).
  nestedModuleTab,
}

/// Short orientation: how this surface relates to home tabs, Identity, and the drawer.
class AirHomeContextStrip extends StatelessWidget {
  const AirHomeContextStrip({
    super.key,
    this.compact = false,
    this.extraLine,
    this.placement = AirHomeContextPlacement.drawerPush,
  });

  final bool compact;
  final String? extraLine;
  final AirHomeContextPlacement placement;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = const Color(0xFFD4AF37);
    final body = theme.textTheme.bodySmall?.color?.withValues(alpha: 0.88);

    final textStyle = theme.textTheme.bodySmall?.copyWith(
      height: 1.35,
      color: body,
      fontSize: compact ? 11 : 12,
    );

    final String main = switch (placement) {
      AirHomeContextPlacement.drawerPush =>
        'You opened this from the drawer. Home tabs stay underneath: ENTITIES and UNIONS catalogue your map; the IDENTITY tab records how AIR reads your coordinates. Use back when you are done here.',
      AirHomeContextPlacement.homeTab =>
        'You are on an All-Space home tab. Swipe the tab bar to move between ENTITIES, UNIONS, and IDENTITY; open the menu (☰) when you need deeper AIR programmes.',
      AirHomeContextPlacement.nestedModuleTab =>
        'You are inside a module that uses its own tabs. All-Space home tabs and the drawer stay one back navigation away—finish here, then return to catalogue or remap Identity as needed.',
    };

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(
          alpha: 0.35,
        ),
        borderRadius: BorderRadius.circular(compact ? 12 : 14),
        border: Border.all(color: accent.withValues(alpha: 0.28)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 12 : 14,
          vertical: compact ? 10 : 12,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.map_outlined,
              size: compact ? 18 : 20,
              color: accent.withValues(alpha: 0.95),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(main, style: textStyle),
                  if (extraLine != null) ...[
                    const SizedBox(height: 6),
                    Text(extraLine!, style: textStyle),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
