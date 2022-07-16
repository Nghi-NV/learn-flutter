import 'package:go_router/go_router.dart';
import 'package:learn_flutter/views/login/login_page.dart';

class RoutePaths {
  static const String login = '/login';
  static const String home = '/home';
}

class Routes {
  static GoRouter routes = GoRouter(
    initialLocation: RoutePaths.login,
    routes: [
      GoRoute(
        path: RoutePaths.login,
        builder: (context, state) => const LoginPage(),
      ),
    ],
  );
}
