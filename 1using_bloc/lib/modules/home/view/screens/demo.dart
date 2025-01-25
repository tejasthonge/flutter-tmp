import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/index.dart';

class MyScreen extends BasePage {
  const MyScreen({super.key});

  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends BaseState<MyScreen> with BasicPage<MyScreen> {
  @override
  String screenName() => "My Screen";

  @override
  Widget body(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Welcome to My Screen!",
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              context.read<AppBloc>().add(AppCheckNetwork());
            },
            child: const Text("Check Network Status"),
          ),
        ],
      ),
    );
  }

  @override
  Widget getPageTitle() {
    return const Text("My Custom Screen Title");
  }
}
