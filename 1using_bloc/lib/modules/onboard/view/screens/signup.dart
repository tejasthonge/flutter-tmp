import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kequele/core/styles/app_dimensions.dart';
import 'package:kequele/modules/onboard/bloc/onboarding_bloc.dart';
import 'package:kequele/shared/routes/index.dart';
import 'package:kequele/shared/widgets/app_sank_bar.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController nameTEC = TextEditingController();
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
        if (state is SignupSuccessState) {
          getAppSankBar(context: context, message: state.message);
          AppRouter.replace(context: context, path: AppPages.login.path);
        } else if (state is SignupErrorState) {
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
              title: Text("Signup"),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: AppDimensions.mediumPadding,
                  horizontal: AppDimensions.mediumPadding),
              child: Form(
                key: globalKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(hintText: "Name"),
                      controller: nameTEC,
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: "Email"),
                      controller: emailTEC,
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: "Password"),
                      controller: passwordTEC,
                    ),
                    Spacer(),
                    ElevatedButton(
                        onPressed: () {
                          context.read<OnboardingBloc>().add(
                              OnboardingSignupBTNPressedEvent(
                                  name: nameTEC.text.trim(),
                                  email: emailTEC.text.trim(),
                                  password: passwordTEC.text.trim()));
                        },
                        child: Text("Signup")),
                    TextButton(
                        onPressed: () {
                          AppRouter.replace(
                              context: context, path: AppPages.login.path);
                        },
                        child: Text("Login"))
                  ],
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Center(
              child: Text("UnknowinSignupState"),
            ),
          );
        }
      },
    );
  }
}
