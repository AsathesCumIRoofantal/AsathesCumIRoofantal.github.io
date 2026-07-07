import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'social_controller.dart';
import 'post_card.dart';
import 'post_create_view.dart';
import '../widgets/zoom_theme.dart';
import '../services/current_user.dart';

class FeedView extends StatelessWidget {
  const FeedView({super.key});
  static const routeName = '/zoom/feed';

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<SocialController>(() => SocialController());
    final c = Get.find<SocialController>();

    return Scaffold(
      backgroundColor: ZoomTheme.bg,
      body: SafeArea(
        child: LayoutBuilder(builder: (ctx, cons) {
          final wide = cons.maxWidth >= 1024;
          return RefreshIndicator(
            color: ZoomTheme.primary,
            onRefresh: () => c.loadFeed(refresh: true),
            child: CustomScrollView(slivers: [
              // App bar
              SliverAppBar(
                backgroundColor: ZoomTheme.surface,
                floating: true,
                title: Text('Feed', style: ZoomTheme.h3),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.add_box_outlined, color: ZoomTheme.primary),
                    onPressed: () => Get.to(() => const PostCreateView()),
                  ),
                ],
              ),

              // Create-post quick bar
              SliverToBoxAdapter(child: Padding(
                padding: EdgeInsets.symmetric(horizontal: wide ? 200 : 12, vertical: 8),
                child: GestureDetector(
                  onTap: () => Get.to(() => const PostCreateView()),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: ZoomTheme.card(r: 12),
                    child: Row(children: [
                      CircleAvatar(radius: 18,
                        backgroundColor: ZoomTheme.primary.withOpacity(.2),
                        child: Text(
                          CurrentUser.isSignedIn ? CurrentUser.name[0].toUpperCase() : 'G',
                          style: const TextStyle(color: ZoomTheme.primary),
                        )),
                      const SizedBox(width: 12),
                      Expanded(child: Text("What's on your mind?",
                          style: ZoomTheme.muted)),
                      const Icon(Icons.photo_outlined, color: ZoomTheme.primary),
                    ]),
                  ),
                ),
              )),

              // Feed list
              Obx(() {
                if (c.isLoading.value && c.posts.isEmpty) {
                  return const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator(color: ZoomTheme.primary)));
                }
                return SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: wide ? 200 : 8),
                  sliver: SliverList(delegate: SliverChildBuilderDelegate(
                    (_, i) {
                      if (i == c.posts.length) {
                        if (!c.hasMore.value) {
                          return Padding(
                            padding: const EdgeInsets.all(24),
                            child: Center(child: Text('You\'re all caught up!', style: ZoomTheme.muted)),
                          );
                        }
                        c.loadFeed();
                        return const Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(child: CircularProgressIndicator(color: ZoomTheme.primary)),
                        );
                      }
                      return PostCard(post: c.posts[i]);
                    },
                    childCount: c.posts.length + 1,
                  )),
                );
              }),

              const SliverToBoxAdapter(child: SizedBox(height: 60)),
            ]),
          );
        }),
      ),
    );
  }
}
