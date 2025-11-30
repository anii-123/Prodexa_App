import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../pages/main_navigation_page.dart';

import '../pages/create_task_page.dart';
import '../pages/edit_profile_page.dart';

import '../pages/splash_screen.dart';
import '../pages/onboarding_page.dart';
import '../pages/login_page.dart';
import '../pages/signup_page.dart';
import '../pages/forgot_password_page.dart';

import '../pages/pro_features_page.dart';
import '../pages/help_support_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

class AppRouter {
  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/splash',
    routes: <RouteBase>[
      GoRoute(
        path: '/splash',
        builder: (BuildContext context, GoRouterState state) =>
            const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (BuildContext context, GoRouterState state) =>
            const OnboardingPage(),
      ),
      GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) =>
            const LoginPage(),
      ),
      GoRoute(
        path: '/signup',
        builder: (BuildContext context, GoRouterState state) =>
            const SignupPage(),
      ),
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) =>
            const MainNavigationPage(),
      ),
      GoRoute(
        path: '/create-task',
        builder: (BuildContext context, GoRouterState state) =>
            const CreateTaskPage(),
      ),
      GoRoute(
        path: '/edit-profile',
        builder: (BuildContext context, GoRouterState state) =>
            const EditProfilePage(),
      ),
      GoRoute(
        path: '/pro-features',
        builder: (BuildContext context, GoRouterState state) =>
            const ProFeaturesPage(),
      ),
      GoRoute(
        path: '/help-support',
        builder: (BuildContext context, GoRouterState state) =>
            const HelpSupportPage(),
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (BuildContext context, GoRouterState state) =>
            const ForgotPasswordPage(),
      ),
    ],
  );
}

