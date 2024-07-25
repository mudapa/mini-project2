part of 'package:mini_project_team_7/routes/routes.dart';

class NotificationRemote {
  Future<bool> loadReminderStatus() async {
    return await settings.get('isNotif') ?? false;
  }

  Future<bool> toggleNotification(bool value) async {
    await settings.put('isNotif', value);

    if (value) {
      return await AndroidAlarmManager.periodic(
        const Duration(seconds: 10),
        0,
        BackgroundRemote.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      await AndroidAlarmManager.cancel(0);
      return false;
    }
  }
}
