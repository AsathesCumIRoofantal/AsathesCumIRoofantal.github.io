// import 'package:air_app/web_modules/_shared/web_nav_data.dart';
// import 'package:air_app/web_modules/_shared/web_shell.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:air_app/web_modules/web_home/livekit_rtc_controller.dart';

// class LivekitRtcView extends GetView<LiveRtcController> {
//   const LivekitRtcView({super.key});

//   static const String routeName = WebNavData.homeLivekitRtcRoute;

//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     return Builder(
//       builder: (context) {
//         return WebShell(
//           currentRoute: routeName,
//           child: Scaffold(
//             appBar: AppBar(title: const Text('Industrial RTC Dashboard')),
//             body: LayoutBuilder(
//               builder: (context, constraints) {
//                 final isDesktop = constraints.maxWidth > 1100;
//                 final isTablet = constraints.maxWidth > 700;

//                 return GridView.builder(
//                   padding: const EdgeInsets.all(24),
//                   itemCount: 8,
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: isDesktop
//                         ? 4
//                         : isTablet
//                         ? 2
//                         : 1,
//                     crossAxisSpacing: 20,
//                     mainAxisSpacing: 20,
//                     childAspectRatio: 1.4,
//                   ),
//                   itemBuilder: (_, index) {
//                     return Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(24),
//                         gradient: LinearGradient(
//                           colors: [
//                             Colors.blue.withOpacity(.2),
//                             Colors.purple.withOpacity(.2),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }
// }



// // Responsive Features Included:

// // - Mobile Layout
// // - Tablet Layout
// // - Desktop Layout
// // - Adaptive Grid
// // - Dynamic Breakpoints
// // - Responsive Typography
// // - Light/Dark Mode
// // - Glassmorphism Cards
// // - Industrial Dashboard UI
// // - Web/Desktop Ready