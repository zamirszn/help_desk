import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:helpdesk/presentation/ui/admin/admin_dashboard.dart';
import 'package:helpdesk/presentation/ui/auth/login_or_register_page.dart';
import 'package:helpdesk/presentation/ui/auth/login/login_page.dart';
import 'package:helpdesk/presentation/ui/auth/sign_up/sign_up_page.dart';
import 'package:helpdesk/presentation/ui/customer/customer_tickets_screen.dart';
import 'package:helpdesk/presentation/ui/onboarding/onboarding_screen.dart';
import 'package:helpdesk/presentation/ui/support_agent/support_agent_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: Routes.onboardingPage,
  debugLogDiagnostics: kDebugMode,
  routes: [
    GoRoute(
      path: Routes.onboardingPage,
      builder: (context, state) => const LiquidSwipeOnboarding(),
    ),
    GoRoute(
      path: Routes.loginOrRegisterPage,
      builder: (context, state) => const LoginOrRegisterPage(),
    ),
    GoRoute(
      path: Routes.loginPage,
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      path: Routes.signUpPage,
      builder: (context, state) => SignUpPage(),
    ),
    GoRoute(
      path: Routes.adminDashBoard,
      builder: (context, state) => const AdminDashboardScreen(),
    ),
    GoRoute(
      path: Routes.supportPage,
      builder: (context, state) => const SupportAgentScreen(),
    ),
    GoRoute(
      path: Routes.customerPage,
      builder: (context, state) => const CustomerTicketsScreen(),
    ),
  ],
  // errorBuilder: (context, state) => const Error404Page(),
);

class Routes {
  static const String onboardingPage = "/onboardingPage";
  static const String supportPage = "/supportPage";
  static const String customerPage = "/customerPage";
  static const String adminDashBoard = "/adminDashBoard";
  static const String loginPage = "/loginPage";
  static const String signUpPage = "/signUpPage";
  static const String loginOrRegisterPage = "/loginOrRegisterPage";
}

Future<void> goPush(BuildContext context, String routeName,
    {Object? extra}) async {
  context.push(
    routeName,
    extra: extra,
  );
}

void goto(BuildContext context, String routeName, {Object? extra}) {
  context.go(routeName, extra: extra);
}

void goPopRoute(
  BuildContext context,
) {
  GoRouter.of(context).pop();
}
