import 'package:flutter/material.dart';
import 'package:rich_chat_copilot/lib/src/presentation/screens/home/home_screen.dart';
import 'package:rich_chat_copilot/lib/src/presentation/screens/settings/settings_screen.dart';
import 'package:rich_chat_copilot/lib/src/presentation/screens/splash/splash_screen.dart';

class Routes {
  static const String splash = "/";
  static const String landing = "/landing";
  static const String signIn = "/signIn";
  static const String homeScreen = "/homeScreen";
  static const String settingsScreen = "/settingsScreen";
}

class RoutesManager {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    print("routeSettings.name: ${routeSettings.name}");
    switch (routeSettings.name) {
      case Routes.splash:
        return _materialRoute(const SplashScreen());
      case Routes.landing:
      //  return _materialRoute(const LandingScreen());
        return _materialRoute(const SplashScreen());
      case Routes.signIn:
        Map<String, dynamic> arg =
            routeSettings.arguments as Map<String, dynamic>;
        //return _materialRoute(SignInScreen());
        return _materialRoute(const SplashScreen());
      case Routes.homeScreen:
        return _materialRoute(const HomeScreen());
      case Routes.settingsScreen:
        return _materialRoute(const SettingsScreen());
      default:
        return _materialRoute(const SplashScreen());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }

  static Route<dynamic> unDefinedRoute(String name) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text("Not found")),
        body: Center(
          child: Text(name),
        ),
      ),
    );
  }
}
