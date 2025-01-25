
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kequele/app/base/view/screens/basic_page.dart';
import 'package:kequele/app/index.dart';
import 'package:kequele/modules/onboard/bloc/onboarding_bloc.dart';

import '../modules/index.dart';
import '../shared/routes/index.dart';

class KequeleApp extends StatelessWidget {
  const KequeleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder: (context, child) => MultiBlocProvider(
        providers: [

          BlocProvider(create: (context) => AppBloc()),
          BlocProvider(create: (context) => OnboardingBloc()),
          BlocProvider(create: (context) => DashboardBloc()),

          // BlocProvider(create: (context) => ProfileBloc()),
        ],
        child: MaterialApp.router(
          routerConfig: AppRouter.router,
          // theme: AppTheme.lite,
        ),
      ),
    );
  }
}