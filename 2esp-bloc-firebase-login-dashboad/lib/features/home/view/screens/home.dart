
import 'package:flutter/material.dart';

import '../../../../shared/routes/index.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
            onPressed: () {
              AppRouter.push(
                context: context,
                path: AppPages.wifiProvision.path,
              );
            },
            child: Text("Connect ESP To wifi")),
      ],
    );
  }
}
