

import 'package:flutter/material.dart';
import 'package:kequele/shared/routes/index.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return  Column(

      children: [
        ElevatedButton(onPressed: (){
          AppRouter.push(context: context, path: AppPages.demo.path);
        }, child: Text("go to Screen"))
      ],
    );
  }
}