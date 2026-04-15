import 'dart:async';

import 'package:auth_flow_demo/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:auth_flow_demo/features/auth/presentation/bloc/auth_state.dart';
import 'package:auth_flow_demo/features/auth/presentation/pages/home_page.dart';
import 'package:auth_flow_demo/features/auth/presentation/pages/login_page.dart';
import 'package:auth_flow_demo/features/auth/presentation/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  final AuthBloc authBloc;

  AppRouter({required this.authBloc});

  GoRouter get router => GoRouter(
    initialLocation: '/splash',
    refreshListenable: GoRouteRefreshStream(authBloc.stream),
    redirect: (context, state) {
      final authState = authBloc.state;

      final isGoingToLogin = state.matchedLocation == '/login';
      final isGoingToSplash = state.matchedLocation == '/splash';

      // if(authState is AuthUnauthenticated || authState is AuthError) {
      //   isGoingToLogin ? null : '/login';
      // } 
      // if(authState is AuthAuthenticated) {
      //   if(isGoingToLogin || isGoingToSplash){
      //     return '/home';
      //   }
      // }
      // return null;
      return '/splash';
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state){
          return const SplashPage();
        },
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) {
          return const LoginPage();
        }
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) {
          return const HomePage();
        }
      ),
    ],

  );

}

class GoRouteRefreshStream extends ChangeNotifier {

  GoRouteRefreshStream(Stream stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final StreamSubscription _subscription;

}