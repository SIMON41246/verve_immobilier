import 'package:get/get.dart';
import 'package:verve/di.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    initAppModule();
  }
}
