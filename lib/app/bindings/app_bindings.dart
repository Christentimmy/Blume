import 'package:blume/app/controller/auth_controller.dart';
import 'package:blume/app/controller/boost_controller.dart';
import 'package:blume/app/controller/location_controller.dart';
import 'package:blume/app/controller/message_controller.dart';
import 'package:blume/app/controller/socket_controller.dart';
import 'package:blume/app/controller/subscription_controller.dart';
import 'package:blume/app/controller/user_controller.dart';
import 'package:get/get.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(UserController());
    Get.put(LocationController());
    Get.put(MessageController());
    Get.put(SocketController());
    Get.put(SubscriptionController());
    Get.put(BoostController());
  }
}
