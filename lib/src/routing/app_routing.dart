import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:novablue_appointment_app/src/routing/not_found_screen.dart';

import '../features/authentication/data/auth_repository.dart';
import '../features/authentication/presentation/home_page.dart';
import '../features/authentication/presentation/login_page.dart';
import '../features/authentication/presentation/splash_page.dart';
import 'go_router_refresh_stream.dart';


enum AppRoute{
  splash,
  login,
  home
}

final goRouterProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    redirect: (context,state) {
      var isLoggedIn = authRepository.currentUser != null;
      final path = state.location;
      if(isLoggedIn){
        if(path == '/' || path == '/login'){
          return '/home';
        }
      }else {
        if(path == '/' || path == '/home'){
          return '/login';
        }
      }
      return null;
    }, 
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    routes: [
      GoRoute(
        name: AppRoute.splash.name,
        path: '/',
        builder: (context,state) => const SplashPage(),
        routes: [
          GoRoute(
            name: AppRoute.login.name,
            path: 'login',
            builder: (context,state) => const LoginPage(),
          ),
          GoRoute(
            name: AppRoute.home.name,
            path: 'home',
            builder: (context,state) => const HomePage(),
          ),
        ]
      ),
    ],
    errorBuilder: (context,state) => const NotFoundScreen()
  );
});