import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewsItem {
  final String title;
  final String date;
  final String tag;
  final String description;

  NewsItem({required this.title, required this.date, required this.tag, required this.description});
}

class NewInAirController extends GetxController {
  final news = <NewsItem>[
    NewsItem(title: "Version 2.4 Released", date: "May 10", tag: "UPDATE", description: "Improved biometric sync and decentralized file storage."),
    NewsItem(title: "New Partner: SpaceX", date: "May 08", tag: "PARTNER", description: "Official integration with SpaceX orbital logistics network."),
    NewsItem(title: "AIR Global Summit", date: "May 05", tag: "EVENT", description: "Join us in the virtual arena for the annual roadmap reveal."),
  ].obs;
}
