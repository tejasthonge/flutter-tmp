import 'dart:developer';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  /// Requests permissions required for login (e.g., Storage).
  static Future<void> requestLoginPermission() async {
    try {
      PermissionStatus storageStatus = await Permission.storage.request();

      if (storageStatus.isGranted) {
        log("Storage permission granted");
      } else {
        throw Exception("Storage permission denied");
      }
    } catch (e) {
      log("Error requesting login permissions: $e");
      throw Exception("Failed to request login permissions");
    }
  }

  /// Requests Bluetooth-related permissions.
  static Future<void> requestBluetoothPermission() async {
    try {
      PermissionStatus scanStatus = await Permission.bluetoothScan.request();
      PermissionStatus connectStatus = await Permission.bluetoothConnect.request();

      if (scanStatus.isGranted && connectStatus.isGranted) {

        log("Bluetooth permissions granted");
      } else {
        throw Exception("Bluetooth permissions denied");
        
      }
    } catch (e) {
      log("Error requesting Bluetooth permissions: $e");
      throw Exception("Failed to request Bluetooth permissions");
    }
  }

  /// Requests multiple permissions at once.
  Future<bool> requestMultiplePermissions(List<Permission> permissions) async {
    try {
      Map<Permission, PermissionStatus> statuses = await permissions.request();
      bool allGranted = statuses.values.every((status) => status.isGranted);

      if (!allGranted) throw Exception("Some permissions were denied");

      return allGranted;
    } catch (e) {
      log('Error requesting multiple permissions: $e');
      throw Exception("Failed to request multiple permissions");
    }
  }

  /// Checks if a specific permission is granted.
  Future<bool> isPermissionGranted(Permission permission) async {
    try {
      PermissionStatus status = await permission.status;
      return status.isGranted;
    } catch (e) {
      log('Error checking permission status: $e');
      throw Exception("Failed to check permission status");
    }
  }

  /// Opens the app settings if permission is denied permanently.
  static Future<void> openAppSetting() async {
    try {
      bool opened = await openAppSettings();
      if (!opened) throw Exception('Unable to open app settings.');
    } catch (e) {
      log('Error opening app settings: $e');
      throw Exception("Failed to open app settings");
    }
  }
}


