
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:novablue_appointment_app/src/features/appointments_schedule/presentation/appointments_history/appointments_history_screen.dart';
import 'package:novablue_appointment_app/src/features/appointments_schedule/presentation/book_appointment/book_appointment_workers_list/book_appointment_workers_list_screen.dart';
import 'package:novablue_appointment_app/src/features/authentication/presentation/change_role/change_role_screen.dart';
import 'package:novablue_appointment_app/src/features/authentication/presentation/email_confirmation/email_confirmation_screen.dart';
import 'package:novablue_appointment_app/src/features/authentication/presentation/login/login_screen.dart';
import 'package:novablue_appointment_app/src/features/authentication/presentation/password/create_password/create_password_screen.dart';
import 'package:novablue_appointment_app/src/features/authentication/presentation/password/forgot_password/forgot_password_screen.dart';
import 'package:novablue_appointment_app/src/features/authentication/presentation/password/password_recovery/password_recovery_screen.dart';
import 'package:novablue_appointment_app/src/features/authentication/presentation/password/update_password/update_password_screen.dart';
import 'package:novablue_appointment_app/src/features/authentication/presentation/personal_data/create_personal_data/create_personal_data_screen.dart';
import 'package:novablue_appointment_app/src/features/authentication/presentation/personal_data/update_personal_data/update_personal_data_screen.dart';
import 'package:novablue_appointment_app/src/features/authentication/presentation/profile/profile_screen.dart';
import 'package:novablue_appointment_app/src/features/language/change_language/change_language_screen.dart';
import 'package:novablue_appointment_app/src/features/shops/presentation/shops_slidable_list/shops_slidable_list_screen.dart';
import 'package:novablue_appointment_app/src/routing/not_found_screen.dart';
import 'package:novablue_appointment_app/src/routing/refresh_service/refresh_service_provider.dart';
import 'package:novablue_appointment_app/src/routing/scaffold_with_nested_navigation/scaffold_with_nested_navigation.dart';
import 'package:novablue_appointment_app/src/routing/refresh_service/refresh_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:novablue_appointment_app/src/features/appointments_schedule/presentation/book_appointment/book_appointment_worker_services_list/book_appointment_worker_services_screen.dart';
import 'go_router_refresh_stream.dart';

CustomTransitionPage buildScreenWithDefaultTransition<T>({
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

CustomTransitionPage buildScreenBottomToTopTransition<T>({
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
              begin: const Offset(0, 1), // Change this line
              end: Offset.zero,
            ).chain(CurveTween(curve: Curves.easeIn)),
          ),
          child: child,
        ),
  );
}

enum AppRoute{
  admin, // temp
  worker, // temp
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
  updatePassword,
  updatePersonalData,
  shopWorkers,
  shopWorkerServices,
}

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _tabANavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'tabANav');
final GlobalKey<NavigatorState> _tabBNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'tabBNav');
final GlobalKey<NavigatorState> _tabCNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'tabCNav');
final GlobalKey<NavigatorState> _tabDNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'tabDNav');
final GlobalKey<NavigatorState> _tabENavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'tabENav');

