import 'package:get_it/get_it.dart';
import '../../features/index.dart';
import '../../shared/services/index.dart';

class AppDependencyInjection {
  static final getIt = GetIt.instance;

  static Future<void> setUpAppDependency() async {
    _getAppLocalData();
    _getFirebaseServices();
    _getPermissionService();
    
    _getAppWifiProvisioningServices(); 

    _getLoginSignupUsecase();
    _getProfileUsecase();
    _getWifiProvisioningUsecase();  
    }

  static void _getPermissionService() {
    getIt.registerLazySingleton(PermissionService.new);
  }

  static void _getFirebaseServices() {
    getIt.registerLazySingleton(FirebaseServices.new);
  }
  
   static void _getAppWifiProvisioningServices() {
    // getIt.registerLazySingleton(ApppWifiProvService.new);
  }

  static void _getAppLocalData() {
    getIt.registerLazySingleton(AppLocalData.new);
  }

//usercase
  static void _getLoginSignupUsecase() {
    getIt.registerLazySingleton(LoginSignupUsecase.new);
  }
  static void _getProfileUsecase() {
    getIt.registerLazySingleton(ProfileUsecase.new);
  }
  static void _getWifiProvisioningUsecase() {
    getIt.registerLazySingleton(WifiProvisioningUsecase.new);
  }

  // static void _getOnboardUsecase() {
  //   getIt.registerLazySingleton(OnboardUsecase.new);
  // }
}
