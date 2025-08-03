import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../main.dart'; // Import the file where navigatorKey is defined

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  
  Future<void> initNotification() async {
    await _firebaseMessaging.subscribeToTopic("Reminder");

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Notification Received in Foreground: ${message.messageId}");
      _handleMessage(message);
    });

    
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        _handleMessage(message);
      }
    });

    
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("Notification Clicked and App Opened: ${message.messageId}");
      _handleMessage(message);
    });
  }

  
  void _handleMessage(RemoteMessage message) {
    print("Handling Message: ${message.data}");
    navigatorKey.currentState?.pushNamed('/dashboard'); 
  }
}
