import 'package:flutter/animation.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:verve/splash_screen.dart';
import 'package:verve/syndic/pr%C3%A9sentaion/connexion.dart';

import '../presentation/connexion.dart';
import '../presentation/parrainage.dart';
import '../presentation/services.dart';

class RouteManager {
  static const splash = "/";
  static const connexion = "/connexion";
  static const parrainage = "/parrainage";
  static const service = "/service";
  static const syndic = "/syndic";

  static List<GetPage> routes = [
    GetPage(
        name: splash,
        page: () => const SplashScreen(),
        curve: Curves.bounceInOut),
    GetPage(
        name: connexion,
        page: () => const Connexion(),
        curve: Curves.bounceInOut),
    GetPage(
        name: parrainage,
        page: () => const Parrainage(),
        curve: Curves.bounceInOut),
    GetPage(
        name: service, page: () => const Services(), curve: Curves.bounceInOut),
    GetPage(
        name: syndic,
        page: () => const ConnexionSyndic(),
        curve: Curves.bounceInOut),
  ];
}
