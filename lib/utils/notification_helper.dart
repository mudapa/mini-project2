part of 'package:mini_project_team_7/routes/routes.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');

    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse details) async {
      final payload = details.payload;
      selectNotificationSubject.add(payload ?? 'empty payload');
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        showFcmNotification(flutterLocalNotificationsPlugin,
            message.notification?.title, message.notification?.body);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      selectNotificationSubject.add(jsonEncode(message.data));
    });
  }

  Future<void> showProductNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      List<ProductModel> product) async {
    var channelId = "1";
    var channelName = "channel_01";
    var channelDescription = "mini store 2 channel";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        channelId, channelName,
        channelDescription: channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: const DefaultStyleInformation(true, true));

    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    int randomIndex = Random().nextInt(product.length);
    var selectedProduct = product[randomIndex];

    var titleNotification = "<b>New Product</b>";
    var titleProduct = selectedProduct.title;

    await flutterLocalNotificationsPlugin.show(
      0,
      titleNotification,
      titleProduct,
      platformChannelSpecifics,
      payload: jsonEncode(
        selectedProduct.toJson(),
      ),
    );
  }

  Future<void> showFcmNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    String? title,
    String? body,
  ) async {
    var channelId = "1";
    var channelName = "channel_01";
    var channelDescription = "mini store 2 channel";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        channelId, channelName,
        channelDescription: channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: const DefaultStyleInformation(true, true));

    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      title ?? 'No Title',
      body ?? 'No Body',
      platformChannelSpecifics,
      payload: jsonEncode({
        'title': title,
        'body': body,
      }),
    );
  }

  void configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen(
      (String payload) async {
        var data = ProductModel.fromJson(jsonDecode(payload));
        navigatorKey.currentState?.push(
          MaterialPageRoute(
            builder: (context) => DetailProductPage(product: data),
          ),
        );
      },
    );
  }
}
