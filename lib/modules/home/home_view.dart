import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_controller.dart';
import '../entities/entities_view.dart';
import '../unions/unions_view.dart';
import '../identity/identity_view.dart';
import '../../routes/app_pages.dart';

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
          // height: MediaQuery.of(context).size.height * 0.6,
          backgroundColor: Theme.of(context).colorScheme.surface,
          child: ListView(
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
                accountName: Text(
                  'Alifiyas-Mazeasta',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    color: Colors.white24,
                  ),
                ),
                accountEmail: const Text(
                  'AlifiyasCumIRoofantal',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // currentAccountPicture: CircleAvatar(
                //   backgroundColor: Theme.of(context).colorScheme.primary,
                //   child: const Icon(
                //     Icons.blur_on,
                //     size: 40,
                //     color: Colors.white,
                //   ),
                // ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Text(
                  'EXPLORE',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                    fontSize: 12,
                    letterSpacing: 2,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.school,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                title: Text(
                  'Learn And Fun',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                onTap: () {
                  Get.back();
                  Get.snackbar(
                    'Learn And Fun',
                    'Interactive modules coming soon for the offsprings!',
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    colorText: Theme.of(context).textTheme.bodyLarge?.color,
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.question_answer,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                title: Text(
                  'Ask Any Thing',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                onTap: () {
                  Get.back();
                  Get.snackbar(
                    'Ask Any Thing',
                    'The wisdom engine is initializing...',
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    colorText: Theme.of(context).textTheme.bodyLarge?.color,
                  );
                },
              ),
              Divider(color: Theme.of(context).dividerColor, height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Text(
                  'SYSTEM CORE',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                    fontSize: 12,
                    letterSpacing: 2,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: Text(
                  'App Setting',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                onTap: () {
                  Get.back(); // close drawer gracefully
                  Get.toNamed(AppRoutes.SETTINGS); // open settings
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.info_outline,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
                title: Text(
                  'About AIR-APP',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
                onTap: () {
                  Get.back();
                  Get.snackbar(
                    'AIR App',
                    'Mapping all-apps. Ensuring absolute transparency.',
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.info,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
                title: Text(
                  'About AIR Organization',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
                onTap: () {
                  Get.back();
                  Get.snackbar(
                    'AIR Organization',
                    'Mapping all-space. Ensuring absolute transparency.',
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
              ),
            ],
          ),
        ),
        body: TabBarView(children: pages),
      ),
    );
  }
}
