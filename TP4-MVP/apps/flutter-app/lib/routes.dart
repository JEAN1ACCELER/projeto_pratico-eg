import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../pages/splash_page.dart';
import '../pages/login_page.dart';
import '../pages/register_page.dart';
import '../pages/home_page.dart';
import '../pages/profile_page.dart';
import '../pages/list_page.dart';
import '../pages/details_page.dart';
import '../pages/form_page.dart';
import '../providers/auth_provider.dart';
import '../utils/constants.dart';

/// Configuração de rotas declarativas com GoRouter.
class AppRouter {
  AppRouter._();

  static GoRouter createRouter(BuildContext context) {
    return GoRouter(
      initialLocation: AppConstants.splashRoute,
      redirect: (context, state) {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        final isLoggedIn = authProvider.isAuthenticated;
        final isGoingToLogin = state.matchedLocation == AppConstants.loginRoute;
        final isGoingToRegister = state.matchedLocation == AppConstants.registerRoute;
        final isGoingToSplash = state.matchedLocation == AppConstants.splashRoute;

        // Permite acesso à splash sem autenticação
        if (isGoingToSplash) return null;

        // Redireciona para login se não autenticado
        if (!isLoggedIn && !isGoingToLogin && !isGoingToRegister) {
          return AppConstants.loginRoute;
        }

        // Redireciona para home se já autenticado e tentando acessar login
        if (isLoggedIn && (isGoingToLogin || isGoingToRegister)) {
          return AppConstants.homeRoute;
        }

        return null;
      },
      routes: [
        GoRoute(
          path: AppConstants.splashRoute,
          builder: (context, state) => const SplashPage(),
        ),
        GoRoute(
          path: AppConstants.loginRoute,
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: AppConstants.registerRoute,
          builder: (context, state) => const RegisterPage(),
        ),
        GoRoute(
          path: AppConstants.homeRoute,
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: AppConstants.profileRoute,
          builder: (context, state) => const ProfilePage(),
        ),
        GoRoute(
          path: AppConstants.listRoute,
          builder: (context, state) => const ListPage(),
        ),
        GoRoute(
          path: AppConstants.detailsRoute,
          builder: (context, state) {
            final donationId = state.extra as String?;
            return DetailsPage(donationId: donationId ?? '');
          },
        ),
        GoRoute(
          path: AppConstants.formRoute,
          builder: (context, state) {
            final donationId = state.extra as String?;
            return FormPage(donationId: donationId);
          },
        ),
      ],
    );
  }
}
