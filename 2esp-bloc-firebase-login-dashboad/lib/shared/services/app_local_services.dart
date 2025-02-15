import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLocalData {
  static SharedPreferences? sharedPreferences;
  final ValueNotifier<String?> firebaseUidNotifier =
      ValueNotifier<String?>(null);

  static Future<void> initializeAppLocalData() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> clearAll() async {
    await sharedPreferences!.clear();
    firebaseUidNotifier.value = await getFirebaseUid();
  }

  Future<void> setSqlId({required int id}) async {
    log("in local set sql id $id");
    await sharedPreferences!.setInt('sqlId', id);
  }

  int? getGetSql() {
    return sharedPreferences!.getInt('sqlId');
  }

  Future<void> setVerificationId({required String verificationId}) async {
    await sharedPreferences!.setString('verificationId', verificationId);
  }

  String? getVerificationId() {
    return sharedPreferences!.getString('verificationId');
  }

  Future<void> setFirebaseUid({required String uid}) async {
    await sharedPreferences!.setString('firebaseUid', uid);
    firebaseUidNotifier.value = uid;
  }

  Future<String?> getFirebaseUid() async {
    return sharedPreferences!.getString('firebaseUid');
  }

  Future<ValueNotifier<String?>> getFirebaseUidStreem() async {
    firebaseUidNotifier.value = await getFirebaseUid();
    log(firebaseUidNotifier.value.toString());
    return firebaseUidNotifier;
  }

  Future<void> clearFirebaseUid() async {
    await sharedPreferences!.remove('firebaseUid');
    log(firebaseUidNotifier.value.toString());
    firebaseUidNotifier.value = await getFirebaseUid();
  }
}
