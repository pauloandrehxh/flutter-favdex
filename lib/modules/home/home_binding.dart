import 'package:get/get.dart';
import 'home_controller.dart';
import '../../data/providers/poke_api_provider.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PokeApiProvider());
    Get.lazyPut(() => HomeController(Get.find()));
  }
}
