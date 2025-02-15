

import '../../../../core/di/app_dependency_injection.dart';

import '../../../../shared/services/index.dart';

class LoginSignupUsecase {
  final AppLocalData local = AppDependencyInjection.getIt.get<AppLocalData>();
  final FirebaseServices firebaseServices =
      AppDependencyInjection.getIt.get<FirebaseServices>();
  Future<String> singupUserWithEmailAndPassword(
      {required String email, required String password}) async {
    String result = '';
    result = await firebaseServices.signUpWithEmailPassword(email, password);
    return result;
  }

  Future<String> loginWithEmailPassword(
      {required String email, required String password}) async {
    String result = '';
    result = await firebaseServices.loginWithEmailPassword(email, password);
    return result;
  }

  Future<String> googleLoginSingup() async {
    String result = '';
    result = await firebaseServices.signInWithGoogle();
    return result;
  }

  Future<String> storeUserInfo({
    required String uid,
    required String name,
    required String email,
    required String password,
  }) async {
    // Create a map of user information
    String result = '';
    Map<String, dynamic> userInfo = {
      'name': name,
      'email': email,
      'password': password,
      'uid': uid,
    };
    result =
        await firebaseServices.storeUserData(userId: uid, userData: userInfo);
    return result;
  }
}
