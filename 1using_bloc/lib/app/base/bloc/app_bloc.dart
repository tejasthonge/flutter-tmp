import 'dart:async';
import 'dart:developer';

import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  final Connectivity connectivity =  Connectivity();

  AppBloc() : super(AppInitial()) {
    on<AppCheckNetwork>((event, emit) async {

      final isOnline = await _checkNetworkStatus();
      if (isOnline) {
        emit(AppOnline());
      } else {
        emit(AppOffline());
      }
    });

    on<AppConnectivityChanged>((event, emit) {
      if (event.connectivityResult.contains( ConnectivityResult.ethernet) || event.connectivityResult.contains( ConnectivityResult.wifi) || event.connectivityResult.contains( ConnectivityResult.mobile)) {
        emit(AppOnline());
      } else  {
        emit(AppOffline());
      }
    });

    _connectivitySubscription = connectivity.onConnectivityChanged.listen((connectivityResult) {
      add(AppConnectivityChanged(connectivityResult));
    });

    _startContinuousConnectivityCheck();
  }

  void _startContinuousConnectivityCheck() {
    // Continuously check for connectivity changes
    _connectivitySubscription ??= connectivity.onConnectivityChanged.listen((connectivityResult) {
      add(AppConnectivityChanged(connectivityResult));
    });
  }

  Future<bool> _checkNetworkStatus() async {
    try {
      // Try to look up an address to check for internet access
      final result = await InternetAddress.lookup('example.com');
      log(result.toString());
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (e) {
      return false; // Internet is not accessible
    }
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel(); // Clean up the subscription when closing the Bloc
    return super.close();
  }
}
