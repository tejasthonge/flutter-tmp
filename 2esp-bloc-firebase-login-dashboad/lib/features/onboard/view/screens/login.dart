import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/index.dart';
import '../../../../shared/routes/app_router.dart';
import '../../../../shared/widgets/app_sank_bar.dart';
import '../../../index.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailTEC = TextEditingController();
  final TextEditingController passwordTEC = TextEditingController();
  final GlobalKey<FormState> globalKey = GlobalKey();
  @override
  void initState() {
    context.read<OnboardingBloc>().add(OnboardingInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingBloc, OnboardingState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          getAppSankBar(context: context, message: state.message);
          AppRouter.replace(context: context, path: AppPages.home.path);
        } else if (state is LoginErrorState) {
          getAppSankBar(
            context: context,
            message: state.error,
          );
        }
      },
      buildWhen: (previous, current) => current is! OnboardingActionState,
      listenWhen: (previous, current) => current is OnboardingActionState,
      builder: (context, state) {
        if (state is OnboardingLoadingState) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is OnboardingErrorState) {
          return Scaffold(
            body: Center(
              child: Text(state.error),
            ),
          );
        } else if (state is OnboardingSuccessState) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Login"),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: AppDimensions.mediumPadding,
                  horizontal: AppDimensions.mediumPadding),
              child: Form(
                key: globalKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(hintText: "Email"),
                        controller: emailTEC,
                      ),
                      TextFormField(
                        decoration: InputDecoration(hintText: "Password"),
                        controller: passwordTEC,
                      ),
                      SizedBox(
                        height: 300.h,
                      ),
                      TextButton(
                          onPressed: () {
                            context
                                .read<OnboardingBloc>()
                                .add(OnboardingGoogleBTNPressedEvent());
                          },
                          child: Text("Google")),
                    ],
                  ),
                ),
              ),
            ),
            bottomSheet: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                    onPressed: () {
                      context.read<OnboardingBloc>().add(
                          OnboardingLoginBTNPressedEvent(
                              email: emailTEC.text.trim(),
                              password: passwordTEC.text.trim()));
                    },
                    child: Text("Login")),
                TextButton(
                    onPressed: () {
                      AppRouter.push(
                          context: context, path: AppPages.signup.path);
                    },
                    child: Text("Signup"))
              ],
            ),
          );
        } else {
          return Scaffold(
            body: Center(
              child: Text("UnknowinLoginState"),
            ),
          );
        }
      },
    );
  }
}
