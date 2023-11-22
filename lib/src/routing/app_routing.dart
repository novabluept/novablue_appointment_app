import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:novablue_appointment_app/src/features/authentication/presentation/register/create_password_screen.dart';
import 'package:novablue_appointment_app/src/features/authentication/presentation/forgot_password/forgot_password.dart';
import 'package:novablue_appointment_app/src/routing/not_found_screen.dart';
import 'package:novablue_appointment_app/src/routing/scaffold_with_nested_navigation.dart';
import '../features/authentication/data/auth_repository.dart';
import '../features/shops/presentation/shops_slidable_list/shops_slidable_list_screen.dart';
import '../features/authentication/presentation/login/login_screen.dart';
import '../features/authentication/presentation/register/register_screen.dart';
import 'go_router_refresh_stream.dart';

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        SlideTransition(
            position: animation.drive(
              Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).chain(CurveTween(curve: Curves.easeIn)),
            ),
            child: child),
  );
}

enum AppRoute{
  login,
  forgotPassword,
  register,
  createPassword,
  home,
  history,
  profile,
}


final goRouterProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return GoRouter(
    debugLogDiagnostics: true,
    redirect: (context,state) {
      var isLoggedIn = authRepository.currentUser != null;
      final path = state.location;
      if(isLoggedIn){
        if(path == '/'){
          return '/home';
        }
      }else {
        if(path == '/' || path == '/profile'){
          return '/';
        }
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    routes: [
      GoRoute(
        name: AppRoute.login.name,
        path: '/',
        builder: (context,state) => const LoginScreen(),
        routes: [
          GoRoute(
            name: AppRoute.forgotPassword.name,
            path: 'forgot-password',
            pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: const ForgotPasswordScreen(),
            ),
          ),
          GoRoute(
            name: AppRoute.register.name,
            path: 'register',
            pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: const RegisterScreen(),
            ),
            routes: [
              GoRoute(
                name: AppRoute.createPassword.name,
                path: 'create-password',
                pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
                  context: context,
                  state: state,
                  child: const CreatePasswordScreen(),
                ),
              ),
            ]
          ),
          StatefulShellRoute.indexedStack(
            builder: (context, state, navigationShell) {
              return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
            },
            branches: [
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    name: AppRoute.home.name,
                    path: 'home',
                    builder: (context,state) => const HomeScreen(),
                  ),
                ],
              ),
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    name: AppRoute.history.name,
                    path: 'history',
                    builder: (context,state) => Container(),
                  ),
                ],
              ),
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    name: AppRoute.profile.name,
                    path: 'profile',
                    builder: (context,state) => Container(
                      color: Colors.black45,
                      child: Center(
                        child: TextButton(
                          child: const Text('sign out'),
                          onPressed: () async{
                            ref.read(authRepositoryProvider).signOut();
                          }
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ]
      ),
    ],
    errorBuilder: (context,state) => const NotFoundScreen()
  );
});