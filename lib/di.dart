import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:verve/user/data/app_preferences.dart';

final instance = Get.put(GetIt.I);

Future<void> initAppModule() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  instance.registerLazySingleton(() => sharedPreferences);

  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));}