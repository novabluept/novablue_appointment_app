import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:novablue_appointment_app/src/features/authentication/presentation/forgot_password/forgot_password.dart';
import 'package:novablue_appointment_app/src/features/authentication/presentation/password_recovery/password_recovery.dart';
import 'package:novablue_appointment_app/src/routing/not_found_screen.dart';
import 'package:novablue_appointment_app/src/routing/scaffold_with_nested_navigation.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide Provider;
import '../features/authentication/data/auth_repository.dart';
import '../features/authentication/presentation/create_password/create_password_screen.dart';
import '../features/authentication/presentation/personal_data/personal_data_screen.dart';
import '../features/shops/presentation/shops_slidable_list/shops_slidable_list_screen.dart';
import '../features/authentication/presentation/login/login_screen.dart';
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
        child: child
      )
  );
}

enum AppRoute{
  login,
  forgotPassword,
  passwordRecovery,
  confirmEmail,
  register,
  createPassword,
  home,
  history,
  profile,
}


final goRouterProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  var authChangeEvent = ref.watch(authChangeEventProvider);
  return GoRouter(
    debugLogDiagnostics: true,
    redirect: (context,state) {
      var currentUser = authRepository.currentUser;

      final path = state.location;

      print('\$\$ currentUser -> $currentUser');
      print('\$\$ authChangeEvent -> $authChangeEvent');

      if(authChangeEvent == AuthChangeEvent.signedOut){
        if(path == '/' || path == '/profile'){
          return '/';
        }
      }else if(authChangeEvent == AuthChangeEvent.passwordRecovery){
        return '/password-recovery';
      }else if(authChangeEvent == AuthChangeEvent.signedIn){
        if(path == '/'){
          return '/home';
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
            name: AppRoute.passwordRecovery.name,
            path: 'password-recovery',
            pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: const PasswordRecoveryScreen(),
            ),
          ),
          GoRoute(
            name: AppRoute.confirmEmail.name,
            path: 'confirm-email',
            pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: Container(child: Text('confirm email')),
            ),
          ),
          GoRoute(
            name: AppRoute.register.name,
            path: 'register',
            pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: const PersonalDataScreen(),
            ),
            routes: [
            GoRoute(
                name: AppRoute.createPassword.name,
                path: 'create-password',
                pageBuilder: (context, state) {
                  CreatePasswordScreenArguments args = state.extra as CreatePasswordScreenArguments;
                  return buildPageWithDefaultTransition<void>(
                    context: context,
                    state: state,
                    child: CreatePasswordScreen(
                      args: args,
                    ),
                  );
                }
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
                          onPressed: ()async{
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