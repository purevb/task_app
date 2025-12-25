import 'package:go_router/go_router.dart';
import 'package:task_app/features/auth/pages/sign_in.dart';
import 'package:task_app/features/auth/pages/sign_up.dart';

class KRouter {
  final GoRouter router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SignUpPage()),
      GoRoute(path: '/login', builder: (context, state) => const SignInPage()),
    ],
  );
}
