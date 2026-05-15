# Enhanced Design Companion Files

Generated **100** new files: one `<module>_enhanced_view.dart` per module under `lib/modules/`.

## What you get
Each enhanced file:
- Has a **unique theme** (palette + hero layout + icon) chosen deterministically from the module name, so every page looks distinct.
- Adds **3 new content sections**: Overview, Four Pillars, Action Steps, plus a themed Quote card.
- **Embeds the original `<Module>View()`** at the bottom — nothing is deleted, all old content still renders.

## How to use
Two options:

### Option A — Swap the route (recommended)
In `lib/routes/` find the binding for a module and change e.g.:
```dart
GetPage(name: '/family', page: () => const FamilyView())
// to:
GetPage(name: '/family', page: () => const FamilyEnhancedView())
```

### Option B — Add a "New Look" button
From any existing view, push the enhanced version:
```dart
Get.to(() => const FamilyEnhancedView());
```

## Skipped
[
  [
    "Counting Reports- Both Hindi & English",
    "no _view.dart"
  ],
  [
    "airs_aspects",
    "no _view.dart"
  ],
  [
    "airs_vision_details",
    "no _view.dart"
  ],
  [
    "general_code_conduct",
    "no _view.dart"
  ],
  [
    "motivation_connectivity",
    "no _view.dart"
  ],
  [
    "service_production",
    "no _view.dart"
  ],
  [
    "splash",
    "no _view.dart"
  ],
  [
    "your_profile_specifics",
    "no _view.dart"
  ]
]
