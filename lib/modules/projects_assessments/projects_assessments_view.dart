import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/air_home_context_strip.dart';
import 'projects_assessments_controller.dart';

class ProjectsAssessmentsView extends GetView<ProjectsAssessmentsController> {
  const ProjectsAssessmentsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final secondary = theme.colorScheme.secondary;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primary.withOpacity(0.8), Colors.transparent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          title: const Text(
            'PROJECTS & ASSESSMENTS',
            style: TextStyle(
              letterSpacing: 2,
              fontWeight: FontWeight.w900,
              fontSize: 18,
            ),
          ),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: secondary,
            indicatorWeight: 4,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.normal,
            ),
            tabs: const [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.assignment_rounded, size: 18),
                    SizedBox(width: 8),
                    Text("PROJECTS"),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.analytics_rounded, size: 18),
                    SizedBox(width: 8),
                    Text("ASSESSMENTS"),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                theme.scaffoldBackgroundColor,
                theme.colorScheme.surface.withOpacity(0.8),
              ],
            ),
          ),
          child: TabBarView(
            children: [
              _buildProjectsList(context),
              _buildAssessmentsList(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProjectsList(BuildContext context) {
    return Obx(
      () => ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 100, 16, 100),
        itemCount: controller.projects.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: AirHomeContextStrip(
                compact: true,
                placement: AirHomeContextPlacement.nestedModuleTab,
                extraLine:
                    'PROJECTS tab — timelines here should reference entities and unions you keep current on the All-Space home tabs.',
              ),
            );
          }
          final project = controller.projects[index - 1];
          return _buildProjectCard(context, project, index - 1);
        },
      ),
    );
  }

  Widget _buildProjectCard(BuildContext context, Project project, int index) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 400 + (index * 100)),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 50 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: theme.cardColor.withOpacity(0.7),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: primary.withOpacity(0.1)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              Positioned(
                right: -20,
                top: -20,
                child: Icon(
                  Icons.assignment_rounded,
                  size: 100,
                  color: primary.withOpacity(0.05),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            project.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        _buildStatusChip(project.status),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${(project.progress * 100).toInt()}% COMPLETED",
                          style: TextStyle(
                            color: primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            letterSpacing: 1,
                          ),
                        ),
                        Text(
                          "DUE: ${project.deadline}",
                          style: TextStyle(
                            color: theme.dividerColor,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Stack(
                      children: [
                        Container(
                          height: 10,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          height: 10,
                          width:
                              (MediaQuery.of(context).size.width - 72) *
                              project.progress,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [primary, primary.withOpacity(0.6)],
                            ),
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: primary.withOpacity(0.3),
                                blurRadius: 4,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    IconData icon;
    switch (status) {
      case "Completed":
        color = Colors.lightGreenAccent;
        icon = Icons.check_circle_rounded;
        break;
      case "In Progress":
        color = Colors.amber;
        icon = Icons.pending_actions_rounded;
        break;
      default:
        color = Colors.grey;
        icon = Icons.hourglass_empty_rounded;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: color.withOpacity(0.5), width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            status.toUpperCase(),
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssessmentsList(BuildContext context) {
    return Obx(
      () => ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 100, 16, 100),
        itemCount: controller.assessments.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: AirHomeContextStrip(
                compact: true,
                placement: AirHomeContextPlacement.nestedModuleTab,
                extraLine:
                    'ASSESSMENTS tab — scores should match evidence you can trace to projects, entities, or unions on the home map.',
              ),
            );
          }
          final assessment = controller.assessments[index - 1];
          return _buildAssessmentCard(context, assessment, index - 1);
        },
      ),
    );
  }

  Widget _buildAssessmentCard(
    BuildContext context,
    Assessment assessment,
    int index,
  ) {
    final theme = Theme.of(context);
    final tertiary = theme.colorScheme.tertiary;

    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 400 + (index * 100)),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.scale(scale: 0.8 + (0.2 * value), child: child),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: theme.cardColor.withOpacity(0.7),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: tertiary.withOpacity(0.2)),
          gradient: LinearGradient(
            colors: [tertiary.withOpacity(0.05), Colors.transparent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [tertiary, tertiary.withOpacity(0.6)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: tertiary.withOpacity(0.4),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  "${assessment.score}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    assessment.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 17,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "VALIDATED ON ${assessment.date}",
                    style: TextStyle(
                      color: theme.dividerColor,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: tertiary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.verified_rounded, color: tertiary, size: 24),
            ),
          ],
        ),
      ),
    );
  }
}
