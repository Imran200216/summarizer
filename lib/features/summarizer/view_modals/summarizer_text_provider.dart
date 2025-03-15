import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SummarizerTextProvider extends ChangeNotifier {
  final TextEditingController textController = TextEditingController();
  String _summary = "";
  bool _isLoading = false;

  SummarizerTextProvider() {
    textController.addListener(_onTextChanged);
  }

  String get summary => _summary;
  bool get isLoading => _isLoading;
  bool get hasText => textController.text.trim().isNotEmpty;

  void _onTextChanged() {
    notifyListeners();
  }

  Future<void> summarizeText() async {
    if (!hasText) return;

    _isLoading = true;
    notifyListeners();

    final response = await http.post(
      Uri.parse(
        "https://api-inference.huggingface.co/models/facebook/bart-large-cnn",
      ),
      headers: {
        "Authorization": "Bearer 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",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "inputs": textController.text.trim(),
        "parameters": {"max_length": 50, "min_length": 20, "do_sample": false},
      }),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      _summary = data[0]["summary_text"] ?? "Error generating summary";

      // Store in Firestore
      await _saveSummaryToFirestore();
    } else {
      _summary = "Failed to summarize text!";
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> _saveSummaryToFirestore() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      await FirebaseFirestore.instance.collection("summarizedTexts").add({
        "userUid": user.uid,
        "userName": user.displayName ?? "Anonymous",
        "inputData": textController.text.trim(),
        "summarizedData": _summary,
        "timestamp": FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("Error saving to Firestore: $e");
    }
  }

  void clearText() {
    textController.clear();
    _summary = "";
    notifyListeners();
  }
}
