part of 'dashboard_bloc.dart';


abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardActionState extends DashboardState{}


class DashboardSuccessState extends DashboardState{
  final BottomNavTab selectedTab;

  DashboardSuccessState({required this.selectedTab});
}

class DashboardLoadingState extends DashboardState{}
class DashboardErrorState extends DashboardState{
  final String errorMessage;
  DashboardErrorState({required this.errorMessage});
}
