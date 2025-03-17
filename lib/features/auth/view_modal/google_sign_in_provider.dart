import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:summarize/core/helper/toast_helper.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId:
        kIsWeb
            ? "911646898774-6gb4k9omnj1rm81bnbqlt2j5tej6bdsi.apps.googleusercontent.com"
            : null,
  );

  GoogleSignInAccount? _user;
  bool _isLoading = false;

  GoogleSignInAccount? get user => _user;

  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Google Sign-In for Mobile & Web
  Future<bool> signInWithGoogle(BuildContext context) async {
    _setLoading(true);
    try {
      UserCredential authResult;

      if (kIsWeb) {
        // Google Sign-In for Web (using signInWithPopup)
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        authResult = await FirebaseAuth.instance.signInWithPopup(
          googleProvider,
        );
      } else {
        // Google Sign-In for Mobile
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
        if (googleUser == null) {
          _setLoading(false);
          return false;
        }

        _user = googleUser;
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        authResult = await FirebaseAuth.instance.signInWithCredential(
          credential,
        );
      }

      if (authResult.user != null) {
        ToastHelper.showSuccessToast(
          context: context,
          message: "Google Sign-In Successful!",
        );

        // Store user data in Firestore
        await FirebaseFirestore.instance
            .collection("users")
            .doc(authResult.user!.uid)
            .set({
              "userEmail": authResult.user!.email,
              "userUID": authResult.user!.uid,
            }, SetOptions(merge: true));

        _setLoading(false);
        return true;
      } else {
        ToastHelper.showErrorToast(
          context: context,
          message: "Google Sign-In Failed!",
        );
        _setLoading(false);
        return false;
      }
    } catch (e) {
      print('Error signing in with Google: $e');
      ToastHelper.showErrorToast(
        context: context,
        message: "Google Sign-In Failed!",
      );
      _setLoading(false);
      return false;
    }
  }

  /// Sign out
  Future<bool> logout() async {
    _setLoading(true);
    try {
      if (!kIsWeb) {
        await _googleSignIn.disconnect();
      }
      await FirebaseAuth.instance.signOut();
      _user = null;
      _setLoading(false);
      return true; // Logout successful
    } catch (e) {
      print('Error signing out: $e');
      _setLoading(false);
      return false; // Logout failed
    }
  }

  /// Check authentication state
  Future<bool> isUserSignedIn() async {
    return FirebaseAuth.instance.currentUser != null;
  }
}
