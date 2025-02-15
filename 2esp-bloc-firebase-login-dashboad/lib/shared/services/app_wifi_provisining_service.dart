// import 'dart:developer';

// import 'package:flutter_esp_ble_prov/flutter_esp_ble_prov.dart';

// import '../models/index.dart';

// class ApppWifiProvService {
//   final _flutterEspBleProvPlugin = FlutterEspBleProv();
//   final _defaultDevicePrefix = "PROV_123";

//   Future<List<String>> scanBleDevices() async {
//     try {
//       final scannedDevices =
//           await _flutterEspBleProvPlugin.scanBleDevices(_defaultDevicePrefix);
//       return scannedDevices;
//     } catch (e) {
//       // Handle the error appropriately
//       log('Error scanning BLE devices: $e');
//       return [];
//     }
//   }

//   Future<List<String>> scanWifi(BluetoothDeviceModel device, String key) async {
//     try {
//       final scannedNetworks =
//           await _flutterEspBleProvPlugin.scanWifiNetworks(device.name, key);
//       return scannedNetworks;
//     } catch (e) {
//       // Handle the error appropriately
//       log('Error scanning WiFi networks: $e');
//       return [];
//     }
//   }

//   Future provisionWifi(BluetoothDeviceModel bluetoothDevice,
//       WifiDeviceModel wifiDevice, String password, String key) async {
//     try {
//       await _flutterEspBleProvPlugin.provisionWifi(
//           bluetoothDevice.name, key, wifiDevice.name, password);
//     } catch (e) {
//       // Handle the error appropriately
//       log('Error provisioning WiFi: $e');
//     }
//   }
// }