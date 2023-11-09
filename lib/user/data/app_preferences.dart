import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:verve/user/presentation/connexion.dart';

const String APP_PREFS_KEY = "APP_PREFS_KEY";
const String SYNDIC = "OnBoardingViewScreenViewed";
const String USER = "UserLoggedInSuccesFully";

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<void> setConnexionSyndicScreenViewed() async {
    _sharedPreferences.setBool(SYNDIC, true);
  }

  Future<bool> isConnexionSyndicScreenViewed() async {
    return _sharedPreferences.getBool(SYNDIC) ?? false;
  }

  Future<void> setConnexionUserLoggedInSuccesFully() async {
    _sharedPreferences.setBool(USER, true);
  }

  Future<bool> isConnexionUserLoggedInSuccesFully() async {
    return _sharedPreferences.getBool(USER) ?? false;
  }

  Future<void> logout() async {
    _sharedPreferences.remove(USER);
    _sharedPreferences.remove(SYNDIC);
    Get.offAll(()=>Connexion());
  }
}
