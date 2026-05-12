import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalendarEvent {
  final String title;
  final String time;
  final String type;

  CalendarEvent({required this.title, required this.time, required this.type});
}

class FollowCalendarController extends GetxController {
  final events = <CalendarEvent>[
    CalendarEvent(title: "System Maintenance", time: "09:00 AM", type: "Operational"),
    CalendarEvent(title: "Community Q&A", time: "02:00 PM", type: "Social"),
    CalendarEvent(title: "New Sector Sync", time: "05:00 PM", type: "Update"),
  ].obs;
}
