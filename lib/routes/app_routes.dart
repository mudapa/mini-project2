part of 'routes.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppRoutes {
  static final router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: NamedRoutes.splashPath,
    routes: [
      GoRoute(
        path: NamedRoutes.splashPath,
        name: NamedRoutes.splashName,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const SplashPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        ),
      ),
      GoRoute(
        path: NamedRoutes.signInPath,
        name: NamedRoutes.signInName,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const SignInPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.5, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        ),
      ),
      GoRoute(
        path: NamedRoutes.mainPagePath,
        name: NamedRoutes.mainPageName,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const MainPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        ),
      ),
      GoRoute(
        path: NamedRoutes.updateProfilePath,
        name: NamedRoutes.updateProfileName,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: DetailProfilePage(
            user: state.extra as UserModel,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        ),
      ),
      GoRoute(
        path: NamedRoutes.manageUserPath,
        name: NamedRoutes.manageUserName,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const ManageUserPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1.5, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        ),
      ),
      GoRoute(
        path: NamedRoutes.manageProductPath,
        name: NamedRoutes.manageProductName,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const ManageProductPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1.5, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        ),
      ),
      GoRoute(
        path: NamedRoutes.addProductPath,
        name: NamedRoutes.addProductName,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const AddProductPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1.5, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        ),
      ),
      GoRoute(
        path: NamedRoutes.detailProductPath,
        name: NamedRoutes.detailProductName,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: DetailProductPage(
            product: state.extra as ProductModel,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1.5, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        ),
      ),
      GoRoute(
        path: NamedRoutes.detailUserPath,
        name: NamedRoutes.detailUserName,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: DetailUserPage(
            user: state.extra as UserModel,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1.5, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        ),
      ),
    ],
  );
}
