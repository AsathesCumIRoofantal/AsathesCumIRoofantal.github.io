import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'practice_expertise_controller.dart';

class PracticeExpertiseView extends GetView<PracticeExpertiseController> {
  const PracticeExpertiseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("PRACTICE EXPERTISE", style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Obx(() => ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: controller.courses.length,
        itemBuilder: (context, index) {
          final course = controller.courses[index];
          return _buildCourseCard(context, course);
        },
      )),
    );
  }

  Widget _buildCourseCard(BuildContext context, ExpertiseCourse course) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(20),
            leading: CircleAvatar(
              backgroundColor: Colors.blue.withOpacity(0.1),
              child: Icon(course.isCompleted ? Icons.check : Icons.menu_book_outlined, color: Colors.blue),
            ),
            title: Text(course.title, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("${course.difficulty} • ${course.duration} mins", style: const TextStyle(fontSize: 12)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.enrollInCourse(course.title),
                style: ElevatedButton.styleFrom(
                  backgroundColor: course.isCompleted ? Colors.grey : Colors.blue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text(course.isCompleted ? "REVIEW COURSE" : "START LEARNING"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
