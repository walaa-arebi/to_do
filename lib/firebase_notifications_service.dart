import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotificationsService{

  final _firebaseMessagingApi=FirebaseMessaging.instance;

  Future<void> initNotifications()async{
    await _firebaseMessagingApi.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    final fcmToken =await _firebaseMessagingApi.getToken();
    log("token $fcmToken");
    // FirebaseMessaging.onBackgroundMessage((message) async{
    //   print("");
    // });
  }
}