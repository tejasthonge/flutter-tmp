import 'package:get_it/get_it.dart';
import '../../modules/index.dart';
import '../../shared/services/index.dart';

class AppDependencyInjection {
  static final getIt = GetIt.instance;

  static Future<void> setUpAppDependency() async {
    _getAppLocalData();
    _getFirebaseServices();
    _getPermissionService();

    _getLoginSignupUsecase();
  }

  static void _getPermissionService() {
    getIt.registerLazySingleton(PermissionService.new);
  }

  static void _getFirebaseServices() {
    getIt.registerLazySingleton(FirebaseServices.new);
  }

  static void _getAppLocalData() {
    getIt.registerLazySingleton(AppLocalData.new);
  }

//usercase
  static void _getLoginSignupUsecase() {
    getIt.registerLazySingleton(LoginSignupUsecase.new);
  }

  // static void _getOnboardUsecase() {
  //   getIt.registerLazySingleton(OnboardUsecase.new);
  // }
}
