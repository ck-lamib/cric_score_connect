import 'dart:io';

import 'package:cric_score_connect/utils/helpers/custom_logger.dart';
import 'package:device_info_plus/device_info_plus.dart';

import 'package:permission_handler/permission_handler.dart';

class PermissionsStatusHandler {
  allPermissionRequest() async {
    List<Permission> permissions = [
      Permission.storage,
      Permission.notification
    ];

    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      var isPlatformGreaterthan_33 = androidInfo.version.sdkInt >= 33;
      if (isPlatformGreaterthan_33) {
        permissions.add(Permission.photos);
        permissions.add(Permission.audio);
        permissions.add(Permission.videos);
      }
    }
    await permissions.request();
  }

  Future<PermissionStatus> askStoragePermissionStatus() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      var isPlatformGreaterthan_33 = androidInfo.version.sdkInt >= 33;
      try {
        List<Permission> permissions = [
          Permission.storage,
        ];

        if (isPlatformGreaterthan_33) {
          permissions.add(Permission.photos);
          permissions.add(Permission.audio);
          permissions.add(Permission.videos);
        }
        var statuses = await permissions.request();

        if (isPlatformGreaterthan_33) {
          return statuses[Permission.photos] ?? PermissionStatus.denied;
        } else {
          return statuses[Permission.storage] ?? PermissionStatus.denied;
        }
      } catch (e) {
        if (isPlatformGreaterthan_33) {
          return await Permission.photos.status;
        } else {
          return await Permission.notification.status;
        }
      }
    } else {
      try {
        // return await Permission.storage.request();
        Map<Permission, PermissionStatus> statues =
            await [Permission.storage, Permission.photos].request();

        PermissionStatus? statusStorage = statues[Permission.storage];
        PermissionStatus? statusPhotos = statues[Permission.photos];
        bool isGranted = (statusStorage == PermissionStatus.granted) &&
            (statusPhotos == PermissionStatus.granted);
        if (isGranted) {
          return PermissionStatus.granted;
        } else {
          return PermissionStatus.denied;
        }
      } catch (e) {
        CustomLogger.trace(e);
        return await Permission.storage.status;
      }
    }
  }

  Future<PermissionStatus> askNotificationPermissionStatus() async {
    try {
      return await Permission.notification.request();
    } catch (e) {
      CustomLogger.trace(e);
      return await Permission.notification.status;
    }
  }

  Future<PermissionStatus> askCameraPermissionStatus() async {
    try {
      return await Permission.camera.request();
    } catch (e) {
      CustomLogger.trace(e);
      return await Permission.camera.status;
    }
  }

  Future<bool> requestPermission({
    required Future<PermissionStatus> Function() onRequestPermission,
  }) async {
    var permissionStatus = await onRequestPermission();

    if (permissionStatus.isGranted) {
    } else if (permissionStatus.isDenied) {
      CustomLogger.trace("called denied");
      await openAppSettings();
    } else if (permissionStatus.isPermanentlyDenied) {
      CustomLogger.trace("called perm denied");
      await openAppSettings();
    }
    return permissionStatus.isGranted;
  }
}
