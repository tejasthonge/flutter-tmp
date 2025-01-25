import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kequele/app/base/view/screens/basic_page.dart';
import '../../../../shared/routes/index.dart';
import '../../bloc/dashboard_bloc.dart';
import 'package:go_router/go_router.dart';

class Dashboard extends BasePage {
  final Widget child;

  const Dashboard({super.key, required this.child});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends BaseState<Dashboard> with BasicPage<Dashboard> {
  @override
  void initState() {
    super.initState();
    context.read<DashboardBloc>().add(DashboardInitialFeathingEvent());
  }

  @override
  String screenName() {
    // TODO: implement screenName
    throw UnimplementedError();
  }

  @override
  Widget body(BuildContext context) {
    return BlocConsumer<DashboardBloc, DashboardState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is DashboardLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is DashboardErrorState) {
          return Center(
            child: Text(state.errorMessage),
          );
        } else if (state is DashboardSuccessState) {
          return WillPopScope(
            onWillPop: () async {
              if (state.selectedTab == BottomNavTab.Home) {
                return true;
              } else {
                context
                    .read<DashboardBloc>()
                    .add(DashboardUpdateTabEvent(BottomNavTab.Home));
                _navigateToTab(context, BottomNavTab.Home);
                return false;
              }
            },
            child: _buildSuccess(context, state),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: Text("Unknown State"),
            ),
          );
        }
      },
    );
  }

  Widget _buildSuccess(BuildContext context, DashboardSuccessState state) {
    return widget.child;
  }

  @override
  Widget bottomNavigationBar(BuildContext context) {
    return BlocConsumer<DashboardBloc, DashboardState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is DashboardSuccessState) {
            return BottomNavigationBar(
              currentIndex: BottomNavTab.values.indexOf(state.selectedTab),
              onTap: (index) {
                final tab = BottomNavTab.values[index];
                context.read<DashboardBloc>().add(DashboardUpdateTabEvent(tab));
                _navigateToTab(context, tab);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.devices),
                  label: 'Devices',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            );
          } else {
            return super.bottomNavigationBar(context);
          }
        });
  }

  void _navigateToTab(BuildContext context, BottomNavTab tab) {
    switch (tab) {
      case BottomNavTab.Home:
        context.go(AppPages.home.path);
        break;
      case BottomNavTab.Devices:
        context.go(AppPages.devices.path);
        break;
      case BottomNavTab.Profile:
        context.go(AppPages.profile.path);
        break;
    }
  }
}
