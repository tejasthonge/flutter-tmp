
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../../app/base/index.dart';


  
class DemoPage extends BasePage{
  const DemoPage({super.key});
  @override
  State<StatefulWidget> createState() => DemoPageState();
}


class DemoPageState extends BaseState<DemoPage> with BasicPage{
  @override 
  PreferredSizeWidget getAppBar(BuildContext context, vm) {
    return super.getAppBar(context, vm);
  }
  @override
  Widget body(BuildContext context) {
    return Center(
      child: Text('This is the Demo Page'),
    );
  }

  @override
  String screenName() {
  return "DemoPage";
  }

  @override
  String screenSubHeading() {
    return "Demo SubHeading";
  }

}