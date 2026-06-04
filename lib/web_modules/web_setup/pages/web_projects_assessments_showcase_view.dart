import 'package:air_app/web_modules/_shared/web_shell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class WebProjectsAssessmentsShowcaseView extends StatefulWidget {
  const WebProjectsAssessmentsShowcaseView({super.key});

  static const routeName = '/web-setup/projects-assessments-showcase';

  @override
  State<WebProjectsAssessmentsShowcaseView> createState() =>
      _WebProjectsAssessmentsShowcaseViewState();
}

class _WebProjectsAssessmentsShowcaseViewState
    extends State<WebProjectsAssessmentsShowcaseView> {
  String activeTab = 'projects';

  final List<Map<String, dynamic>> projects = [
    {
      'name': 'E-Commerce Platform 2.0',
      'status': 'in-progress',
      'progress': 0.65,
      'team': [
        'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=50',
        'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=50',
      ],
      'dueDate': 'Mar 15, 2024',
      'tasks': 24,
      'completedTasks': 16,
    },
    {
      'name': 'Mobile App Redesign',
      'status': 'in-progress',
      'progress': 0.42,
      'team': [
        'https://images.pexels.com/photos/1181686/pexels-photo-1181686.jpeg?auto=compress&cs=tinysrgb&w=50',
      ],
      'dueDate': 'Apr 01, 2024',
      'tasks': 18,
      'completedTasks': 8,
    },
    {
      'name': 'API Integration Suite',
      'status': 'completed',
      'progress': 1.0,
      'team': [
        'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=50',
        'https://images.pexels.com/photos/1239291/pexels-photo-1239291.jpeg?auto=compress&cs=tinysrgb&w=50',
        'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=50',
      ],
      'dueDate': 'Feb 28, 2024',
      'tasks': 32,
      'completedTasks': 32,
    },
  ];

  final List<Map<String, dynamic>> assessments = [
    {
      'title': 'Code Quality Review',
      'type': 'Technical',
      'status': 'active',
      'participants': 12,
      'questions': 45,
      'duration': '2 hours',
      'icon': Icons.code,
      'color': [Colors.blue[400]!, Colors.cyan[500]!],
    },
    {
      'title': 'Design System Assessment',
      'type': 'Creative',
      'status': 'scheduled',
      'participants': 8,
      'questions': 30,
      'duration': '1.5 hours',
      'icon': Icons.design_services,
      'color': [Colors.purple[400]!, Colors.pink[500]!],
    },
    {
      'title': 'Project Management Skills',
      'type': 'Soft Skills',
      'status': 'completed',
      'participants': 25,
      'questions': 50,
      'duration': '3 hours',
      'icon': Icons.assignment_turned_in,
      'color': [Colors.green[400]!, Colors.teal[500]!],
    },
  ];

  Color getStatusColor(String status) {
    switch (status) {
      case 'completed':
        return Colors.green[500]!;
      case 'in-progress':
        return Colors.blue[500]!;
      case 'active':
        return Colors.blue[500]!;
      case 'scheduled':
        return Colors.amber[500]!;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return WebShell(
      currentRoute: WebProjectsAssessmentsShowcaseView.routeName,
      child: Scaffold(
        backgroundColor: isDark
            ? const Color(0xFF08111F)
            : const Color(0xFFF5F7FB),
        body: CustomScrollView(
          slivers: [
            // Header
            SliverAppBar(
              expandedHeight: 200,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.purple[500]!,
                        Colors.pink[400]!,
                        Colors.red[400]!,
                      ],
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.purple[500]!,
                                  Colors.pink[500]!,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(
                                  Icons.folder,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Project Management',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Projects & Assessments',
                            style: Theme.of(context).textTheme.headlineLarge
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Manage projects and track progress',
                            style: TextStyle(
                              color: Colors.purple[100],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Stats
            SliverToBoxAdapter(
              child: Transform.translate(
                offset: const Offset(0, -20),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildStats(),
                ),
              ),
            ),

            // Tab Navigation
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildTabButton(
                        label: 'Projects',
                        icon: Icons.folder_outlined,
                        isSelected: activeTab == 'projects',
                        onTap: () => setState(() => activeTab = 'projects'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildTabButton(
                        label: 'Assessments',
                        icon: Icons.assignment_outlined,
                        isSelected: activeTab == 'assessments',
                        onTap: () => setState(() => activeTab = 'assessments'),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Content
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: activeTab == 'projects'
                      ? _buildProjectsList()
                      : _buildAssessmentsList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStats() {
    final stats = [
      {'label': 'Active Projects', 'value': '12', 'icon': Icons.folder},
      {'label': 'Completed', 'value': '156', 'icon': Icons.check_circle},
      {'label': 'Team Members', 'value': '24', 'icon': Icons.people},
      {'label': 'Success Rate', 'value': '94%', 'icon': Icons.trending_up},
    ];

    return Card(
      elevation: 8,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: stats.asMap().entries.map((entry) {
            final stat = entry.value;
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.purple.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    stat['icon'] as IconData,
                    color: Colors.purple[600],
                    size: 20,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  stat['value'] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  stat['label'] as String,
                  style: TextStyle(fontSize: 9, color: Colors.grey[600]),
                ),
              ],
            ).animate().fadeIn(delay: (entry.key * 100).ms);
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildTabButton({
    required String label,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(colors: [Colors.purple[500]!, Colors.pink[500]!])
              : null,
          color: isSelected ? null : Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.grey[600],
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[700],
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectsList() {
    return Column(
      key: const ValueKey('projects'),
      children: projects.asMap().entries.map((entry) {
        final index = entry.key;
        final project = entry.value;

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: Card(
            elevation: 4,
            shadowColor: Colors.black26,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: getStatusColor(project['status']),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        project['status'].toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey[600],
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    project['name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: project['progress'],
                            backgroundColor: Colors.grey[200],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              project['status'] == 'completed'
                                  ? Colors.green[500]!
                                  : Colors.purple[500]!,
                            ),
                            minHeight: 6,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '${(project['progress'] * 100).toInt()}%',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Stack(
                        children: (project['team'] as List<String>)
                            .asMap()
                            .entries
                            .map((avatar) {
                              return Container(
                                margin: EdgeInsets.only(
                                  left: avatar.key * 20.0,
                                ),
                                child: CircleAvatar(
                                  radius: 14,
                                  backgroundImage: NetworkImage(avatar.value),
                                  backgroundColor: Colors.white,
                                ),
                              );
                            })
                            .toList(),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.check_circle_outline,
                        size: 16,
                        color: Colors.grey[500],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${project['completedTasks']}/${project['tasks']}',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                      const SizedBox(width: 12),
                      Icon(
                        Icons.calendar_today,
                        size: 14,
                        color: Colors.grey[500],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        project['dueDate'],
                        style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ).animate().fadeIn(delay: (index * 100).ms).slideY(begin: 0.2, end: 0);
      }).toList(),
    );
  }

  Widget _buildAssessmentsList() {
    return Column(
      key: const ValueKey('assessments'),
      children: assessments.asMap().entries.map((entry) {
        final index = entry.key;
        final assessment = entry.value;

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: Card(
            elevation: 4,
            shadowColor: Colors.black26,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.grey[50]!, Colors.white],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: assessment['color'] as List<Color>,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: (assessment['color'] as List<Color>).first
                                  .withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Icon(
                          assessment['icon'] as IconData,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              assessment['title'],
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              assessment['type'],
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: getStatusColor(assessment['status']),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          assessment['status'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildAssessmentStat(
                        '${assessment['participants']}',
                        'People',
                      ),
                      _buildAssessmentStat(
                        '${assessment['questions']}',
                        'Questions',
                      ),
                      _buildAssessmentStat(assessment['duration'], 'Duration'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ).animate().fadeIn(delay: (index * 150).ms).slideX(begin: 0.2, end: 0);
      }).toList(),
    );
  }

  Widget _buildAssessmentStat(String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          Text(label, style: TextStyle(fontSize: 10, color: Colors.grey[600])),
        ],
      ),
    );
  }
}
