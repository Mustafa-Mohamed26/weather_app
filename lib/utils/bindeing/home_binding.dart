import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get.dart';
import 'package:weather_app/controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  ///
  /// Binds the HomeController to the alexandria city.
  ///
  void dependencies() {
    Get.lazyPut(() => HomeController(city: 'alexandria'));
  }
}
