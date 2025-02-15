import 'dart:convert';
import 'dart:developer';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../entity/ble_charactrics.dart';

class WifiProvisioningUsecase {
  BluetoothCharacteristic? wifiCharacteristic;
  BluetoothCharacteristic? statusCharacteristic;

  Future<bool> checkBluetooth() async {
    bool isSupported = await FlutterBluePlus.isSupported;
    var adapterState = FlutterBluePlus.adapterState;
    return isSupported &&
        (await adapterState.first) == BluetoothAdapterState.on;
  }

  Stream<List<ScanResult>> scanForDevicesStream() async* {
    try {
      FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));
    } catch (e) {
      log("Error starting scan: $e");
    }

    // Listen for Bluetooth adapter state
    await for (var results in FlutterBluePlus.scanResults) {
      // Check if Bluetooth is on and filter results
      if (await checkBluetooth()) {
        var provDevices = results
            .where((result) => result.device.advName.contains("PROV_"))
            .toList();
        if (provDevices.isNotEmpty) {
          for (var result in provDevices) {
            log(result.device.advName);
          }
          yield provDevices; // Emit the filtered list of devices
        }
      }
    }
  }

  Future<BluetoothDevice?> connectToDevice(
      {required BluetoothDevice device}) async {
    try {
      log(device.advName);
      await device.connect();
      if (device.isConnected) {
        log("Connected to device ${device.advName}");
        return device;
      }
    } catch (e) {
      log("Error connecting to device: $e");
    }
    return null;
  }

  Future<BleCharactrics?> getCharacteristics(
      {required BluetoothDevice device}) async {
    try {
      List<BluetoothService> services = await device.discoverServices();
      for (var service in services) {
        for (var characteristic in service.characteristics) {
          if (characteristic.uuid.toString().contains("fff1")) {
            wifiCharacteristic = characteristic;
          } else if (characteristic.uuid.toString().contains("fff2")) {
            statusCharacteristic = characteristic;
          }
        }
      }
      if (statusCharacteristic != null && wifiCharacteristic != null) {
        return BleCharactrics(
          wifiCharacteristic: wifiCharacteristic!,
          statusCharacteristic: statusCharacteristic!,
        );
      } else {
        log("No matching characteristic found");
        return null;
      }
    } catch (e) {
      log("Error getting Bluetooth characteristics: $e");
      return null;
    }
  }

  Stream<String> getResponseStream(
      {required BluetoothCharacteristic statusCharacteristic}) async* {
    await statusCharacteristic.setNotifyValue(true);
    yield* statusCharacteristic.lastValueStream.map((value) {
      log("Received value: $value");
      return value.isNotEmpty ? utf8.decode(value) : "Received empty response!";
    });
  }

  Future<String> sendWifiCredentials({
    required BluetoothCharacteristic wifiCharacteristic,
    required BluetoothDevice connectedDevice,
    required String wifiName,
    required String password,
  }) async {
    if (!connectedDevice.isConnected) {
      log("Device is disconnected");
      return "BLE or WiFi is not connected";
    }
    String credentials = jsonEncode({"ssid": wifiName, "password": password});
    try {
      await wifiCharacteristic.write(utf8.encode(credentials),
          withoutResponse: true);
      return "Credentials Sent. Waiting for response...";
    } catch (e) {
      return "Failed to send credentials! Error: $e";
    }
  }
}
