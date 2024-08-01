import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'firebase_options.dart';
import 'routes/bloc_providers.dart';
import 'routes/routes.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundRemote service = BackgroundRemote();

  service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  await Hive.initFlutter();
  await Hive.openBox('settings');

  await saveDeviceToken();
  FirebaseMessaging.instance.onTokenRefresh.listen(saveDeviceToken);

  runApp(MyApp(notificationHelper: notificationHelper));
}

Future<void> saveDeviceToken([String? token]) async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  token ??= await messaging.getToken();

  if (token != null) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    await firestore.collection('device_tokens').doc(token).set({
      'token': token,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}

class MyApp extends StatelessWidget {
  final NotificationHelper notificationHelper;
  const MyApp({super.key, required this.notificationHelper});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: BlocProviders.providers,
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          notificationHelper.configureSelectNotificationSubject();
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Mini Store 3',
            theme: themeData,
            routerConfig: AppRoutes.router,
          );
        },
      ),
    );
  }
}
