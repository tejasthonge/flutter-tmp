import 'dart:developer';

import 'package:bloc/bloc.dart';
part 'dashboard_event.dart';
part 'dashboard_state.dart';


// ignore: constant_identifier_names
enum BottomNavTab { Home, Devices, Profile }

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {

  DashboardBloc() : super(DashboardInitial()) {
    bool isPop = false;
    on<DashboardInitialFeathingEvent>((event, emit) {
      try {
        emit(DashboardSuccessState(isPop: isPop, selectedTab: BottomNavTab.Home));
      } catch (e) {
        log(e.toString());
      }
    });
    on<DashboardUpdateTabEvent>((event, emit) {
      if(event.tab == BottomNavTab.Home){
        isPop = true;
      }else{
        isPop = false;
      }
      emit(DashboardSuccessState(
        isPop: isPop,
        selectedTab: event.tab));
    });

    
  }
}
