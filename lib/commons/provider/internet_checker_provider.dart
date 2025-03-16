import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class InternetCheckerProvider extends ChangeNotifier {
  bool isNetworkConnected = true;
  StreamSubscription? _subscription;

  InternetCheckerProvider() {
    _checkConnection();
  }

  void _checkConnection() {
    _subscription = Connectivity().onConnectivityChanged.listen((result) {
      bool isConnected =
          result.contains(ConnectivityResult.wifi) ||
          result.contains(ConnectivityResult.mobile);

      if (isConnected != isNetworkConnected) {
        isNetworkConnected = isConnected;
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    _subscription?.cancel(); // Cancel stream on dispose
    super.dispose();
  }
}
