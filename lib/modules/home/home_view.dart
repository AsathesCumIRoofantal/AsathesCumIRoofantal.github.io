import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_controller.dart';
import '../entities/entities_view.dart';
import '../unions/unions_view.dart';
import '../identity/identity_view.dart';
import '../../routes/app_pages.dart';
import 'drawer_navigation_copy.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  final List<Widget> pages = [EntitiesView(), UnionsView(), IdentityView()];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('All-Space', style: TextStyle(letterSpacing: 3)),
          bottom: TabBar(
            indicatorColor: Theme.of(context).colorScheme.primary,
            labelColor: Theme.of(context).colorScheme.primary,
            unselectedLabelColor: Theme.of(
              context,
            ).dividerColor.withOpacity(0.5),
            tabs: const [
              Tab(icon: Icon(Icons.category), text: 'ENTITIES'),
              Tab(icon: Icon(Icons.account_tree), text: 'UNIONS'),
              Tab(icon: Icon(Icons.fingerprint), text: 'IDENTITY'),
            ],
          ),
        ),
        drawer: Drawer(
          width: 330,
          backgroundColor: Theme.of(context).colorScheme.surface,
          child: ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            children: [
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
                accountName: const Text(
                  'Alifiyas-Mazeasta',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    color: Colors.white24,
                  ),
                ),
                accountEmail: const Text(
                  'AsathesCumIRoofantal',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHighest.withOpacity(0.35),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFFD4AF37).withOpacity(0.35),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.map_outlined,
                          size: 22,
                          color: const Color(0xFFD4AF37).withOpacity(0.9),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            DrawerNavigationCopy.drawerPreamble,
                            style: TextStyle(
                              fontSize: 12,
                              height: 1.35,
                              color: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.color?.withOpacity(0.85),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ...controller.drawerSections
                  .map(
                    (section) => Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 0,
                        vertical: 0,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
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
                        // border: Border.all(
                        //   color: const Color(0xFFD4AF37).withOpacity(0.35),
                        //   width: 0,
                        // ),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: const Color(0xFFD4AF37).withOpacity(0.08),
                        //     blurRadius: 18,
                        //     spreadRadius: 1,
                        //     offset: const Offset(0, 6),
                        //   ),
                        // ],
                      ),
                      child: Column(
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
                              DrawerNavigationCopy.sectionBlurb(section.title),
                              style: TextStyle(
                                fontSize: 11.2,
                                height: 1.45,
                                color: onSurface,
                              ),
                            ),
                          ),

                          /// MENU ITEMS
                          ...section.items.map(
                            (item) => Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 3,
                                vertical: 5,
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(18),
                                  onTap: () {
                                    Get.toNamed(item.route);
                                  },
                                  child: Ink(
                                    padding: const EdgeInsets.all(14),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(0),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surfaceContainerHighest
                                          .withOpacity(0.22),
                                      // border: Border.all(
                                      //   color: const Color(
                                      //     0xFFD4AF37,
                                      //   ).withOpacity(0.18),
                                      // ),
                                      // boxShadow: [
                                      //   BoxShadow(
                                      //     color: Colors.black.withOpacity(0.22),
                                      //     blurRadius: 10,
                                      //     offset: const Offset(0, 4),
                                      //   ),
                                      // ],
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        /// ICON
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            gradient: LinearGradient(
                                              colors: [
                                                const Color(0xFFFFE082),
                                                const Color(0xFFD4AF37),
                                              ],
                                            ),
                                          ),
                                          child: Icon(
                                            item.icon,
                                            color: Colors.black,
                                            size: 20,
                                          ),
                                        ),

                                        const SizedBox(width: 14),

                                        /// TEXTS
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                  item.route,
                                                  item.title,
                                                ),
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  height: 1.4,
                                                  color: onSurface.withOpacity(
                                                    0.75,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        /// ARROW
                                        Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 15,
                                          color: const Color(
                                            0xFFD4AF37,
                                          ).withOpacity(0.7),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ],
          ),
        ),
        body: TabBarView(children: pages),
      ),
    );
  }
}
