import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Quote {
  final String text;
  final String author;

  Quote({required this.text, required this.author});
}

class MotivationController extends GetxController {
  final quotes = <Quote>[
    Quote(text: "The only way to do great work is to love what you do.", author: "Steve Jobs"),
    Quote(text: "Innovation distinguishes between a leader and a follower.", author: "Steve Jobs"),
    Quote(text: "The future depends on what you do today.", author: "Mahatma Gandhi"),
  ].obs;

  var currentQuoteIndex = 0.obs;

  void nextQuote() {
    currentQuoteIndex.value = (currentQuoteIndex.value + 1) % quotes.length;
  }
}
