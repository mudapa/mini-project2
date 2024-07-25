part of 'package:mini_project_team_7/routes/routes.dart';

Box get settings => Hive.box('settings');

void snackbar(
  BuildContext context, {
  required String msg,
  required Color backgroundColor,
  required Color textColor,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg, style: TextStyle(color: textColor)),
      backgroundColor: backgroundColor,
    ),
  );
}
