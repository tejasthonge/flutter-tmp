class BluetoothDeviceModel {
  final String name;
  String? id;
  bool deviceState;

  BluetoothDeviceModel({required this.name, this.deviceState = false, this.id});

  factory BluetoothDeviceModel.fromMap(Map<String, dynamic> data) {
    return BluetoothDeviceModel(
        name: data['device_name'],
        deviceState: data['connected'] ?? false,
        id: data['id']);
  }
}