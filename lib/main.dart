import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:firebase_core/firebase_core.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundRemote service = BackgroundRemote();

  service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  await Hive.initFlutter();
  await Hive.openBox('settings');
  runApp(MyApp(notificationHelper: notificationHelper));
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
            title: 'Mini Store 2',
            theme: themeData,
            routerConfig: AppRoutes.router,
          );
        },
      ),
    );
  }
}
