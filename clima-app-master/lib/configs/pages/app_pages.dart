import 'package:clima_app/configs/pages/app_routes.dart';
import 'package:clima_app/modules/dependencies/accounts_dependency.dart';
import 'package:clima_app/modules/dependencies/auth_dependency.dart';
import 'package:clima_app/modules/dependencies/dashboard_dependency.dart';
import 'package:clima_app/modules/dependencies/folders_dependency.dart';
import 'package:clima_app/modules/features/accounts/profile_page.dart';
import 'package:clima_app/modules/features/auth/login_page.dart';
import 'package:clima_app/modules/features/auth/option_menu_page.dart';
import 'package:clima_app/modules/features/dashboard/dashboard_page.dart';
import 'package:clima_app/modules/features/folders/new_file_page.dart';
import 'package:clima_app/modules/features/folders/new_folder_page.dart';
import 'package:clima_app/modules/features/splash/splash_page.dart';
import 'package:get/get_navigation/get_navigation.dart';

class AppPages {
  AppPages._();

  static List<GetPage> pages() => [
        GetPage(
          name: AppRoutes.splash,
          page: () => const SplashPage(),
          binding: AuthDependency(),
        ),
        GetPage(
          name: AppRoutes.login,
          page: () => const LoginPage(),
          binding: AuthDependency(),
        ),
        GetPage(
          name: AppRoutes.optionMenu,
          page: () => const OptionMenuPage(),
          binding: AuthDependency(),
        ),
        GetPage(
          name: AppRoutes.dashboard,
          page: () => const DashboardPage(),
          binding: DashboardDependency(),
        ),
        GetPage(
          name: AppRoutes.newFile,
          page: () => const NewFilePage(),
          binding: FoldersDependency(),
        ),
        GetPage(
          name: AppRoutes.newFolder,
          page: () => const NewFolderPage(),
          binding: FoldersDependency(),
        ),
        GetPage(
          name: AppRoutes.profile,
          page: () => const ProfilePage(),
          binding: AccountsDependency(),
        ),
      ];
}
