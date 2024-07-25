part of 'package:mini_project_team_7/routes/routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      final userId = settings.get('id');
      if (userId != null) {
        GoRouter.of(context).go(NamedRoutes.mainPagePath);
        snackbar(
          context,
          msg: 'Welcome back!',
          backgroundColor: greenColor,
          textColor: whiteColor,
        );
      } else {
        GoRouter.of(context).go(NamedRoutes.signInPath);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Mini Store 2',
              style: display.copyWith(fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            lottieSplash,
          ],
        ),
      ),
    );
  }
}
