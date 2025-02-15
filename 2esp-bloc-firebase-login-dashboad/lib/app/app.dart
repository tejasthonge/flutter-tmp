
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../features/index.dart';
import '../shared/routes/index.dart';

class QuirloApp extends StatelessWidget {
  const QuirloApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => OnboardingBloc()),
          BlocProvider(create: (context) => DashboardBloc()),
          BlocProvider(create: (context) => ProfileBloc()),
          BlocProvider(create: (context) => WifiProvisingBloc()),
          // BlocProvider(create: (context) => EspProvisioningBloc()),
        ],
        child: MaterialApp.router(
          routerConfig: AppRouter.router,
        ),
      ),
    );
  }
}
