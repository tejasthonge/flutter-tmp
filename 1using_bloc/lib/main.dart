
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:kequele/app/app.dart';

import 'core/di/app_dependency_injection.dart';
import 'firebase_options.dart';
import 'shared/services/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppLocalData.initializeAppLocalData();
  await AppDependencyInjection.setUpAppDependency();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const KequeleApp());
}
