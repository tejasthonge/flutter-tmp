part of 'wifi_provising_bloc.dart';

@immutable
sealed class WifiProvisingState {}

final class WifiProvisingInitial extends WifiProvisingState {}

class WifiProvisingActionState extends WifiProvisingState {}

class WifiProvisingLoadingState extends WifiProvisingState {}

class WifiProvisingErrorState extends WifiProvisingState {
  final String errorMessage;
  WifiProvisingErrorState({required this.errorMessage});
}

// ignore: must_be_immutable
class WifiProvisingSuccessState extends WifiProvisingState {
  FlutterBluePlus flutterBlue = FlutterBluePlus();

  List<ScanResult> devicesList = [];

  BluetoothDevice? connectedDevice;

  BluetoothCharacteristic? wifiCharacteristic;

  BluetoothCharacteristic? statusCharacteristic;

  String connectionStatus = "Disconnected";

  String provisioningStatus = "";

  WifiProvisingSuccessState(
      {required this.connectedDevice,
      required this.wifiCharacteristic,
      required this.statusCharacteristic,
      required this.connectionStatus,
      required this.devicesList,
      required this.flutterBlue,
      required this.provisioningStatus});
}

class WifiProvisingScanningPopUpState extends WifiProvisingActionState {}

class WifiProvisingStatusPopupState extends WifiProvisingActionState {
  final String status;
  WifiProvisingStatusPopupState({required this.status});
}

class WifiProvisingErrorPopUpState extends WifiProvisingActionState {
  final String error;
  WifiProvisingErrorPopUpState({required this.error});
}
