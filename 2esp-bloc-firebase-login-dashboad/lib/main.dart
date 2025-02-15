import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:quirlo/app/app.dart';

import 'core/di/app_dependency_injection.dart';
import 'firebase_options.dart';
import 'shared/services/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  log(dotenv.env['API_KEY'] ?? "Not Find the AQI_API");
  await AppLocalData.initializeAppLocalData();
  await AppDependencyInjection.setUpAppDependency();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const QuirloApp());
}
