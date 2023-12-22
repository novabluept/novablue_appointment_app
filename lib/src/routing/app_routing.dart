
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:novablue_appointment_app/src/features/appointments/presentation/history/history_screen.dart';
import 'package:novablue_appointment_app/src/features/authentication/presentation/change_role/change_role_screen.dart';
import 'package:novablue_appointment_app/src/features/authentication/presentation/email_confirmation/email_confirmation_screen.dart';
import 'package:novablue_appointment_app/src/features/authentication/presentation/login/login_screen.dart';
import 'package:novablue_appointment_app/src/features/authentication/presentation/password/create_password/create_password_screen.dart';
import 'package:novablue_appointment_app/src/features/authentication/presentation/password/forgot_password/forgot_password_screen.dart';
import 'package:novablue_appointment_app/src/features/authentication/presentation/password/password_recovery/password_recovery_screen.dart';
import 'package:novablue_appointment_app/src/features/authentication/presentation/personal_data/personal_data_screen.dart';
import 'package:novablue_appointment_app/src/features/authentication/presentation/profile/profile_screen.dart';
import 'package:novablue_appointment_app/src/routing/not_found_screen.dart';
import 'package:novablue_appointment_app/src/routing/refresh_service/refresh_service_provider.dart';
import 'package:novablue_appointment_app/src/routing/scaffold_with_nested_navigation/scaffold_with_nested_navigation.dart';
import 'package:novablue_appointment_app/src/routing/refresh_service/refresh_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide Provider;
import '../features/language/change_language/change_language_screen.dart';
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
  admin,
  worker,
  login,
  forgotPassword,
  passwordRecovery,
  confirmEmail,
  register,
  createPassword,
  home,
  history,
  profile,
  changeLanguage,
  changeRole,
}

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

List<StatefulShellBranch> branches(){

  return [
    StatefulShellBranch(
      routes: [
        GoRoute(
          name: AppRoute.home.name,
          path: 'home',
          builder: (context,state) => Container(color: Colors.red.shade300,child: Text('home')),
        ),
      ],
    ),
    StatefulShellBranch(
      routes: [
        GoRoute(
          name: AppRoute.worker.name,
          path: 'worker',
          builder: (context,state) => Container(color: Colors.red.shade300,child: Text('worker')),
        ),
      ],
    ),
    StatefulShellBranch(
      routes: [
        GoRoute(
          name: AppRoute.admin.name,
          path: 'admin',
          builder: (context,state) => Container(color: Colors.red.shade300,child: Text('admin')),
        ),
      ],
    ),
    StatefulShellBranch(
      routes: [
        GoRoute(
          name: AppRoute.history.name,
          path: 'history',
          builder: (context,state) => HistoryScreen(),
        ),
      ],
    ),
    StatefulShellBranch(
      routes: [
        GoRoute(
          name: AppRoute.profile.name,
          path: 'profile',
          builder: (context,state) => const ProfileScreen(),
          routes: [
            GoRoute(
              name: AppRoute.changeLanguage.name,
              path: 'change-language',
              parentNavigatorKey: _rootNavigatorKey,
              pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
                context: context,
                state: state,
                child: const ChangeLanguageScreen(),
              ),
            ),
            GoRoute(
              name: AppRoute.changeRole.name,
              path: 'change-role',
              parentNavigatorKey: _rootNavigatorKey,
              pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
                context: context,
                state: state,
                child: const ChangeRoleScreen(),
              ),
            ),
          ]
        ),
      ],
    ),
  ];
}

final goRouterProvider = Provider((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    redirect: (context,state) {

      final path = state.location;

      var authChangeEvent = ref.read(currentAuthChangeEventProvider);
      //var currentUserRoleCompany = ref.read(currentUserRoleCompanyProvider);

      /*print('\n\n');
      print(' % & % & authChangeEvent -> ${authChangeEvent.toString()}');
      print(' % & % & currentUserRoleCompany -> ${currentUserRoleCompany.toString()}');
      print('\n\n');*/

      print('path -> ${path}');

      if(authChangeEvent == AuthChangeEvent.signedOut){
        if(path == '/' || path == '/profile' || path == '/password-recovery'){
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
    refreshListenable: GoRouterRefreshStream(
      Rx.combineLatest2(
        RefreshService(ref).outputStream,
        RefreshService(ref).outputStreamSecond,
        (a, b) {
          print('\n\n');
          print('a -> ${a.toString()}');
          print('b -> ${b.toString()}');
          print('\n\n');
        }
      )
    ),
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
              child: const EmailConfirmationScreen(),
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
            branches: branches()
          ),
        ]
      ),
    ],
    errorBuilder: (context,state) => const NotFoundScreen()
  );
});


