import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kequele/core/di/app_dependency_injection.dart';
import 'package:kequele/shared/routes/index.dart';
import 'package:kequele/shared/services/index.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              await AppDependencyInjection.getIt.get<AppLocalData>().clearAll();
              if (context.mounted) {
                AppRouter.go( context :context,path:AppPages.profile.path);
              }
            },
            child: Text("Logout"))
      ],
    );
  }
}
