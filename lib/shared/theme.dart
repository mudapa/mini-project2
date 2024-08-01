part of 'package:mini_project_team_7/routes/routes.dart';

ThemeData themeData = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
  useMaterial3: true,
  scaffoldBackgroundColor: backgroundColor,
  appBarTheme: AppBarTheme(
    backgroundColor: whiteColor,
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: whiteColor,
      fontWeight: FontWeight.w600,
    ),
    iconTheme: IconThemeData(
      color: whiteColor,
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: greenColor,
    shape: const CircleBorder(),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: whiteColor,
    selectedItemColor: primaryColor,
    unselectedItemColor: greyColor,
  ),
);
