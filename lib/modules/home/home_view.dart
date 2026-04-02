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
                  'EXPLORE - ALIFIYAS',
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
                  Get.toNamed(AppRoutes.LEARN_FUN);
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
                  Get.toNamed(AppRoutes.QUERIES);
                },
              ),
              Divider(color: Theme.of(context).dividerColor, height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Text(
                  'RULE - MAZEASTA',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                    fontSize: 12,
                    letterSpacing: 2,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.book,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                title: Text(
                  'Wisdom',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                onTap: () {
                  Get.back();
                  Get.toNamed(AppRoutes.WISDOM);
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
                  Get.toNamed(AppRoutes.QUERIES);
                },
              ),
              Divider(color: Theme.of(context).dividerColor, height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Text(
                  'Be-You & Earn Living',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 2,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.family_restroom,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                title: Text(
                  'Share Experience',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                onTap: () {
                  Get.back();
                  Get.toNamed(AppRoutes.SHARE_EXPERIENCE);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.post_add,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                title: Text(
                  'Record Your Post',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                onTap: () {
                  Get.back();
                  Get.toNamed(AppRoutes.RECORD_POST);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.format_list_numbered,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                title: Text(
                  'Identities Cum Earnings',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                onTap: () {
                  Get.back();
                  Get.toNamed(AppRoutes.IDENTITIES_EARNINGS);
                },
              ),
              // ListTile(
              //   leading: Icon(
              //     Icons.question_answer,
              //     color: Theme.of(context).colorScheme.secondary,
              //   ),
              //   title: Text(
              //     'Ask Any Thing',
              //     style: TextStyle(
              //       color: Theme.of(context).textTheme.bodyLarge?.color,
              //     ),
              //   ),
              //   onTap: () {
              //     Get.back();
              //     Get.toNamed(AppRoutes.QUERIES);
              //   },
              // ),
              Divider(color: Theme.of(context).dividerColor, height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Text(
                  "Use AIR's Space & Resources",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 2,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.unarchive,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                title: Text(
                  'Knowledge Center',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                onTap: () {
                  Get.back();
                  Get.toNamed(AppRoutes.KNOWLEDGE_CENTER);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.output,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                title: Text(
                  'Products & Services',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                onTap: () {
                  Get.back();
                  Get.toNamed(AppRoutes.PRODUCTS_SERVICES);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.question_answer,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                title: Text(
                  'Query & Discussion',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                onTap: () {
                  Get.back();
                  Get.toNamed(AppRoutes.QUERY_DISCUSSION);
                },
              ),

              Divider(color: Theme.of(context).dividerColor, height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Text(
                  'Your Profile Specifics',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 2,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.event,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                title: Text(
                  'Events',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                onTap: () {
                  Get.back();
                  // Get.toNamed(AppRoutes.LEARN_FUN);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.manage_accounts,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                title: Text(
                  'Managements',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                onTap: () {
                  Get.back();
                  // Get.toNamed(AppRoutes.LEARN_FUN);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                title: Text(
                  'Maintenance',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                onTap: () {
                  Get.back();
                  // Get.toNamed(AppRoutes.LEARN_FUN);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.email,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                title: Text(
                  'Connect & Collaborate',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                onTap: () {
                  Get.back();
                  // Get.toNamed(AppRoutes.LEARN_FUN);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.notifications,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                title: Text(
                  'Notices',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                onTap: () {
                  Get.back();
                  // Get.toNamed(AppRoutes.LEARN_FUN);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.track_changes,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                title: Text(
                  'Tracks & Traces',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                onTap: () {
                  Get.back();
                  // Get.toNamed(AppRoutes.LEARN_FUN);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.business_sharp,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                title: Text(
                  'Your Business',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                onTap: () {
                  Get.back();
                  // Get.toNamed(AppRoutes.LEARN_FUN);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.diamond,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                title: Text(
                  'Rewards/Credits',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                onTap: () {
                  Get.back();
                  // Get.toNamed(AppRoutes.LEARN_FUN);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.approval,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                title: Text(
                  'Approval of Appeals',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                onTap: () {
                  Get.back();
                  // Get.toNamed(AppRoutes.LEARN_FUN);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.api,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                title: Text(
                  'Network(APIs) Stuff',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                onTap: () {
                  Get.back();
                  // Get.toNamed(AppRoutes.LEARN_FUN);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.public_off,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                title: Text(
                  'Private/Confidential Stuff',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                onTap: () {
                  Get.back();
                  // Get.toNamed(AppRoutes.LEARN_FUN);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.public,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                title: Text(
                  'Public Stuff',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                onTap: () {
                  Get.back();
                  // Get.toNamed(AppRoutes.LEARN_FUN);
                },
              ),

              // ListTile(
              //   leading: Icon(
              //     Icons.question_answer,
              //     color: Theme.of(context).colorScheme.secondary,
              //   ),
              //   title: Text(
              //     'Ask Any Thing',
              //     style: TextStyle(
              //       color: Theme.of(context).textTheme.bodyLarge?.color,
              //     ),
              //   ),
              //   onTap: () {
              //     Get.back();
              //     Get.toNamed(AppRoutes.QUERIES);
              //   },
              // ),
              Divider(color: Theme.of(context).dividerColor, height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Text(
                  "AIR's - Aspects",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 2,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.travel_explore,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                title: Text(
                  "Let's resume your tour",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                onTap: () {
                  Get.back();
                  // Get.toNamed(AppRoutes.LEARN_FUN);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.grade,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                title: Text(
                  "Be the part of AIR",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                onTap: () {
                  Get.back();
                  // Get.toNamed(AppRoutes.LEARN_FUN);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.add_box,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                title: Text(
                  "Contribute to AIR",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                onTap: () {
                  Get.back();
                  // Get.toNamed(AppRoutes.LEARN_FUN);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.timeline,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                title: Text(
                  "Timeline of AIR",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                onTap: () {
                  Get.back();
                  // Get.toNamed(AppRoutes.LEARN_FUN);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.new_releases,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                title: Text(
                  "New in AIR",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                onTap: () {
                  Get.back();
                  // Get.toNamed(AppRoutes.LEARN_FUN);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.check_circle_outline_rounded,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                title: Text(
                  'Checked Space Anomalies',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                onTap: () {
                  Get.back();
                  // Get.toNamed(AppRoutes.LEARN_FUN);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.question_mark_outlined,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                title: Text(
                  'Un-Checked Space Anomalies',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                onTap: () {
                  Get.back();
                  // Get.toNamed(AppRoutes.LEARN_FUN);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.calculate_outlined,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                title: Text(
                  'Limits (0 or 1)',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                onTap: () {
                  Get.back();
                  // Get.toNamed(AppRoutes.LEARN_FUN);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.transform_rounded,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                title: Text(
                  'Communication',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                onTap: () {
                  Get.back();
                  // Get.toNamed(AppRoutes.LEARN_FUN);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.featured_play_list_outlined,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                title: Text(
                  'Imagination & Features',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                onTap: () {
                  Get.back();
                  // Get.toNamed(AppRoutes.LEARN_FUN);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.flag_outlined,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                title: Text(
                  'Beliefs & Values',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                onTap: () {
                  Get.back();
                  // Get.toNamed(AppRoutes.LEARN_FUN);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.play_circle_outline_rounded,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                title: Text(
                  'Entertainment',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                onTap: () {
                  Get.back();
                  // Get.toNamed(AppRoutes.LEARN_FUN);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.star_border_rounded,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                title: Text(
                  'Skills & Talents',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                onTap: () {
                  Get.back();
                  // Get.toNamed(AppRoutes.LEARN_FUN);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.data_object_rounded,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                title: Text(
                  "Being Recorded & Rewarded",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                onTap: () {
                  Get.back();
                  Get.toNamed(AppRoutes.AIR_VISION);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.lens_blur_rounded,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                title: Text(
                  "Training",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                onTap: () {
                  Get.back();
                  Get.toNamed(AppRoutes.AIR_VISION);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.build_circle_outlined,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                title: Text(
                  "Service & Production",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                onTap: () {
                  Get.back();
                  Get.toNamed(AppRoutes.AIR_VISION);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.computer_sharp,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                title: Text(
                  "Outcome of Processed",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                onTap: () {
                  Get.back();
                  Get.toNamed(AppRoutes.AIR_VISION);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.visibility_outlined,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                title: Text(
                  "AIR's Vision",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                onTap: () {
                  Get.back();
                  Get.toNamed(AppRoutes.AIR_VISION);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.music_note_sharp,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                title: Text(
                  "AIR's Mission",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                onTap: () {
                  Get.back();
                  // Get.toNamed(AppRoutes.LEARN_FUN);
                },
              ),

              ListTile(
                leading: Icon(
                  Icons.show_chart,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                title: Text(
                  "AIR's Show Case",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                onTap: () {
                  Get.back();
                  // Get.toNamed(AppRoutes.LEARN_FUN);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.wrap_text,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                title: Text(
                  "Let's Windup",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                onTap: () {
                  Get.back();
                  // Get.toNamed(AppRoutes.LEARN_FUN);
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
              Divider(color: Theme.of(context).dividerColor, height: 32),
              ListTile(
                leading: Icon(
                  Icons.login,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                title: Text(
                  'Sign In / Sign Up',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                onTap: () {
                  Get.back();
                  // Get.toNamed(AppRoutes.LEARN_FUN);
                },
              ),
              Divider(color: Theme.of(context).dividerColor, height: 32),
            ],
          ),
        ),
        body: TabBarView(children: pages),
      ),
    );
  }
}
