
import 'package:cloud_task/home/presentation/controller/app_controller.dart';
import 'package:cloud_task/home/presentation/controller/home_controller.dart';
import 'package:cloud_task/home/presentation/screens/home_screen.dart';
import 'package:get/get.dart';

List<GetPage> appPages = [
  GetPage(
      name: '/',
      page: () => const HomeScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(()=>HomeController());
        Get.put(AppSettingsController(), permanent: true);
        
      }))
];
