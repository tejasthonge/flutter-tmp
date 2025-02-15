import 'dart:developer';

import '../../../../core/index.dart';
import '../../../../shared/services/index.dart';

class ProfileUsecase {
  final FirebaseServices firebaseServices =
      AppDependencyInjection.getIt.get<FirebaseServices>();
  final AppLocalData local = AppDependencyInjection.getIt.get<AppLocalData>();
  getUserDatat() {}

  Future<bool> logOutUser() async {
    try {
      await firebaseServices.firebaseAuth.signOut();
      await local.clearAll();
      return true;
    } catch (e) {
      log("Error for logout :$e");
      return false;
    }
  }
}
