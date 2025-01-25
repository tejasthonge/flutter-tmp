part of 'dashboard_bloc.dart';


abstract class DashboardEvent {}

class DashboardInitialFeathingEvent extends DashboardEvent{}
class DashboardUpdateTabEvent extends DashboardEvent {
  final BottomNavTab tab;
  DashboardUpdateTabEvent(this.tab);
}


