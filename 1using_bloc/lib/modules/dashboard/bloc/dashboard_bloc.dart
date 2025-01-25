import 'dart:developer';

import 'package:bloc/bloc.dart';
part 'dashboard_event.dart';
part 'dashboard_state.dart';


enum BottomNavTab { Home, Devices, Profile }

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {

  DashboardBloc() : super(DashboardInitial()) {
    on<DashboardInitialFeathingEvent>((event, emit) {
      try {
        emit(DashboardSuccessState( selectedTab: BottomNavTab.Home));
      } catch (e) {
        log(e.toString());
      }
    });
    on<DashboardUpdateTabEvent>((event, emit) {
      emit(DashboardSuccessState(selectedTab: event.tab));
    });

    
  }
}
