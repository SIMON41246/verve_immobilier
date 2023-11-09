import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:verve/bindings.dart';
import 'package:verve/di.dart';
import 'package:verve/user/resources/route_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: GetMaterialApp(
        theme: ThemeData(
            splashColor: Colors.green,
            disabledColor: Colors.grey.shade500,
            primaryColor: const Color.fromRGBO(82, 190, 66, 1),
            buttonTheme: ButtonThemeData(
                disabledColor: Colors.grey.shade300,
                buttonColor: Color.fromRGBO(82, 190, 66, 1),
                splashColor: Color.fromRGBO(82, 190, 66, 1))),
        debugShowCheckedModeBanner: false,
        getPages: RouteManager.routes,
        initialBinding: AppBinding(),
        initialRoute: "/",
      ),
    );
  }
}
