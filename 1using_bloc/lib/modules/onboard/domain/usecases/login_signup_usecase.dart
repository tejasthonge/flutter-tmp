

import 'package:kequele/core/di/app_dependency_injection.dart';
import 'package:kequele/shared/services/index.dart';

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

  Future<String> loginWithEmailPassword({required String email, required String password}) async {
    String result = '';
    result = await firebaseServices.loginWithEmailPassword(email, password);
    return result;
  }

  Future <String> googleLoginSingup()async{
    String result='';
    result =await firebaseServices.signInWithGoogle();
    return result;
  }
}
