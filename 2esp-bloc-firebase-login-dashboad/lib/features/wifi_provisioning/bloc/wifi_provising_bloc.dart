import 'dart:convert';
import 'dart:developer';

// import 'package:app_settings/app_settings.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:meta/meta.dart';

part 'wifi_provising_event.dart';
part 'wifi_provising_state.dart';

class WifiProvisingBloc extends Bloc<WifiProvisingEvent, WifiProvisingState> {
  FlutterBluePlus flutterBlue = FlutterBluePlus();
  List<ScanResult> devicesList = [];
  BluetoothDevice? connectedDevice;
  BluetoothCharacteristic? wifiCharacteristic;
  BluetoothCharacteristic? statusCharacteristic;
  String connectionStatus = "Disconnected";
  String provisioningStatus = "";

  WifiProvisingBloc() : super(WifiProvisingInitial()) {
    on<WifiProvisingInitialFethingEvent>(_onInitialFetching);
    on<WifiProvisingScannDevicesEvent>(_onScanDevices);
    on<WifiProvisingConnectToDeviceEvent>(_onConnectToDevice);
    on<WifiProvisingSendWifiProvisingEvent>(_onSendWifiProvisioning);
    on<WifiProvisingEmiteStateEvent>(_emitHardState);
  }

  Future<bool> checkBluetoothON() async {
    bool isSupported = await FlutterBluePlus.isSupported;
    var adapterState = FlutterBluePlus.adapterState;
    return isSupported &&
        (await adapterState.first) == BluetoothAdapterState.on;
  }

  Future<void> _onInitialFetching(WifiProvisingInitialFethingEvent event,
      Emitter<WifiProvisingState> emit) async {
    emit(WifiProvisingLoadingState());
    bool isBleON = await checkBluetoothON();
    if (isBleON) {
      add(WifiProvisingScannDevicesEvent());
    } else {
      emit(WifiProvisingErrorState(errorMessage: "Bluetooth is not enabled!"));
      // await AppSettings.openAppSettings(type: AppSettingsType.bluetooth);

    }
  }

  Future<void> _emitHardState(WifiProvisingEmiteStateEvent event,
      Emitter<WifiProvisingState> emit) async {
    emit(event.state);
  }

  Future<void> _onScanDevices(WifiProvisingScannDevicesEvent event,
      Emitter<WifiProvisingState> emit) async {
    emit(WifiProvisingScanningPopUpState());
    if (FlutterBluePlus.connectedDevices.isNotEmpty) {
      for (var d in FlutterBluePlus.connectedDevices) {
        await d.disconnect();
      }
    }
    devicesList.clear();
    await FlutterBluePlus.startScan(timeout: const Duration(seconds: 10));
    await Future.delayed(const Duration(seconds: 5));
    devicesList = (await FlutterBluePlus.scanResults.first)
        .where((result) => result.device.advName.startsWith("PROV_"))
        .toList();
    emit(WifiProvisingSuccessState(
      connectedDevice: connectedDevice,
      wifiCharacteristic: wifiCharacteristic,
      statusCharacteristic: statusCharacteristic,
      connectionStatus: connectionStatus,
      devicesList: devicesList,
      flutterBlue: flutterBlue,
      provisioningStatus: provisioningStatus,
    ));
  }

  Future<void> _onConnectToDevice(WifiProvisingConnectToDeviceEvent event,
      Emitter<WifiProvisingState> emit) async {
    try {
      if (FlutterBluePlus.isScanningNow) {
        connectionStatus = "Getting all devices Plese wait..";
        emit(WifiProvisingStatusPopupState(status: connectionStatus));
        return;
      }
      provisioningStatus = "Connecting to device(BLE)";
      emit(WifiProvisingStatusPopupState(status: provisioningStatus));
      await event.bluetoothDevice.connect(autoConnect: false);
      connectedDevice = event.bluetoothDevice;
      emit(WifiProvisingSuccessState(
          connectedDevice: connectedDevice,
          wifiCharacteristic: wifiCharacteristic,
          statusCharacteristic: statusCharacteristic,
          connectionStatus: connectionStatus,
          devicesList: devicesList,
          flutterBlue: flutterBlue,
          provisioningStatus: provisioningStatus));
      connectionStatus = "Connected to ${event.bluetoothDevice.advName}";
      emit(WifiProvisingStatusPopupState(status: connectionStatus));

      List<BluetoothService> services =
          await connectedDevice!.discoverServices();
      for (var service in services) {
        for (var characteristic in service.characteristics) {
          if (characteristic.uuid.toString().contains("fff1")) {
            wifiCharacteristic = characteristic;
          } else if (characteristic.uuid.toString().contains("fff2")) {
            statusCharacteristic = characteristic;
          }
        }
      }

      if (statusCharacteristic != null) {
        await statusCharacteristic!.setNotifyValue(true);
        statusCharacteristic!.lastValueStream.listen((value) {
          if (value.isNotEmpty) {
            provisioningStatus = utf8.decode(value);
            log(provisioningStatus.toString());
          } else {
            provisioningStatus = "Received empty response!";
            log(provisioningStatus.toString());
          }
          add(WifiProvisingEmiteStateEvent(
              state:
                  WifiProvisingStatusPopupState(status: provisioningStatus)));
        }, onError: (error) {
          provisioningStatus = "Error receiving response: $error";
          log(provisioningStatus.toString());

          add(WifiProvisingEmiteStateEvent(
              state:
                  WifiProvisingStatusPopupState(status: provisioningStatus)));
        });
      }
    } catch (e) {
      connectionStatus = "Connection failed: ${e.toString()}";
      log(connectionStatus.toString());
      add(WifiProvisingEmiteStateEvent(
          state: WifiProvisingErrorPopUpState(error: connectionStatus)));
    }
  }

  Future<void> _onSendWifiProvisioning(
      WifiProvisingSendWifiProvisingEvent event,
      Emitter<WifiProvisingState> emit) async {
    emit(WifiProvisingStatusPopupState(status: "Sending credentials..."));
    log(provisioningStatus.toString());

    if (wifiCharacteristic == null || connectedDevice == null) {
      emit(WifiProvisingErrorState(
          errorMessage: "Device not connected or characteristic missing!"));
      return;
    }
    try {
      provisioningStatus = "Credentials Sent. Waiting for response...";
      log(provisioningStatus.toString());
      emit(WifiProvisingStatusPopupState(status: provisioningStatus));
      String credentials = "${event.ssid}:${event.password}";
      await wifiCharacteristic!
          .write(utf8.encode(credentials))
          .timeout(const Duration(seconds: 15));
    } catch (e) {
      log("(((((********************************)))))");

      log(provisioningStatus.toString() + e.toString());
        emit(WifiProvisingErrorPopUpState(
            error: provisioningStatus));

    }
  }
}
