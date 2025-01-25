import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/styles/index.dart';
import '../../index.dart';

mixin BasicPage<Page extends BasePage> on BaseState<Page> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BasicPageBloc, BasicPageState>(
      listener: (context, state) {
        // Handle state changes (e.g., show a snackbar)
      },
      builder: (context, state) {
        return BossLoadingOverlay(
          opacity: 0.3,
          isLoading: false,
          overlayWidget: showLoader(),
          child: Scaffold(
            // endDrawer: const BossAppDrawer(),
            drawerEnableOpenDragGesture: false,
            drawerEdgeDragWidth: 0,
            endDrawerEnableOpenDragGesture: false,
            appBar: isAppBarDisabled() ? null : getAppBar(context, state),
            body: body(context),
            bottomNavigationBar: bottomNavigationBar(context),
            // floatingActionButton: getFloatingActionButton(context, vm),
          ),
        );
      },
    );
  }

  PreferredSizeWidget getAppBar(BuildContext context, vm) {
    return AppBar(
      // iconTheme: IconThemeData(color: AppColors.color000000),
      backgroundColor: vm.sessionState.offlineMode ? Colors.red : Colors.green,
      elevation: 10,
      title: getPageTitle(),
      actions: getActions(context),
      centerTitle: true,
      automaticallyImplyLeading: true,
    );
  }

  List<Widget>? getActions(BuildContext context) {
    return [];
  }

  Widget? getFloatingActionButton(BuildContext context, vm) {
    return null;
  }

  Widget getPageTitle() {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: AppDimensions.mediumPadding ),
      // child: Image.asset(AppAssets.logo, height: 40),
    );
  }

  Widget getPageHeader(vm) {
    return Padding(
      padding:  EdgeInsets.only(bottom: AppDimensions.mediumPadding,),
      child: Row(
        children: [
          getScreenName(),
           SizedBox(
            width: AppDimensions.standardSpacing ,
          ),
          getScreenSubHeading()
        ],
      ),
    );
  }

  Widget getScreenName() {
    return Text(screenName(), style:AppTextstyle.textStyle10w400);
  }

  Widget getScreenSubHeading() {
    return Expanded(child: Text(screenSubHeading(), style: AppTextstyle.textStyle10w400));
  }

  Widget getPageFooter() {
    return const SizedBox.shrink();
  }

  Widget showLoader() {
    return Center(
        child: CircularProgressIndicator(
      color: AppColors.colorTransp,
      backgroundColor: AppColors.colorTransp,
    ));
  }

  Widget bottomNavigationBar(BuildContext context) {
    return const SizedBox.shrink();
  }

  Widget body(BuildContext context);
}

abstract class BasePage extends StatefulWidget {
  const BasePage({super.key});
}

abstract class BaseState<Page extends BasePage> extends State<Page>  {
  String screenName();
  String screenSubHeading();
  bool isAppBarDisabled() => false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // RouterScope exposes the list of provided observers
    // including inherited observers


      // we subscribe to the observer by passing our
  }

  @override
  void dispose() {
    super.dispose();
    // don't forget to unsubscribe from the
    // observer on dispose
  }

  // only override if this is a tab page


  // only override if this is a tab page


  

}

// BLoC class definition
class BasicPageBloc extends Cubit<BasicPageState> {
  BasicPageBloc() : super(BasicPageInitial());
  
  // Define your BLoC methods here
}

// State classes for BLoC
abstract class BasicPageState {
  // Add a sessionState property to the base class if needed
  SessionState get sessionState; // Assuming SessionState is a defined class
}

class BasicPageInitial extends BasicPageState {
  @override
  SessionState get sessionState => SessionState(); // Provide a default or initial value
}

// Define the SessionState class if it doesn't exist
class SessionState {
  final bool offlineMode;

  SessionState({this.offlineMode = false}); // Default value
}
