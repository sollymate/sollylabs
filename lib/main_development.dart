// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:solly_labs/features/dashboard/presentation/pages/dashboard_ny.dart';
// import 'package:solly_labs/features/user/presentation/pages/login_email_ny.dart';
// import 'package:solly_labs/features/user/presentation/pages/login_otp_ny.dart';
// import 'package:solly_labs/features/user/presentation/pages/splash_screen_ny.dart';
// import 'package:solly_labs/features/widget/presentation/pages/widget_list_page_ny.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
//
// import 'core/constants/supabase_constants_ny.dart';
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   // Load environment variables from .env file
//   await dotenv.load(fileName: ".env.development");
//
//   await Supabase.initialize(
//     url: dotenv.env['SUPABASE_URL']!,
//     anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
//   );
//
//   runApp(
//     ProviderScope(
//       child: MyApp(),
//     ),
//   );
// }
//
// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   late StreamSubscription<AuthState> _authStateSubscription;
//
//   // Define _router here as a member variable of _MyAppState
//   late final GoRouter _router;
//
//   @override
//   void initState() {
//     super.initState();
//     _router = GoRouter(
//       routes: [
//         GoRoute(
//           path: '/',
//           builder: (context, state) => const SplashScreenNy(),
//         ),
//         GoRoute(
//           path: '/login',
//           builder: (context, state) => const LoginEmailNy(),
//         ),
//         GoRoute(
//           path: '/dashboard',
//           builder: (context, state) => const DashboardNy(),
//         ),
//         GoRoute(
//           path: '/login-otp',
//           builder: (context, state) {
//             final email = state.uri.queryParameters['email'];
//             if (email == null) {
//               return const Text('Error: Email is required');
//             }
//             return LoginOtpNy(email: email);
//           },
//         ),
//         GoRoute(
//           path: '/widgets',
//           builder: (context, state) {
//             final args = state.extra as Map<String, dynamic>?;
//             final artBoardId = args?['artBoardId'] as String?;
//
//             if (artBoardId == null) {
//               return const Text('Error: artBoardId is required');
//             }
//
//             return WidgetListPageNy(artBoardId: artBoardId);
//           },
//         ),
//       ],
//     );
//     _setupAuthStateListener();
//   }
//
//   void _setupAuthStateListener() {
//     _authStateSubscription = supabase.auth.onAuthStateChange.listen((data) {
//       final AuthChangeEvent event = data.event;
//       final Session? session = data.session;
//
//       if (event == AuthChangeEvent.signedIn) {
//         _router.go('/dashboard');
//       } else if (event == AuthChangeEvent.signedOut) {
//         _router.go('/login');
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _authStateSubscription.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       title: 'Solly Labs',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
//         useMaterial3: true,
//       ),
//       routerConfig: _router,
//     );
//   }
// }
