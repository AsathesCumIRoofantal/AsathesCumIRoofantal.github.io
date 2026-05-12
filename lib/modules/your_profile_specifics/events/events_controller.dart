import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Event {
  final String title;
  final String description;
  final DateTime date;
  final String location;
  final IconData icon;
  final Color color;

  Event({
    required this.title,
    required this.description,
    required this.date,
    required this.location,
    required this.icon,
    this.color = Colors.blue,
  });
}

class EventsController extends GetxController {
  final List<Event> events = [
    Event(
      title: "Global Innovation Summit",
      description: "A gathering of minds to discuss the future of AI and space exploration.",
      date: DateTime.now().add(const Duration(days: 5)),
      location: "Virtual - MetaVerse",
      icon: Icons.rocket_launch,
      color: Colors.deepPurple,
    ),
    Event(
      title: "AIR Community Meetup",
      description: "Connect with fellow creators and thinkers in the AIR ecosystem.",
      date: DateTime.now().add(const Duration(days: 12)),
      location: "Zentrum Hub, Berlin",
      icon: Icons.groups,
      color: Colors.blue,
    ),
    Event(
      title: "Wisdom Workshop",
      description: "Deep dive into ancient philosophies applied to modern technology.",
      date: DateTime.now().add(const Duration(days: 20)),
      location: "Kyoto, Japan",
      icon: Icons.auto_stories,
      color: Colors.orange,
    ),
    Event(
      title: "AIR App Launch V3.0",
      description: "Official launch event for the next major version of AIR-APP.",
      date: DateTime.now().subtract(const Duration(days: 2)),
      location: "San Francisco, CA",
      icon: Icons.app_shortcut,
      color: Colors.green,
    ),
  ].obs;

  final titleController = TextEditingController();
  final descController = TextEditingController();
  final locationController = TextEditingController();
  var selectedDate = DateTime.now().obs;
  var selectedColor = Colors.blue.obs;

  List<Event> get upcomingEvents => events.where((e) => e.date.isAfter(DateTime.now())).toList();
  List<Event> get pastEvents => events.where((e) => e.date.isBefore(DateTime.now())).toList();

  void addEvent() {
    if (titleController.text.isNotEmpty && descController.text.isNotEmpty) {
      events.add(Event(
        title: titleController.text,
        description: descController.text,
        date: selectedDate.value,
        location: locationController.text,
        icon: Icons.star,
        color: selectedColor.value,
      ));
      
      // Clear controllers
      titleController.clear();
      descController.clear();
      locationController.clear();
      selectedDate.value = DateTime.now();
      
      Get.back(); // Close bottom sheet
      Get.snackbar(
        "Success",
        "Event added successfully!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.8),
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        "Error",
        "Please fill in all required fields",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    descController.dispose();
    locationController.dispose();
    super.onClose();
  }
}
