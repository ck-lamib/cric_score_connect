import 'dart:io';

import 'package:cric_score_connect/utils/custom_snackbar.dart';
import 'package:cric_score_connect/utils/helpers/permissions_status_handler.dart';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class PickImageHelper {
  Future<bool> requestCameraPermissions() async {
    PermissionsStatusHandler permissionsStatusHandler =
        PermissionsStatusHandler();
    return await permissionsStatusHandler.requestPermission(
      onRequestPermission: () async {
        PermissionStatus status =
            await permissionsStatusHandler.askCameraPermissionStatus();
        if (!status.isGranted) {
          CustomSnackBar.info(
            title: "Permission",
            message: "Please enable camera permission",
          );
          await Future.delayed(const Duration(seconds: 1));
        }
        return status;
      },
    );
  }

  Future<bool> requestStoragePermissions() async {
    PermissionsStatusHandler permissionsStatusHandler =
        PermissionsStatusHandler();
    return await permissionsStatusHandler.requestPermission(
      onRequestPermission: () async {
        PermissionStatus status =
            await permissionsStatusHandler.askStoragePermissionStatus();
        if (!status.isGranted) {
          CustomSnackBar.info(
            title: "Permission",
            message: "Please enable storage permission",
          );
          await Future.delayed(const Duration(seconds: 1));
        }
        return status;
      },
    );
  }

  pickSingleImage({ImageSource? source}) async {
    File? image;
    ImagePicker imagePicker = ImagePicker();
    if (source != null) {
      if (source == ImageSource.camera) {
        var cameraPermissionStatus = await requestCameraPermissions();
        if (cameraPermissionStatus) {
          XFile? xFile = await imagePicker.pickImage(source: source);
          if (xFile != null) {
            image = File(xFile.path);
          }
        }
      }
      if (source == ImageSource.gallery) {
        var storagePermissionStatus = await requestStoragePermissions();
        if (storagePermissionStatus) {
          XFile? xFile = await imagePicker.pickImage(source: source);
          if (xFile != null) {
            image = File(xFile.path);
          }
        }
      }
    }

    return image;
  }

  Future<List<File>> pickMultiImages() async {
    List<File> pickedFiles = [];
    ImagePicker imagePicker = ImagePicker();
    List<XFile> files = await imagePicker.pickMultiImage();
    for (var item in files) {
      pickedFiles.add(File(item.path));
    }
    return pickedFiles;
  }

  Future<File?> cropImage(
    File file, {
    double? height,
    double? width,
    CropStyle cropStyle = CropStyle.rectangle,
    bool lockAspectRatio = true,
  }) async {
    // print("=======>> crop aspect: ${CropAspectRatio(
    //   ratioX: width!,
    //   ratioY: height!,
    // )}");
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: file.path,
      // aspectRatio: CropAspectRatio(
      //   ratioX: 1,
      //   ratioY: 2,
      // ),
      aspectRatio: (height == null || width == null)
          ? null
          : CropAspectRatio(
              ratioX: width,
              ratioY: height,
            ),
      cropStyle: cropStyle,
      compressFormat: ImageCompressFormat.png,
      compressQuality: 100,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: "Crop and Rotate Image",
          toolbarColor: Colors.transparent,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: lockAspectRatio,
          hideBottomControls: false,
          showCropGrid: true,

          // backgroundColor: Colors.transparent,
          // statusBarColor: AppColor.dark,
        ),
        IOSUiSettings(
            title: "Crop and Rotate Image",
            showCancelConfirmationDialog: true,
            aspectRatioLockEnabled: true,
            resetAspectRatioEnabled: false,
            aspectRatioPickerButtonHidden: true,
            rectHeight: height,
            rectWidth: width,
            rotateButtonsHidden: false),
      ],
    );

    if (croppedFile != null) {
      return File(croppedFile.path);
    } else {
      return null;
    }
  }

  Future<File?> pickAndCropImage(ImageSource imageSource) async {
    File? finalFile;

    File? file = await pickSingleImage(source: imageSource);
    if (file != null) {
      finalFile = await cropImage(file);
    } else {}
    return finalFile;
  }
}
