import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManagementTask {
  final String id;
  final String title;
  final String assignedTo;
  final String priority;
  final String status;
  final String category;
  final DateTime dueDate;

  ManagementTask({
    required this.id,
    required this.title,
    required this.assignedTo,
    required this.priority,
    required this.status,
    required this.category,
    required this.dueDate,
  });
}

class ManagementsController extends GetxController {
  final tasks = <ManagementTask>[
    ManagementTask(
      id: "MGT-101",
      title: "Quarterly Strategy Review",
      assignedTo: "Executive Team",
      priority: "High",
      status: "In Progress",
      category: "Strategy",
      dueDate: DateTime.now().add(const Duration(days: 4)),
    ),
    ManagementTask(
      id: "MGT-102",
      title: "Cloud Infrastructure Upgrade",
      assignedTo: "DevOps Team",
      priority: "Medium",
      status: "Planning",
      category: "Tech",
      dueDate: DateTime.now().add(const Duration(days: 10)),
    ),
    ManagementTask(
      id: "MGT-103",
      title: "Annual Stakeholder Meeting",
      assignedTo: "PR Dept",
      priority: "High",
      status: "Scheduled",
      category: "Event",
      dueDate: DateTime.now().add(const Duration(days: 30)),
    ),
    ManagementTask(
      id: "MGT-104",
      title: "Security Audit Compliance",
      assignedTo: "SecOps Team",
      priority: "High",
      status: "Planning",
      category: "Security",
      dueDate: DateTime.now().add(const Duration(days: 15)),
    ),
    ManagementTask(
      id: "MGT-105",
      title: "New Employee Orientation",
      assignedTo: "HR Department",
      priority: "Low",
      status: "Ongoing",
      category: "HR",
      dueDate: DateTime.now().add(const Duration(days: 2)),
    ),
    ManagementTask(
      id: "MGT-106",
      title: "Market Expansion Research",
      assignedTo: "Growth Team",
      priority: "Medium",
      status: "Drafting",
      category: "Growth",
      dueDate: DateTime.now().add(const Duration(days: 45)),
    ),
    ManagementTask(
      id: "MGT-107",
      title: "Legacy Code Refactoring",
      assignedTo: "Engineering",
      priority: "Low",
      status: "Backlog",
      category: "Dev",
      dueDate: DateTime.now().add(const Duration(days: 90)),
    ),
  ].obs;

  var searchQuery = "".obs;
  List<ManagementTask> get filteredTasks {
    if (searchQuery.value.isEmpty) return tasks;
    return tasks.where((t) => 
      t.title.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
      t.assignedTo.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
      t.id.toLowerCase().contains(searchQuery.value.toLowerCase())
    ).toList();
  }

  final titleController = TextEditingController();
  final assignedController = TextEditingController();
  final categoryController = TextEditingController();
  var selectedPriority = "Medium".obs;
  var selectedDate = DateTime.now().obs;

  void createTask() {
    if (titleController.text.isNotEmpty && assignedController.text.isNotEmpty) {
      tasks.add(ManagementTask(
        id: "MGT-${100 + tasks.length + 1}",
        title: titleController.text,
        assignedTo: assignedController.text,
        priority: selectedPriority.value,
        status: "New",
        category: categoryController.text.isEmpty ? "General" : categoryController.text,
        dueDate: selectedDate.value,
      ));
      
      titleController.clear();
      assignedController.clear();
      categoryController.clear();
      selectedPriority.value = "Medium";
      selectedDate.value = DateTime.now();
      
      Get.back();
      Get.snackbar(
        "Task Created",
        "Management assignment successfully registered.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue.withOpacity(0.8),
        colorText: Colors.white,
      );
    } else {
      Get.snackbar("Error", "Please fill all fields");
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    assignedController.dispose();
    categoryController.dispose();
    super.onClose();
  }
}
