import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kequele/modules/home/view/screens/demo.dart';

import '../../core/di/app_dependency_injection.dart';
import '../../modules/index.dart';
import '../services/index.dart';

final AppLocalData localData = AppDependencyInjection.getIt.get<AppLocalData>();

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

class AppPage {
  final String path;
  final String name;
  const AppPage({
    required this.path,
    required this.name,
  });
}

class AppPages {
  static const splash = AppPage(path: "/splash", name: "Splash");
  static const login = AppPage(path: "/login", name: "Login");
  static const signup = AppPage(path: "/signup", name: "Signup");
  static const home = AppPage(path: "/", name: "Dashboard");
  static const devices = AppPage(path: "/devices", name: "Devices");
  static const profile = AppPage(path: "/profile", name: "Profile");

  static const demo = AppPage(path: "/demo", name: "Demo");
}

class AppRouter {
  static void push({
    required BuildContext context,
    required String path,
    dynamic extra,
  }) {
    if (GoRouter.of(context).routerDelegate.state!.uri.toString() == path) {
      return;
    }
    context.push(path, extra: extra);
  }

  static void go({
    required BuildContext context,
    required String path,
    dynamic extra,
  }) {
    if (GoRouter.of(context).routerDelegate.state!.uri.toString() == path) {
      return;
    }
    context.go(path, extra: extra);
  }

  static void replace({
    required BuildContext context,
    required String path,
    dynamic extra,
  }) {
    if (GoRouter.of(context).routerDelegate.state!.uri.toString() == path) {
      return;
    }
    context.replace(path, extra: extra);
  }

  static final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppPages.splash.path,
    routes: [
      GoRoute(
        name: AppPages.splash.name,
        path: AppPages.splash.path,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: AppPages.login.name,
        path: AppPages.login.path,
        builder: (context, state) => const Login(),
      ),
      GoRoute(
        name: AppPages.signup.name,
        path: AppPages.signup.path,
        builder: (context, state) => const Signup(),
      ),
      GoRoute(
        name: AppPages.demo.name,
        path: AppPages.demo.path,
        builder: (context, state) => const MyScreen(),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => Dashboard(child: child),
        routes: [
          GoRoute(
            path: AppPages.home.path,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: Home()),
          ),
          GoRoute(
            path: AppPages.devices.path,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: Divices()),
          ),
          GoRoute(
            path: AppPages.profile.path,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: Profile()),
          ),
        ],
      ),
    ],
    redirect: (context, state) async {
      final firebaseUidStream = await localData.getFirebaseUidStreem();
      log(firebaseUidStream.value.toString());

      if (firebaseUidStream.value == null) {
        if (state.uri.toString() == AppPages.profile.path) {
          return AppPages.splash.path;
        }
      } else if (state.uri.toString() == AppPages.splash.path) {
        return AppPages.home.path;
      }
      return null;
    },
  );
}
