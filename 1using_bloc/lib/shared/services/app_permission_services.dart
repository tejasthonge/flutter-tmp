


import 'dart:developer';

import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static Future<void>  checkAndRequestPermissions() async {
    // Request Bluetooth permissions
    if (await Permission.bluetoothScan.request().isGranted &&
        await Permission.bluetoothConnect.request().isGranted) {
      log("Bluetooth permissions granted");
    } else {
      log("Bluetooth permissions denied");
    }

    // Request Storage permissions
    if (await Permission.storage.request().isGranted) {
      log("Storage permission granted");
    } else {
      log("Storage permission denied");
    }
  }

  Future<bool> requestMultiplePermissions(List<Permission> permissions) async {
    try {
      Map<Permission, PermissionStatus> statuses = await permissions.request();
      bool allGranted = statuses.values.every((status) => status.isGranted);

      return allGranted;
    } catch (e) {
      log('Error requesting multiple permissions: $e');
      return false;
    }
  }

  Future<bool> isPermissionGranted(Permission permission) async {
    try {
      PermissionStatus status = await permission.status;
      return status.isGranted;
    } catch (e) {
      log('Error checking permission status: $e');
      return false;
    }
  }

  Future<void> openAppSetting() async {
    try {
      bool opened = await openAppSettings();
      if (!opened) {
        log('Unable to open app settings.');
      }
    } catch (e) {
      log('Error opening app settings: $e');
    }
  }
}