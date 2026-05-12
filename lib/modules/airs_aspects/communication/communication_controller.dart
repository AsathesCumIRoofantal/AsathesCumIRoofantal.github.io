import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatChannel {
  final String name;
  final String lastMessage;
  final String time;
  final int unreadCount;

  ChatChannel({required this.name, required this.lastMessage, required this.time, required this.unreadCount});
}

class CommunicationController extends GetxController {
  final channels = <ChatChannel>[
    ChatChannel(name: "Global Ops", lastMessage: "Sector 7 sync complete.", time: "10:45 AM", unreadCount: 3),
    ChatChannel(name: "Tech Support", lastMessage: "Resetting node cluster B...", time: "09:30 AM", unreadCount: 0),
    ChatChannel(name: "HR Announcements", lastMessage: "New holiday schedule posted.", time: "Yesterday", unreadCount: 1),
  ].obs;
}
