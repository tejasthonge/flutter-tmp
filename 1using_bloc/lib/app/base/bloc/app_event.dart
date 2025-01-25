part of 'app_bloc.dart';


abstract class AppEvent {}

class AppCheckNetwork extends AppEvent {}

class AppConnectivityChanged extends AppEvent {
  final List<ConnectivityResult> connectivityResult;

  AppConnectivityChanged(this.connectivityResult);
}
