# web_modules — AIR All-Space Web

A complete, responsive web shell for AIR with one folder per page (GetX
binding + controller + view), a shared drawer of all 11 menu sections, and a
home page with a card for each section.

## Structure

```
web_modules/
  _shared/
    _web_layout.dart        ← shared tokens, breakpoints, primitives
    web_nav_data.dart       ← all sections + items (single source of truth)
    web_shell.dart          ← responsive drawer (side panel ≥1024px, modal <1024px)
  web_home/
    web_home_binding.dart
    web_home_controller.dart
    web_home_view.dart      ← landing: hero + stats + section cards + CTA
  web_explore/              ← EXPLORE - ALIFIYAS        (6 topics)
  web_wisdom/               ← RULE - MAZEASTA           (2 topics)
  web_be_you/               ← BE-YOU & EARN LIVING      (3 topics)
  web_air_space/            ← Use AIR's Space & Resources (4 topics)
  web_profile/              ← Your Profile Specifics    (12 topics)
  web_aspects/              ← AIR's - Aspects           (16 topics)
  web_service/              ← SERVICE & PRODUCTION      (3 topics)
  web_vision/               ← AIR'S VISION              (6 topics)
  web_motivation/           ← MOTIVATION & CONNECTIVITY (14 topics)
  web_setup/                ← SETUP A-ONE               (72 topics)
  web_system/               ← SYSTEM CORE               (4 topics)
  web_routes.dart           ← all GetX routes
```

Every section page has:

- a unique primary/secondary/accent palette
- a unique gradient hero with the section icon, tagline, blurb, and CTAs
- a topic filter (search) bound to the controller's reactive `searchQuery`
- a responsive grid of topic cards (each opens a detail sheet)
- a section-tinted call-to-action block

## Wire-up (one-time)

In your `main.dart` or `app_pages.dart`:

```dart
import 'web_modules/web_routes.dart';

GetMaterialApp(
  initialRoute: WebRoutes.home,
  getPages: [
    ...WebRoutes.pages,
    // ...your existing AppPages.pages
  ],
);
```

That's it. The drawer in `web_shell.dart` already routes every menu section
to its dedicated page.

## What else you may want to do

1. **Connect drawer items to real routes.** Right now each topic inside a
   section opens a bottom-sheet detail card. If you want a topic itself to
   navigate (e.g. to an existing AppRoutes screen), add a `route` field to
   `WebNavItem` and replace `_openDetail` with `Get.toNamed(item.route!)`.
2. **Theme integration.** Pages respect dark mode via `Theme.of(context)`.
   To force light/dark, set `Get.changeThemeMode(...)`.
3. **Search across sections.** The drawer header is a good place to add a
   global search that filters `WebNavData.sections` into a flat result list.
4. **Per-page controllers.** Each controller currently exposes `scrollController`,
   `activeItemIndex`, and `searchQuery`. Add your data-fetching, API calls,
   or persistence inside its `onInit`.
5. **Subroutes.** For workspaces that need their own children (e.g.
   `/web-setup/safety`), add nested `GetPage` entries with the same
   `binding` reused or a dedicated sub-binding.

## Responsive behaviour

- **<600px (mobile):** topbar with hamburger, modal drawer, single-column grids.
- **600–1023px (tablet):** modal drawer, 2-column grids, larger hero.
- **≥1024px (desktop):** persistent 320px side drawer, 3-column grids, full hero.

## Theme (added)

Light · System · Dark toggle lives in the drawer header.

**Wire in `main.dart`:**

```dart
import 'web_modules/_shared/web_theme_controller.dart';

void main() {
  Get.put(WebThemeController(), permanent: true);
  runApp(GetMaterialApp(
    theme: WebThemes.light,
    darkTheme: WebThemes.dark,
    themeMode: ThemeMode.system,
    initialRoute: WebRoutes.home,
    getPages: WebRoutes.pages,
  ));
}
```

The toggle calls `Get.changeThemeMode(...)`, so every page re-renders with the
right `Theme.of(context).brightness` automatically. To persist the choice
across sessions, replace the in-memory `Rx<ThemeMode>` in `WebThemeController`
with `GetStorage` or `SharedPreferences`.

## What else can still be added

1. **Topic-level routes** — give each `WebNavItem` a `route`/`onTap` so a topic opens its own screen instead of the detail sheet.
2. **Global search** — searchable command palette across all 11 sections (data already in `WebNavData.sections`).
3. **Breadcrumbs & active highlighting** — show *Home › Profile › Events* on each page.
4. **Favourites / pinned topics** — let users pin items to a "My Workspace" rail at the top of the drawer.
5. **Auth + per-user state** — gate `web_profile`, `web_system` behind login; persist via Lovable Cloud / Supabase.
6. **Internationalisation** — wrap all visible strings in `.tr` and add `translations:` to `GetMaterialApp` (Hindi + English already implied by "Counting Reports").
7. **Animations** — `AnimatedSwitcher` on route change, `Hero` on section card → page transitions.
8. **SEO for web** — `flutter_seo` or url_strategy + `<title>` updates per page.
9. **PWA install + offline** — service worker, manifest icon set, cache topic data.
10. **Analytics** — log `Get.routing.current` changes to Firebase / PostHog.
11. **Skeleton loaders** — shimmer placeholders inside each controller's `onInit` while data fetches.
12. **Accessibility pass** — semantic labels on icons, focus order, larger-text mode.
