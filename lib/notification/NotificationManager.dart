part of 'notification.dart';

class NotificationManager {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static AndroidInitializationSettings androidInitializationSettings;
  static IOSInitializationSettings iosInitializationSettings;
  static InitializationSettings initializationSettings;

  static void initializing() async {
    androidInitializationSettings =
        AndroidInitializationSettings('ic_launcher');
    iosInitializationSettings = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  static void showNotifications({int id, String title, String body}) async {
    await notification(id: id, title: title, body: body);
  }

  static void showNotificationsSchedule() async {
    await notificationSchedule();
  }

  static Future<void> notification({int id, String title, String body}) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            'Channel ID', 'Channel title', 'channel body',
            priority: Priority.high,
            enableVibration: true,
            playSound: true,
            importance: Importance.max,
            styleInformation: BigTextStyleInformation(''),
            ticker: 'test');

    IOSNotificationDetails iosNotificationDetails =
        IOSNotificationDetails(subtitle: title, presentSound: true);

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: iosNotificationDetails);

    await flutterLocalNotificationsPlugin
        .show(id, title, body, notificationDetails, payload: 'Default_Sound');
  }

  static Future<void> notificationSchedule(
      {DateTime timeSchedule,
      int id,
      String title,
      String sayHai,
      String name,
      String movie,
      String nameMovie,
      String iN,
      String numberMinutes,
      String minutes,
      String bodyNotif}) async {
    String body = sayHai +
        name +
        movie +
        nameMovie +
        iN +
        numberMinutes +
        minutes +
        bodyNotif;
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            'second channel ID', 'second Channel title', 'second channel body',
            priority: Priority.high,
            enableVibration: true,
            playSound: true,
            ongoing: true,
            importance: Importance.max,
            styleInformation: BigTextStyleInformation(''),
            ticker: 'test');

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: iosNotificationDetails);
    // ignore: deprecated_member_use
    await flutterLocalNotificationsPlugin.schedule(
        id, title, body, timeSchedule, notificationDetails);
  }

  static Future onSelectNotification(String payLoad) {
    if (payLoad != null) {
      print(payLoad);
    }
    return null;
    // we can set navigator to navigate another screen
  }

  static Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(body),
      actions: <Widget>[
        CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              print("");
            },
            child: Text("Okay")),
      ],
    );
  }
}
