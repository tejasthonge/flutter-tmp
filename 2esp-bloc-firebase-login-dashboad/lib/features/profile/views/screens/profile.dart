import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../shared/routes/index.dart';
import '../../../../shared/widgets/app_sank_bar.dart';
import '../../bloc/profile_bloc.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(ProfileInitialFeatchingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLogoutSuccessActionState) {
          if (context.mounted) {
            getAppSankBar(context: context, message: state.logoutMessage);
            AppRouter.go(context: context, path: AppPages.splash.path);
          }
        } else if (state is ProfileLogoutErrorActionState) {
          getAppSankBar(context: context, message: state.errorMessage);
        }
      },
      listenWhen: (previous, current) => true,
      buildWhen: (previous, current) => true,
      builder: (context, state) {
        if (state is ProfileLoadingState || state is ProfileInitial) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ProfileErrorState) {
          return Center(
            child: Text(state.errorMessage),
          );
        } else if (state is ProfileSuccessState) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
            child: Column(
              children: [
                SizedBox(
                  height: 60.h,
                  child: ClipOval(
                    child: Image.network(
                      FirebaseAuth.instance.currentUser!.photoURL ??
                          "https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(FirebaseAuth.instance.currentUser!.displayName ?? ""),
                Text(FirebaseAuth.instance.currentUser!.email ?? ""),
                Text(FirebaseAuth.instance.currentUser!.phoneNumber ?? ""),
                Spacer(),
                TextButton(
                  onPressed: () {
                    context.read<ProfileBloc>().add(ProfileLogoutUserEvent());
                  },
                  child: Text("Log Out"),
                ),
              ],
            ),
          );
        } else {
          log('Unknown state: $state');
          return Center(
            child: Text("********** Unknown State **********"),
          );
        }
      },
    );
  }
}
