import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'managements_controller.dart';

class ManagementsView extends GetView<ManagementsController> {
  const ManagementsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          'MANAGEMENTS',
          style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildSummaryCards(context),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              onChanged: (val) => controller.searchQuery.value = val,
              decoration: InputDecoration(
                hintText: "Search tasks, IDs, or assignees...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "MANAGEMENT ASSIGNMENTS",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    color: Colors.grey,
                  ),
                ),
                Obx(
                  () => Text(
                    "${controller.filteredTasks.length} ITEMS",
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: controller.filteredTasks.length,
                itemBuilder: (context, index) {
                  final task = controller.filteredTasks[index];
                  return _buildTaskCard(context, task);
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCreateTaskBottomSheet(context),
        label: const Text("CREATE MANAGEMENT STUFF"),
        icon: const Icon(Icons.add_task),
      ),
    );
  }

  Widget _buildSummaryCards(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          _buildSummaryItem(
            context,
            "Total",
            controller.tasks.length.toString(),
            Icons.assessment,
            Colors.blue,
          ),
          const SizedBox(width: 12),
          _buildSummaryItem(
            context,
            "High Pri",
            controller.tasks
                .where((t) => t.priority == "High")
                .length
                .toString(),
            Icons.priority_high,
            Colors.red,
          ),
          const SizedBox(width: 12),
          _buildSummaryItem(
            context,
            "Done",
            "0",
            Icons.check_circle_outline,
            Colors.green,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Theme.of(context).dividerColor.withOpacity(0.1),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskCard(BuildContext context, ManagementTask task) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).dividerColor.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                task.id,
                style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              Row(
                children: [
                  _buildCategoryBadge(task.category),
                  const SizedBox(width: 8),
                  _buildPriorityBadge(task.priority),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            task.title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.person_outline, size: 14, color: Colors.grey),
              const SizedBox(width: 4),
              Text(
                task.assignedTo,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const Spacer(),
              const Icon(
                Icons.calendar_month_outlined,
                size: 14,
                color: Colors.grey,
              ),
              const SizedBox(width: 4),
              Text(
                DateFormat('MMM dd').format(task.dueDate),
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriorityBadge(String priority) {
    Color color = priority == "High"
        ? Colors.red
        : (priority == "Medium" ? Colors.orange : Colors.green);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        priority,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildCategoryBadge(String category) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        category.toUpperCase(),
        style: const TextStyle(
          color: Colors.blue,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _showCreateTaskBottomSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "CREATE MANAGEMENT TASK",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: controller.titleController,
                decoration: InputDecoration(
                  labelText: "Task Title",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller.assignedController,
                decoration: InputDecoration(
                  labelText: "Assign To",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller.categoryController,
                decoration: InputDecoration(
                  labelText: "Category (e.g. HR, Tech, Dev)",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Priority",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Obx(
                () => Row(
                  children: ["Low", "Medium", "High"]
                      .map(
                        (p) => Expanded(
                          child: RadioListTile<String>(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              p,
                              style: const TextStyle(fontSize: 12),
                            ),
                            value: p,
                            groupValue: controller.selectedPriority.value,
                            onChanged: (val) =>
                                controller.selectedPriority.value = val!,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => controller.createTask(),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("REGISTER ASSIGNMENT"),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }
}
