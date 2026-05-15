import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../entities/entities_view.dart';
import '../identity/identity_view.dart';
import '../unions/unions_view.dart';
import 'drawer_navigation_copy.dart';
import 'home_controller.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  HomeController controller = Get.find<HomeController>();

  final List<Widget> pages = [EntitiesView(), UnionsView(), IdentityView()];

  /// =========================================================
  /// FILTERED RESULTS
  /// =========================================================

  void getFilteredResults() {
    final query = controller.drawerSearchText.value.trim().toLowerCase();
    controller.results.value = [];
    if (query.isNotEmpty) {}

    for (final section in controller.drawerSections) {
      List<DrawerResultItem> existingItemsPerSection = [];
      for (final item in section.items) {
        if (item.title.toLowerCase().contains(query)) {
          existingItemsPerSection = [
            ...existingItemsPerSection,
            DrawerResultItem(
              title: item.title,
              icon: item.icon,
              route: item.route,
              key: GlobalKey(debugLabel: "${item.route}"),
            ),
          ];
        }
      }
      if (existingItemsPerSection.isNotEmpty) {
        controller.results.value = [
          ...controller.results.value,
          DrawerResultSection(
            title: section.title,
            items: existingItemsPerSection,
          ),
        ];
      }
    }

    // return results;
  }

  Future<void> scrollToItem({
    required String sectionTitle,
    required String routeTemp,
    required GlobalKey key,
  }) async {
    /// CLOSE SEARCH OVERLAY
    controller.isDrawerSearchVisible.value = false;
    routeTemp = "${routeTemp}";

    /// WAIT FOR UI REBUILD
    await Future.delayed(const Duration(milliseconds: 800));
    GlobalKey? keyActual = ((controller.drawerSections.firstWhere(
      (s) => s.title == sectionTitle,
    )).items.firstWhere((i) => i.route == routeTemp)).key;

    /// BUILD UNIQUE KEY

    BuildContext? ctx = keyActual?.currentContext;
    if (ctx == null) {
      debugPrint("Context NULL -> $routeTemp");
      return;
    }

    /// GET SAFE GLOBAL KEY
    final GlobalKey? globalKey = keyActual;

    if (globalKey == null) {
      debugPrint("GlobalKey NOT FOUND -> $routeTemp");
      return;
    }

    /// WAIT NEXT FRAME
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      /// SAFE CONTEXT
      final BuildContext? itemContext = globalKey.currentContext;

      if (itemContext == null) {
        debugPrint("Context NULL -> $routeTemp");
        return;
      }

      /// SCROLL
      await Scrollable.ensureVisible(
        itemContext,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInOutCubic,
        alignment: 0.45,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isDark = theme.brightness == Brightness.dark;

    final onSurface = theme.colorScheme.onSurface;

    return Obx(
      () => DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('All-Space', style: TextStyle(letterSpacing: 3)),

            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.category), text: 'ENTITIES'),
                Tab(icon: Icon(Icons.account_tree), text: 'UNIONS'),
                Tab(icon: Icon(Icons.fingerprint), text: 'IDENTITY'),
              ],
            ),
          ),

          /// =========================================================
          /// DRAWER
          /// =========================================================
          drawer: Drawer(
            width: 330,

            backgroundColor: theme.colorScheme.surface,

            child: Stack(
              children: [
                /// =========================================================
                /// MAIN LIST
                /// =========================================================
                ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  controller: controller.drawerScrollController,

                  padding: EdgeInsets.zero,

                  children: [
                    /// HEADER
                    UserAccountsDrawerHeader(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/AIR_Picture.png'),

                          fit: BoxFit.fill,

                          colorFilter: ColorFilter.mode(
                            Colors.black54,
                            BlendMode.darken,
                          ),
                        ),
                      ),

                      accountName: const Text('Alifiyas-Mazeasta'),

                      accountEmail: const Text('AsathesCumIRoofantal'),
                    ),

                    /// =========================================================
                    /// ORIGINAL DRAWER DESIGN
                    /// =========================================================
                    ...controller.drawerSections.map((section) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 0),

                        padding: const EdgeInsets.symmetric(vertical: 4),

                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,

                            end: Alignment.bottomRight,

                            colors: isDark
                                ? [
                                    theme.scaffoldBackgroundColor,

                                    theme.colorScheme.surface,
                                  ]
                                : [
                                    theme.colorScheme.surface,

                                    theme.scaffoldBackgroundColor,
                                  ],
                          ),
                        ),

                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            /// SECTION TITLE
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 4, 8, 6),

                              child: Row(
                                children: [
                                  Container(
                                    width: 5,
                                    height: 32,

                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),

                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFFFFE8A3),

                                          Color(0xFFD4AF37),

                                          Color(0xFF8C6A16),
                                        ],
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 12),

                                  Expanded(
                                    child: Text(
                                      section.title.toUpperCase(),

                                      style: const TextStyle(
                                        color: Color(0xFFFFD369),

                                        fontSize: 13,

                                        fontWeight: FontWeight.w700,

                                        letterSpacing: 2.2,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            /// SECTION DESCRIPTION
                            Padding(
                              padding: const EdgeInsets.fromLTRB(18, 0, 18, 14),

                              child: Text(
                                DrawerNavigationCopy.sectionBlurb(
                                  section.title,
                                ),

                                style: TextStyle(
                                  fontSize: 11.2,

                                  height: 1.45,

                                  color: onSurface,
                                ),
                              ),
                            ),

                            /// ITEMS
                            ...section.items.map((item) {
                              // controller.itemKeys.putIfAbsent(
                              //   item.route,
                              //   () => GlobalKey(
                              //     debugLabel: "${section.title}_${item.route}",
                              //   ),
                              // );

                              return Container(
                                child: buildDrawerActualItem(
                                  context: context,

                                  item: item,

                                  onSurface: onSurface,
                                ),
                              );
                            }),

                            const SizedBox(height: 10),
                          ],
                        ),
                      );
                    }),

                    const SizedBox(height: 120),
                  ],
                ),

                /// =========================================================
                /// FLOATING SEARCH BUTTON
                /// =========================================================
                Positioned(
                  bottom: 20,
                  right: 18,

                  child: Material(
                    color: Colors.transparent,

                    elevation: 12,

                    borderRadius: BorderRadius.circular(100),

                    child: InkWell(
                      borderRadius: BorderRadius.circular(100),

                      onTap: () {
                        controller.isDrawerSearchVisible.value = true;
                      },

                      child: Ink(
                        width: 62,
                        height: 62,

                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,

                          gradient: LinearGradient(
                            colors: [Color(0xFF00C6FF), Color(0xFF0072FF)],
                          ),
                        ),

                        child: const Icon(
                          Icons.search_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                ),

                /// =========================================================
                /// SEARCH OVERLAY
                /// =========================================================
                controller.isDrawerSearchVisible.value
                    ? Positioned.fill(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,

                          onTap: () {
                            controller.drawerSearchController.clear();

                            controller.drawerSearchText.value = '';

                            controller.isDrawerSearchVisible.value = false;
                          },

                          child: Container(
                            color: Colors.black.withOpacity(0.72),

                            child: SafeArea(
                              child: Column(
                                children: [
                                  /// SEARCH BAR
                                  GestureDetector(
                                    onTap: () {},

                                    child: Padding(
                                      padding: const EdgeInsets.all(14),

                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                        ),

                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            22,
                                          ),

                                          gradient: const LinearGradient(
                                            colors: [
                                              Color(0xFF182848),

                                              Color(0xFF4B6CB7),
                                            ],
                                          ),
                                        ),

                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.search,
                                              color: Colors.white,
                                            ),

                                            const SizedBox(width: 10),

                                            Expanded(
                                              child: TextField(
                                                autofocus: true,

                                                controller: controller
                                                    .drawerSearchController,

                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),

                                                onChanged: (value) {
                                                  controller
                                                          .drawerSearchText
                                                          .value =
                                                      value;
                                                },

                                                decoration:
                                                    const InputDecoration(
                                                      border: InputBorder.none,

                                                      hintText:
                                                          'Search anything...',

                                                      hintStyle: TextStyle(
                                                        color: Colors.white70,
                                                      ),
                                                    ),
                                              ),
                                            ),

                                            GestureDetector(
                                              onTap: () {
                                                controller
                                                    .drawerSearchController
                                                    .clear();

                                                controller
                                                        .drawerSearchText
                                                        .value =
                                                    '';

                                                controller
                                                        .isDrawerSearchVisible
                                                        .value =
                                                    false;
                                              },

                                              child: Container(
                                                padding: const EdgeInsets.all(
                                                  7,
                                                ),

                                                decoration: BoxDecoration(
                                                  color: Colors.white
                                                      .withOpacity(0.12),

                                                  shape: BoxShape.circle,
                                                ),

                                                child: const Icon(
                                                  Icons.close_rounded,
                                                  color: Colors.white,
                                                  size: 18,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  /// RESULTS
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {},

                                      child: getFilterResultsUIComponent(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),

          body: TabBarView(children: pages),
        ),
      ),
    );
  }

  Widget getFilterResultsUIComponent() {
    getFilteredResults();

    if (controller.results.value.isEmpty) {
      return const Center(
        child: Text(
          "No Results Found",

          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      );
    }

    // final grouped = <String, List<DrawerSearchResult>>{};

    // for (var r in controller.results.value) {
    //   grouped.putIfAbsent(r.section, () => []);

    //   grouped[r.section]!.add(r);
    // }

    return ListView(
      padding: const EdgeInsets.fromLTRB(14, 0, 14, 120),

      children: controller.results.value.map((listItem) {
        return Container(
          margin: const EdgeInsets.only(bottom: 18),

          padding: const EdgeInsets.all(16),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),

            gradient: const LinearGradient(
              colors: [Color(0xFF16222A), Color(0xFF3A6073)],
            ),
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                listItem.title,

                style: const TextStyle(
                  color: Colors.white,

                  fontSize: 15,

                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 14),

              ...listItem.items.map((e) {
                return Padding(
                  key: e.key!,
                  padding: const EdgeInsets.only(bottom: 10),

                  child: InkWell(
                    borderRadius: BorderRadius.circular(18),

                    onTap: () {
                      scrollToItem(
                        sectionTitle: listItem.title,
                        routeTemp: e.route,
                        key: e.key!,
                      );
                      controller.isDrawerSearchVisible.refresh();
                    },

                    child: Ink(
                      padding: const EdgeInsets.all(14),

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),

                        color: Colors.white.withOpacity(0.08),
                      ),

                      child: Row(
                        children: [
                          Icon(e.icon, color: Colors.white),

                          const SizedBox(width: 14),

                          Expanded(
                            child: Text(
                              e.title,

                              style: const TextStyle(color: Colors.white),
                            ),
                          ),

                          const Icon(
                            Icons.arrow_forward_ios_rounded,

                            color: Colors.white70,

                            size: 14,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        );
      }).toList(),
    );
  }

  /// =========================================================
  /// DRAWER ITEM
  /// =========================================================

  Widget buildDrawerActualItem({
    required BuildContext context,
    required DrawerActualItem item,
    required Color onSurface,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),

      child: Material(
        color: Colors.transparent,

        child: InkWell(
          borderRadius: BorderRadius.circular(18),

          onTap: () {
            if (item.route != null) {
              Get.toNamed(item.route!);
            }
          },

          child: Ink(
            padding: const EdgeInsets.all(14),

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0),

              color: Theme.of(
                context,
              ).colorScheme.surfaceContainerHighest.withOpacity(0.22),
            ),

            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Container(
                  key: item.key,
                  padding: const EdgeInsets.all(10),

                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,

                    gradient: LinearGradient(
                      colors: [Color(0xFFFFE082), Color(0xFFD4AF37)],
                    ),
                  ),

                  child: Icon(item.icon, color: Colors.black, size: 20),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        item.title,

                        style: const TextStyle(
                          color: Color(0xFFFFD369),

                          fontSize: 14.5,

                          fontWeight: FontWeight.w700,

                          letterSpacing: 0.4,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        DrawerNavigationCopy.linkSubtitle(
                          item.route ?? item.title,
                          item.title,
                        ),

                        maxLines: 3,

                        overflow: TextOverflow.ellipsis,

                        style: TextStyle(
                          fontSize: 11,

                          height: 1.4,

                          color: onSurface.withOpacity(0.75),
                        ),
                      ),
                    ],
                  ),
                ),

                Icon(
                  Icons.arrow_forward_ios_rounded,

                  size: 15,

                  color: const Color(0xFFD4AF37).withOpacity(0.7),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
