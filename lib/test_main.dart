import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:solly_labs/features/user/presentation/pages/splash_screen_ny.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/constants/supabase_constants_ny.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription<AuthState> _authStateSubscription;

  // Define _router here as a member variable of _MyAppState
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const SplashScreenNy(),
        ),
        GoRoute(
          path: '/login',
          // builder: (context, state) => const LoginEmailNy(),
        ),
        GoRoute(
          path: '/dashboard',
          // builder: (context, state) => const DashboardNy(),
        ),
        GoRoute(
          path: '/login-otp',
          builder: (context, state) {
            final email = state.uri.queryParameters['email']; // Access query parameters from uri
            if (email == null) {
              return const Text('Error: Email is required');
            }
            return const Text('ABC');
            // return LoginOtpNy(email: email);
          },
        ),
        GoRoute(
          path: '/widgets',
          builder: (context, state) {
            final args = state.extra as Map<String, dynamic>?;
            final artBoardId = args?['artBoardId'] as String?;

            if (artBoardId == null) {
              return const Text('Error: artBoardId is required');
            }

            return const Text('AB');
            // return WidgetListPageNy(artBoardId: artBoardId);
          },
        ),
      ],
    );
    _setupAuthStateListener();
  }

  void _setupAuthStateListener() {
    _authStateSubscription = supabase.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent event = data.event;
      final Session? session = data.session;

      if (event == AuthChangeEvent.signedIn) {
        _router.go('/dashboard');
      } else if (event == AuthChangeEvent.signedOut) {
        _router.go('/login');
      }
    });
  }

  @override
  void dispose() {
    _authStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Solly Labs',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      routerConfig: _router, // Use the _router instance here
    );
  }
}
