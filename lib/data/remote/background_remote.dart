part of 'package:mini_project_team_7/routes/routes.dart';

final ReceivePort port = ReceivePort();

class BackgroundRemote {
  static BackgroundRemote? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundRemote._internal() {
    _instance = this;
  }

  factory BackgroundRemote() => _instance ?? BackgroundRemote._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    final NotificationHelper notificationHelper = NotificationHelper();
    var result = await ProductRemote().fetchListProduct();
    await notificationHelper.showProductNotification(
      FlutterLocalNotificationsPlugin(),
      result,
    );

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
