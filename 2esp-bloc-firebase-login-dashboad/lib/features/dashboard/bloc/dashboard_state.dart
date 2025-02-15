part of 'dashboard_bloc.dart';


abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardActionState extends DashboardState{}


class DashboardSuccessState extends DashboardState{
  final BottomNavTab selectedTab;
  final bool isPop;
  DashboardSuccessState({required this.selectedTab,required this.isPop});
}

class DashboardLoadingState extends DashboardState{}
class DashboardErrorState extends DashboardState{
  final String errorMessage;
  DashboardErrorState({required this.errorMessage});
}
