
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BleCharactrics {
   BluetoothCharacteristic wifiCharacteristic;
   BluetoothCharacteristic statusCharacteristic;
  BleCharactrics({
    required this.wifiCharacteristic,
    required this.statusCharacteristic,
  });
}