import 'package:air_app/modules/wisdom/wisdom_best_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/air_home_context_strip.dart';
import 'wisdom_controller.dart';

class WisdomView extends GetView<WisdomController> {
  final bool isEmbedded;
  const WisdomView({super.key, this.isEmbedded = false});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Wisdom (Expert Overview)'),
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: Theme.of(context).colorScheme.primary,
            labelColor: Theme.of(context).colorScheme.primary,
            unselectedLabelColor: Theme.of(
              context,
            ).dividerColor.withValues(alpha: 0.5),
            tabs: const [
              Tab(text: "Enlightened & Being there"),
              Tab(text: "Task And Feed"),
              Tab(text: "Your achievements"),
              Tab(text: "Things You Consider"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildEnlightenedTab(context),
            _buildTaskFeedTab(context),
            _buildAchievementsTab(context),
            _buildConsiderationsTab(context),
            WisdomBestView(),
          ],
        ),
      ),
    );
  }

  // TAB 1: Dashboard with Expandable Cards
  Widget _buildEnlightenedTab(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: AirHomeContextStrip(
            compact: true,
            placement: AirHomeContextPlacement.nestedModuleTab,
            extraLine:
                'Enlightened & Being there — expand each card for the long read; your all-space catalogue stays on the home ENTITIES and UNIONS tabs.',
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.enlightenedCategories.length,
            itemBuilder: (context, index) {
              final item = controller.enlightenedCategories[index];
              final Color iconColor = item['color'] as Color;

              return Obx(() {
                final bool isExpanded =
                    controller.expandedCards[index] ?? false;

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: iconColor.withValues(alpha: 0.3)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(
                          alpha: isDark ? 0.2 : 0.05,
                        ),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      controller.toggleCardExpanded(index);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                item['icon'] as IconData,
                                size: 30,
                                color: iconColor,
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  item['title'] as String,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge?.color,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                              Icon(
                                isExpanded
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                color: Theme.of(context).dividerColor,
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            item['shortDesc'] as String,
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.color,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          if (!isExpanded) ...[
                            const SizedBox(height: 8),
                            Text(
                              "Tap more to read...",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                          AnimatedCrossFade(
                            firstChild: const SizedBox(
                              height: 0,
                              width: double.infinity,
                            ),
                            secondChild: Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Text(
                                item['longDesc'] as String,
                                style: TextStyle(
                                  fontSize: 15,
                                  height: 1.5,
                                  color: Theme.of(
                                    context,
                                  ).textTheme.bodyLarge?.color,
                                ),
                              ),
                            ),
                            crossFadeState: isExpanded
                                ? CrossFadeState.showSecond
                                : CrossFadeState.showFirst,
                            duration: const Duration(milliseconds: 300),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
            },
          ),
        ),
      ],
    );
  }

  // TAB 2: Task And Feed
  Widget _buildTaskFeedTab(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: AirHomeContextStrip(
            compact: true,
            placement: AirHomeContextPlacement.nestedModuleTab,
            extraLine:
                'Task And Feed — confidential rows stay in this lane; cross-check names with ENTITIES before you log outcomes elsewhere.',
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.expertTasks.length,
            itemBuilder: (context, index) {
              final task = controller.expertTasks[index];
              final isConfidential = task['confidential'] as bool;

              return Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: isConfidential
                        ? Colors.red.withValues(alpha: 0.3)
                        : Theme.of(context).dividerColor,
                  ),
                ),
                color: Theme.of(context).cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          if (isConfidential) ...[
                            const Icon(
                              Icons.privacy_tip,
                              color: Colors.redAccent,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                          ],
                          Expanded(
                            child: Text(
                              task['title'] as String,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isConfidential
                                    ? Colors.redAccent
                                    : Theme.of(
                                        context,
                                      ).textTheme.bodyLarge?.color,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Theme.of(context).dividerColor,
                              ),
                            ),
                            child: Text(
                              task['status'] as String,
                              style: TextStyle(
                                fontSize: 10,
                                color: Theme.of(
                                  context,
                                ).textTheme.bodyMedium?.color,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        task['details'] as String,
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // TAB 3: Your Achievements
  Widget _buildAchievementsTab(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: AirHomeContextStrip(
                compact: true,
                placement: AirHomeContextPlacement.nestedModuleTab,
                extraLine:
                    'Your achievements — each reward should echo work you can point to from ENTITIES, UNIONS, or drawer ledgers.',
              ),
            ),
            const SizedBox(height: 16),
            Icon(
              Icons.military_tech,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              "EXPERT REWARDS",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: controller.achievements.length,
                itemBuilder: (context, index) {
                  final reward = controller.achievements[index];
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.2),
                      child: Icon(
                        reward['icon'] as IconData,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    title: Text(
                      reward['title'] as String,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    subtitle: Text(
                      "Unlocked: ${reward['date']}",
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // TAB 4: Things You Consider
  Widget _buildConsiderationsTab(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: AirHomeContextStrip(
            compact: true,
            placement: AirHomeContextPlacement.nestedModuleTab,
            extraLine:
                'Things You Consider — treat each line as a bookmark; IDENTITY and drawer study lanes stay one navigation step away.',
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.consideredResources.length,
            itemBuilder: (context, index) {
              final plan = controller.consideredResources[index];
              return ListTile(
                leading: Icon(
                  Icons.radio_button_checked,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                title: Text(
                  plan,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                    height: 1.4,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
              );
            },
          ),
        ),
      ],
    );
  }
}
