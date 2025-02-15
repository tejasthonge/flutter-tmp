part of 'wifi_provising_bloc.dart';

@immutable
sealed class WifiProvisingEvent {}

class WifiProvisingInitialFethingEvent extends WifiProvisingEvent{}

class WifiProvisingScannDevicesEvent extends WifiProvisingEvent{}

class WifiProvisingConnectToDeviceEvent extends WifiProvisingEvent{
  final BluetoothDevice bluetoothDevice;
   WifiProvisingConnectToDeviceEvent({required this.bluetoothDevice});
}  

class WifiProvisingSendWifiProvisingEvent extends WifiProvisingEvent{
  final String ssid;
  final String password;
   WifiProvisingSendWifiProvisingEvent({required this.ssid, required this.password});
}

class WifiProvisingEmiteStateEvent extends WifiProvisingEvent{
  final WifiProvisingState state;
   WifiProvisingEmiteStateEvent({required this.state});
}