List<StatefulShellBranch> branches(){

  return [
    StatefulShellBranch(
      navigatorKey: _tabANavigatorKey,
      routes: [
        GoRoute(
          name: AppRoute.home.name,
          path: 'home',
          builder: (context,state) => ShopsSlidableListScreen(),
          routes: [
            GoRoute(
              parentNavigatorKey: _rootNavigatorKey,
              name: AppRoute.shopWorkers.name,
              path: 'shop/:shopId/workers',
              pageBuilder: (context, state) {
                final shopId = state.pathParameters['shopId']!;
                final extra = state.extra as Map<String,String>;
                final shopName = extra['shopName']!;
                return buildScreenBottomToTopTransition<void>(
                  context: context,
                  state: state,
                  child: BookAppointmentWorkersListScreen(shopId: shopId,shopName: shopName),
                );
              },
              routes: [
                GoRoute(
                  parentNavigatorKey: _rootNavigatorKey,
                  name: AppRoute.shopWorkerServices.name,
                  path: 'worker/:workerId/services',
                  pageBuilder: (context, state) {
                    final workerId = state.pathParameters['workerId']!;
                    return buildScreenWithDefaultTransition<void>(
                      context: context,
                      state: state,
                      child: BookAppointmentWorkerServicesScreen(workerId: workerId) /*ShopWorkersScreen(shopId: workerId)*/,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    StatefulShellBranch(
      navigatorKey: _tabBNavigatorKey,
      routes: [
        GoRoute(
          name: AppRoute.worker.name,
          path: 'worker',
          builder: (context,state) => Container(color: Colors.red.shade300,child: Text('worker')),
        ),
      ],
    ),
    StatefulShellBranch(
      navigatorKey: _tabCNavigatorKey,
      routes: [
        GoRoute(
          name: AppRoute.admin.name,
          path: 'admin',
          builder: (context,state) => Container(color: Colors.red.shade300,child: Text('admin')),
        ),
      ],
    ),
    StatefulShellBranch(
      navigatorKey: _tabDNavigatorKey,
      routes: [
        GoRoute(
          name: AppRoute.history.name,
          path: 'history',
          builder: (context,state) => AppointmentsHistoryScreen(),
        ),
      ],
    ),
    StatefulShellBranch(
      navigatorKey: _tabENavigatorKey,
      routes: [
        GoRoute(
          name: AppRoute.profile.name,
          path: 'profile',
          builder: (context,state) => const ProfileScreen(),
          routes: [
            GoRoute(
              name: AppRoute.updatePersonalData.name,
              path: 'update-personal-data',
              parentNavigatorKey: _rootNavigatorKey,
              pageBuilder: (context, state) => buildScreenWithDefaultTransition<void>(
                context: context,
                state: state,
                child: const UpdatePersonalDataScreen(),
              ),
            ),
            GoRoute(
              name: AppRoute.updatePassword.name,
              path: 'update-password',
              parentNavigatorKey: _rootNavigatorKey,
              pageBuilder: (context, state) => buildScreenWithDefaultTransition<void>(
                context: context,
                state: state,
                child: const UpdatePasswordScreen(),
              ),
            ),
            GoRoute(
              name: AppRoute.changeLanguage.name,
              path: 'change-language',
              parentNavigatorKey: _rootNavigatorKey,
              pageBuilder: (context, state) => buildScreenWithDefaultTransition<void>(
                context: context,
                state: state,
                child: const ChangeLanguageScreen(),
              ),
            ),
            GoRoute(
              name: AppRoute.changeRole.name,
              path: 'change-role',
              parentNavigatorKey: _rootNavigatorKey,
              pageBuilder: (context, state) => buildScreenWithDefaultTransition<void>(
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

      final path = state.matchedLocation;
      debugPrint('path -> ${path}');
      print('state.extra: ${state.extra}');
      var authChangeEvent = ref.read(currentAuthChangeEventProvider);

      if(authChangeEvent == AuthChangeEvent.signedOut){
        if(path == '/' || path == '/profile' || path == '/password-recovery' || path == '/profile/update-password'){
          return '/';
        }
      }else if(authChangeEvent == AuthChangeEvent.passwordRecovery){
        return '/password-recovery';
      }/*else if(authChangeEvent == AuthChangeEvent.userUpdated){
        if(path == '/profile/update-password'){
          return '/';
        }
      }*/else if(authChangeEvent == AuthChangeEvent.signedIn){
        if(path == '/'){
          return '/home';
        }
      }

      return null;
    },
    refreshListenable: GoRouterRefreshStream(
      Rx.combineLatest2(
        RefreshService(ref).userRoleStream,
        RefreshService(ref).eventStream,
        (a, b) {
          /*debugPrint('\n\n');
          debugPrint('a -> ${a.toString()}');
          debugPrint('b -> ${b.toString()}');
          debugPrint('\n\n');*/
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
            pageBuilder: (context, state) => buildScreenWithDefaultTransition<void>(
              context: context,
              state: state,
              child: const ForgotPasswordScreen(),
            ),
          ),
          GoRoute(
            name: AppRoute.passwordRecovery.name,
            path: 'password-recovery',
            pageBuilder: (context, state) => buildScreenWithDefaultTransition<void>(
              context: context,
              state: state,
              child: const PasswordRecoveryScreen(),
            ),
          ),
          GoRoute(
            name: AppRoute.confirmEmail.name,
            path: 'confirm-email',
            pageBuilder: (context, state) => buildScreenWithDefaultTransition<void>(
              context: context,
              state: state,
              child: const EmailConfirmationScreen(),
            ),
          ),
          GoRoute(
            name: AppRoute.register.name,
            path: 'register',
            pageBuilder: (context, state) => buildScreenWithDefaultTransition<void>(
              context: context,
              state: state,
              child: const CreatePersonalDataScreen(),
            ),
            routes: [
              GoRoute(
                name: AppRoute.createPassword.name,
                path: 'create-password',
                pageBuilder: (context, state) {
                  CreatePasswordScreenArguments args = state.extra as CreatePasswordScreenArguments;
                  return buildScreenWithDefaultTransition<void>(
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


