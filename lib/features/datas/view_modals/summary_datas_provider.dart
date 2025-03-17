import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SummaryDataProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<Map<String, dynamic>> _summaries = [];
  bool _isLoading = false;

  List<Map<String, dynamic>> get summaries => _summaries;

  bool get isLoading => _isLoading;

  /// Fetch summaries for the logged-in user
  Future<void> fetchUserSummaries() async {
    if (_isLoading) return; // Prevent multiple calls

    _isLoading = true;
    notifyListeners();

    try {
      User? user = _auth.currentUser;
      if (user != null) {
        QuerySnapshot snapshot =
            await _firestore
                .collection("summarizedTexts")
                .where("userUid", isEqualTo: user.uid)
                .orderBy("timestamp", descending: true)
                .get();

        List<Map<String, dynamic>> newSummaries =
            snapshot.docs
                .map(
                  (doc) => {
                    "id": doc.id,
                    ...doc.data() as Map<String, dynamic>,
                  },
                )
                .toList();

        if (_summaries != newSummaries) {
          _summaries = newSummaries;
          notifyListeners();
        }
      }
    } catch (e) {
      print("Error fetching summaries: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
