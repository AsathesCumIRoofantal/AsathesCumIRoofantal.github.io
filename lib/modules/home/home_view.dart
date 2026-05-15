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
                    (section) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          child: Text(
                            section.title,
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.color,
                              fontSize: 12,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 6),
                          child: Text(
                            DrawerNavigationCopy.sectionBlurb(section.title),
                            style: TextStyle(
                              fontSize: 11,
                              height: 1.35,
                              color: Theme.of(
                                context,
                              ).textTheme.bodySmall?.color?.withOpacity(0.9),
                            ),
                          ),
                        ),
                        ...section.items.map(
                          (item) => ListTile(
                            titleAlignment: ListTileTitleAlignment.center,
                            leading: Icon(item.icon, color: Color(0xFFD4AF37)),
                            title: Text(
                              item.title,
                              style: TextStyle(
                                color: Color(0xFFD4AF37),
                                fontSize: 14,
                              ),
                            ),
                            subtitle: Text(
                              DrawerNavigationCopy.linkSubtitle(
                                item.route,
                                item.title,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 11,
                                height: 1.3,
                                color: Theme.of(
                                  context,
                                ).textTheme.bodySmall?.color?.withOpacity(0.88),
                              ),
                            ),
                            isThreeLine: true,
                            onTap: () {
                              // Get.back();
                              Get.toNamed(item.route);
                            },
                          ),
                        ),
                        Divider(
                          color: Theme.of(context).dividerColor,
                          height: 32,
                        ),
                      ],
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
