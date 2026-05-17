// import 'package:air_app/modules/home/home_controller.dart';
// import 'package:air_app/web_modules/_web_layout.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class WebShell extends StatelessWidget {
//   final Widget child;
//   const WebShell({super.key, required this.child});

//   @override
//   Widget build(BuildContext context) {
//     final isDesktop = WBreak.isDesktop(context);
//     final theme = Theme.of(context);
//     final homeController = Get.isRegistered<HomeController>()
//         ? Get.find<HomeController>()
//         : Get.put(HomeController());

//     final currentRoute = Get.currentRoute.isNotEmpty
//         ? Get.currentRoute
//         : ModalRoute.of(context)?.settings.name ?? '';

//     if (isDesktop) {
//       return Scaffold(
//         backgroundColor: theme.scaffoldBackgroundColor,
//         body: Row(
//           children: [
//             Container(
//               width: 320,
//               decoration: BoxDecoration(
//                 color: theme.colorScheme.surface,
//                 border: Border(
//                   right: BorderSide(
//                     color: theme.dividerColor.withValues(alpha:0.25),
//                     width: 1,
//                   ),
//                 ),
//               ),
//               child: _WebDrawer(
//                 controller: homeController,
//                 currentRoute: currentRoute,
//                 isDesktop: true,
//               ),
//             ),
//             Expanded(
//               child: Container(
//                 color: theme.scaffoldBackgroundColor,
//                 child: child,
//               ),
//             ),
//           ],
//         ),
//       );
//     }

//     return Scaffold(
//       drawer: Drawer(
//         child: _WebDrawer(
//           controller: homeController,
//           currentRoute: currentRoute,
//           isDesktop: false,
//         ),
//       ),
//       body: Stack(
//         children: [
//           child,
//           if (!isDesktop)
//             Positioned(
//               top: 16,
//               left: 16,
//               child: SafeArea(
//                 child: Builder(
//                   builder: (drawerButtonContext) => Material(
//                     color: Colors.transparent,
//                     child: InkWell(
//                       borderRadius: BorderRadius.circular(14),
//                       onTap: () =>
//                           Scaffold.of(drawerButtonContext).openDrawer(),
//                       child: Container(
//                         padding: const EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                           color: theme.colorScheme.surface.withValues(alpha:0.9),
//                           borderRadius: BorderRadius.circular(14),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withValues(alpha:0.12),
//                               blurRadius: 18,
//                               offset: const Offset(0, 8),
//                             ),
//                           ],
//                         ),
//                         child: const Icon(Icons.menu_rounded),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

// class _WebDrawer extends StatelessWidget {
//   final HomeController controller;
//   final String currentRoute;
//   final bool isDesktop;
//   const _WebDrawer({
//     super.key,
//     required this.controller,
//     required this.currentRoute,
//     required this.isDesktop,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;

//     return SafeArea(
//       child: Column(
//         children: [
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   theme.colorScheme.primary.withValues(alpha:0.95),
//                   theme.colorScheme.secondary.withValues(alpha:0.85),
//                 ],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'AIR DASHBOARD',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.w900,
//                     letterSpacing: 1.2,
//                   ),
//                 ),
//                 const SizedBox(height: 6),
//                 Text(
//                   'Enterprise web shell for all modules',
//                   style: TextStyle(
//                     color: Colors.white.withValues(alpha:0.9),
//                     fontSize: 12,
//                     height: 1.4,
//                   ),
//                 ),
//                 const SizedBox(height: 18),
//                 Row(
//                   children: [
//                     const CircleAvatar(
//                       radius: 24,
//                       backgroundColor: Colors.white,
//                       child: Icon(Icons.air, color: Color(0xFF4F46E5)),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: const [
//                           Text(
//                             'Alifiyas-Mazeasta',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                           SizedBox(height: 4),
//                           Text(
//                             'All-Space Operator',
//                             style: TextStyle(
//                               color: Colors.white70,
//                               fontSize: 12,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.only(top: 12, bottom: 24),
//               child: Column(
//                 children: controller.drawerSections.map((section) {
//                   return _WebDrawerSection(
//                     section: section,
//                     currentRoute: currentRoute,
//                     isDark: isDark,
//                   );
//                 }).toList(),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _WebDrawerSection extends StatelessWidget {
//   final DrawerActualSection section;
//   final String currentRoute;
//   final bool isDark;
//   const _WebDrawerSection({
//     super.key,
//     required this.section,
//     required this.currentRoute,
//     required this.isDark,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             section.title,
//             style: TextStyle(
//               color: isDark ? Colors.white70 : Colors.black87,
//               fontSize: 12,
//               fontWeight: FontWeight.w700,
//               letterSpacing: 1.2,
//             ),
//           ),
//           const SizedBox(height: 8),
//           ...section.items.map((item) {
//             final active = item.route == currentRoute;
//             return Padding(
//               padding: const EdgeInsets.symmetric(vertical: 4),
//               child: InkWell(
//                 borderRadius: BorderRadius.circular(14),
//                 onTap: () {
//                   if (item.route != currentRoute) {
//                     if (!isDesktop) Navigator.of(context).pop();
//                     Get.toNamed(item.route);
//                   }
//                 },
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 12,
//                     vertical: 12,
//                   ),
//                   decoration: BoxDecoration(
//                     color: active
//                         ? Theme.of(
//                             context,
//                           ).colorScheme.primary.withValues(alpha:0.12)
//                         : Theme.of(context).colorScheme.surface,
//                     borderRadius: BorderRadius.circular(14),
//                     border: Border.all(
//                       color: active
//                           ? Theme.of(
//                               context,
//                             ).colorScheme.primary.withValues(alpha:0.28)
//                           : Colors.transparent,
//                     ),
//                   ),
//                   child: Row(
//                     children: [
//                       Container(
//                         width: 36,
//                         height: 36,
//                         decoration: BoxDecoration(
//                           color: active
//                               ? Theme.of(
//                                   context,
//                                 ).colorScheme.primary.withValues(alpha:0.18)
//                               : Theme.of(
//                                   context,
//                                 ).dividerColor.withValues(alpha:0.08),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Icon(
//                           item.icon,
//                           size: 18,
//                           color: active
//                               ? Theme.of(context).colorScheme.primary
//                               : Theme.of(context).iconTheme.color ??
//                                     Colors.white,
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: Text(
//                           item.title,
//                           style: TextStyle(
//                             color: active
//                                 ? Theme.of(context).colorScheme.primary
//                                 : Theme.of(context).textTheme.bodyLarge?.color,
//                             fontWeight: FontWeight.w600,
//                             fontSize: 13,
//                           ),
//                         ),
//                       ),
//                       if (active)
//                         Icon(
//                           Icons.check_circle,
//                           size: 18,
//                           color: Theme.of(context).colorScheme.primary,
//                         ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           }).toList(),
//           const SizedBox(height: 10),
//         ],
//       ),
//     );
//   }
// }
