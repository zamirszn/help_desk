import 'package:flutter/material.dart';
import 'package:helpdesk/core/constants/constant.dart';
import 'package:helpdesk/presentation/resources/routes_manager.dart';
import 'package:helpdesk/core/config/theme/theme_manager.dart';

void main() {
  runApp(const HelpDesk());
}

class HelpDesk extends StatelessWidget {
  const HelpDesk({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: appRouter.routerDelegate,
      routeInformationProvider: appRouter.routeInformationProvider,
      routeInformationParser: appRouter.routeInformationParser,
      theme: AppTheme.appTheme,
      title: Constant.appName,
    );
  }
}
