import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;

class SummarizerTextProvider extends ChangeNotifier {
  /// controllers
  final TextEditingController textController = TextEditingController();
  final TextEditingController minLengthController = TextEditingController();
  final TextEditingController maxLengthController = TextEditingController();

  final FlutterTts _flutterTts = FlutterTts();

  String _summary = "";
  bool _isLoading = false;
  bool _isSpeaking = false;

  SummarizerTextProvider() {
    textController.addListener(_onTextChanged);
    _initializeTTS();
  }

  String get summary => _summary;

  bool get isLoading => _isLoading;

  bool get hasText => textController.text.trim().isNotEmpty;

  bool get isSpeaking => _isSpeaking;

  void _onTextChanged() {
    notifyListeners();
  }

  /// Initialize Text-to-Speech
  Future<void> _initializeTTS() async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setSpeechRate(0.5); // Adjust for natural speed
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);

    await _flutterTts.awaitSpeakCompletion(true); // Add this line

    _flutterTts.setCompletionHandler(() {
      _isSpeaking = false;
      notifyListeners();
    });

    _flutterTts.setErrorHandler((message) {
      print("TTS Error: $message");
      _isSpeaking = false;
      notifyListeners();
    });
  }

  /// Summarize the text using Hugging Face API
  Future<void> summarizeText() async {
    if (!hasText) return;

    _isLoading = true;
    notifyListeners();

    int minLength = int.tryParse(minLengthController.text) ?? 20;
    int maxLength = int.tryParse(maxLengthController.text) ?? 50;

    if (minLength > maxLength) {
      _summary = "Error: Min length cannot be greater than max length.";
      _isLoading = false;
      notifyListeners();
      return;
    }

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
        "parameters": {
          "max_length": maxLength,
          "min_length": minLength,
          "do_sample": false,
        },
      }),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      _summary = data[0]["summary_text"] ?? "Error generating summary";

      await _saveSummaryToFirestore();

      /// ✅ Convert summary to speech after summarization
      speakSummary();
    } else {
      _summary = "Failed to summarize text!";
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Convert summary to speech
  Future<void> speakSummary() async {
    if (_summary.isNotEmpty) {
      _isSpeaking = true;
      notifyListeners();
      await _flutterTts.speak(_summary);
    }
  }

  /// Stop speaking
  Future<void> stopSpeaking() async {
    await _flutterTts.stop();
    _isSpeaking = false;
    notifyListeners();
  }

  /// Save the summarized text to Firestore
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
    minLengthController.clear();
    maxLengthController.clear();
    _summary = "";
    notifyListeners();
  }

  @override
  void dispose() {
    textController.dispose();
    minLengthController.dispose();
    maxLengthController.dispose();
    _flutterTts.stop();
    super.dispose();
  }
}
