import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../index.dart';

mixin BasicPage<Page extends BasePage> on BaseState<Page> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        if (state is AppOffline) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('You are offline')),
          );
        } else if (state is AppOnline) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('You are back online')),
          );
        }
      },
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          if (state is AppInitial) {
            return _buildLoadingScreen();
          } else if (state is AppOffline) {
            return _buildOfflineScreen(context);
          } else {
            return _buildMainScaffold(context, state);
          }
        },
      ),
    );
  }

  Widget _buildLoadingScreen() {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildOfflineScreen(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wifi_off, size: 100, color: Colors.red),
            const SizedBox(height: 20),
            const Text(
              'You are offline',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                context.read<AppBloc>().add(AppCheckNetwork());
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainScaffold(BuildContext context, AppState state) {
    return Scaffold(
      appBar: isAppBarDisabled() ? null : getAppBar(context, state),
      body: body(context),
      bottomNavigationBar: bottomNavigationBar(context),
      floatingActionButton: getFloatingActionButton(context, state),
    );
  }

  PreferredSizeWidget? getAppBar(BuildContext context, AppState state) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.black),
      backgroundColor: state is AppOffline ? Colors.red : Colors.grey,
      elevation: 10,
      title: getPageTitle(),
      centerTitle: true,
      automaticallyImplyLeading: true,
    );
  }

  Widget getPageTitle() {
    return const Text('Default Title');
  }

  Widget? getFloatingActionButton(BuildContext context, AppState state) {
    return null;
  }

  Widget bottomNavigationBar(BuildContext context) {
    return const SizedBox.shrink();
  }

  Widget body(BuildContext context);
}

abstract class BasePage extends StatefulWidget {
  const BasePage({super.key});
}

abstract class BaseState<Page extends BasePage> extends State<Page>
    with AutomaticKeepAliveClientMixin {
  String screenName();

  bool isAppBarDisabled() => false;

  @override
  bool get wantKeepAlive => true;

  @override
  void didChangeDependencies() {
    context.read<AppBloc>().add(AppCheckNetwork());
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
