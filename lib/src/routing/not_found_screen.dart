import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/app_sizes.dart';
import 'app_routing.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      //body: Text('404 - Page not found!'),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.s16),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '404 - Page not found!',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              gapH32,
              TextButton(
                onPressed: () => context.goNamed(AppRoute.splash.name),
                child: Text(
                'Go Home',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}