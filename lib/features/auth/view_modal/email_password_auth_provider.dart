import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:summarize/core/helper/toast_helper.dart';

class EmailPasswordAuthProvider extends ChangeNotifier {
  /// Loading state
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Sign up with email and password
  Future<bool> signUpWithEmailPassword(
    String emailAddress,
    String password,
    BuildContext context,
  ) async {
    _setLoading(true);
    try {
      print("🔄 Signing up user: $emailAddress");

      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailAddress,
            password: password,
          );

      User? user = userCredential.user;
      if (user == null) {
        print("❌ Firebase returned null user after signup.");
        throw Exception("User creation failed.");
      }

      print("✅ User created successfully: UID = ${user.uid}");

      /// Storing the user data in Firestore
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid) // Use UID as document ID
          .set({
            "userEmail": emailAddress,
            "userUID": user.uid,
          }, SetOptions(merge: true));

      print("✅ User details stored in Firestore");

      ToastHelper.showSuccessToast(
        context: context,
        message: "Authentication Successful",
      );

      _setLoading(false);
      return true;
    } on FirebaseAuthException catch (e) {
      print("❌ FirebaseAuthException: ${e.code} - ${e.message}");

      if (e.code == 'weak-password') {
        ToastHelper.showErrorToast(
          context: context,
          message: "Password is too weak",
        );
      } else if (e.code == 'email-already-in-use') {
        ToastHelper.showErrorToast(
          context: context,
          message: "Account already exists",
        );
      } else {
        ToastHelper.showErrorToast(
          context: context,
          message: "Authentication failed: ${e.message}",
        );
      }

      _setLoading(false);
      return false;
    } catch (e) {
      print("❌ General Exception: $e");
      ToastHelper.showErrorToast(
        context: context,
        message: "Error: ${e.toString()}",
      );
      _setLoading(false);
      return false;
    }
  }

  /// Sign in with email and password
  Future<bool> signInWithEmailPassword(
    String emailAddress,
    String password,
    BuildContext context,
  ) async {
    _setLoading(true);
    try {
      print("🔄 Signing in user: $emailAddress");

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);

      print("✅ User signed in successfully: UID = ${userCredential.user?.uid}");

      ToastHelper.showSuccessToast(
        context: context,
        message: "Sign In Successful",
      );

      _setLoading(false);
      return true;
    } on FirebaseAuthException catch (e) {
      print("❌ FirebaseAuthException: ${e.code} - ${e.message}");

      if (e.code == 'user-not-found') {
        ToastHelper.showErrorToast(
          context: context,
          message: "No user found for that email.",
        );
      } else if (e.code == 'wrong-password') {
        ToastHelper.showErrorToast(
          context: context,
          message: "Incorrect password!",
        );
      } else {
        ToastHelper.showErrorToast(
          context: context,
          message: "Authentication failed: ${e.message}",
        );
      }

      _setLoading(false);
      return false;
    } catch (e) {
      print("❌ General Exception: $e");
      ToastHelper.showErrorToast(
        context: context,
        message: "Error: ${e.toString()}",
      );
      _setLoading(false);
      return false;
    }
  }
}
