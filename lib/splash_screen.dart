import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:verve/syndic/pr%C3%A9sentaion/list_reclamation_syndic.dart';
import 'package:verve/user/data/app_preferences.dart';
import 'package:verve/user/presentation/connexion.dart';
import 'package:verve/user/presentation/services.dart';

import 'di.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;
  AppPreferences _appPreferences = instance<AppPreferences>();

  _startDelay() {
    _timer = Timer(Duration(seconds: 2), _goNext);
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child:  Center(
            child: Image(image: AssetImage("assets/logo.png"),width: 200.w,height: 200.h,),
          ),
        ));
  }

  _goNext() async {
    _appPreferences
        .isConnexionUserLoggedInSuccesFully()
        .then((isUserLoggedIn) => {
              if (isUserLoggedIn)
                {Get.off(Services())}
              else
                {
                  _appPreferences
                      .isConnexionSyndicScreenViewed()
                      .then((isConnexionSyndic) => {
                            if (isConnexionSyndic)
                              {Get.off(ListeReclamationSyndic())}
                            else
                              {Get.off(Connexion())}
                          })
                }
            });
  }
}
