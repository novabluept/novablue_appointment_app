import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:novablue_appointment_app/src/routing/app_routing.dart';
import '../../../../main.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    _redirect();
  }

  Future<void> _redirect() async {
    /*await Future.delayed(Duration.zero);
    if (!mounted) {
      return;
    }

    final session = supabase.auth.currentSession;
    if (session != null) {
      context.goNamed(AppRoute.home.name);
    } else {
      context.goNamed(AppRoute.login.name);
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}