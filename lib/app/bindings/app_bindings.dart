
import 'package:blume/app/controller/storage_controller.dart';
import 'package:get/get.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(() => StorageController());
  }
}
