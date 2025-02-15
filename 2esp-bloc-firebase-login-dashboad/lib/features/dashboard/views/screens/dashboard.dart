
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/routes/index.dart';
import '../../bloc/dashboard_bloc.dart';
import 'package:go_router/go_router.dart';

class Dashboard extends StatefulWidget {
  final Widget child;

  const Dashboard({super.key, required this.child});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
    context.read<DashboardBloc>().add(DashboardInitialFeathingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardBloc, DashboardState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is DashboardLoadingState || state is DashboardInitial) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is DashboardErrorState) {
          return Scaffold(
            body: Center(
              child: Text(state.errorMessage),
            ),
          );

        } else if (state is DashboardSuccessState) {
          return PopScope(
            canPop: state.isPop,
            onPopInvokedWithResult: (didPop, result) {
              if (state.selectedTab != BottomNavTab.Home) {
                context
                    .read<DashboardBloc>()
                    .add(DashboardUpdateTabEvent(BottomNavTab.Home));
                _navigateToTab(context, BottomNavTab.Home);
              }
            },
            child: _buildSuccess(context, state),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: Text("Dashboard Unknown State"),
            ),
          );
        }
      },
    );
  }

  Widget _buildSuccess(BuildContext context, DashboardSuccessState state) {
    return Scaffold(
      appBar: AppBar(title: Text(state.selectedTab.name)),
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
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
      ),
    );
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
