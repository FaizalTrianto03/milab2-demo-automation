import 'package:get/get.dart';
import '../widget/bottom_navbar.dart'; // Import BottomNavbar
import '../modules/home/views/home_view.dart';
import '../modules/left-stuff/views/left_stuff_view.dart';
import '../modules/profile/views/profile_view.dart';
import 'app_routes.dart';

class AppPages {
  // Halaman pertama diarahkan langsung ke BottomNavbar
  static const INITIAL = '/';

  static final routes = [
    GetPage(
      name: '/', // Route utama untuk BottomNavbar
      page: () => const BottomNavbar(),
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => const HomeView(),
    ),
    GetPage(
      name: AppRoutes.LEFT_STUFF,
      page: () => const LeftStuffView(),
    ),
    GetPage(
      name: AppRoutes.PROFILE,
      page: () => const ProfileView(),
    ),
  ];
}
