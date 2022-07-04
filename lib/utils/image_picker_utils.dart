import 'dart:async';
import 'dart:math';

import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:lib_ylz_camera/lib_ylz_camera.dart';
import 'package:lib_ylz_ui_kit_package/lib_ylz_ui_kit_package.dart';
import 'package:lib_ylz_utils_package/lib_ylz_utils_package.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:dragoma/utils/platform_utils.dart';
import 'package:dragoma/utils/toast_utils.dart';
import 'package:dragoma/widgets/system_authority_sheet.dart';

enum ImageSource { camera, gallery }

double maxImageLengthMB = 20.0;
double minImageLengthMB = 1.0;

class ImagePickerUtils {
  static Future<String?> getImageShowLoading(
      BuildContext context, ImageSource imageSource,
      {TemplateMaskBuilder? templateMaskBuilder,
      WidgetBuilder? lightSensorTipsBuilder,
      String? takePhotoTips}) async {
    Map<Permission, PermissionStatus> statuses;
    switch (imageSource) {
      case ImageSource.camera:
        statuses = await [
          Permission.camera,
          if (Platform.isAndroid) Permission.storage,
        ].request();
        return await _byCamera(context, statuses,
            templateMaskBuilder: templateMaskBuilder,
            lightSensorTipsBuilder: lightSensorTipsBuilder,
            takePhotoTips: takePhotoTips);
      case ImageSource.gallery:
        statuses = await [
          if (Platform.isAndroid) Permission.storage,
          if (Platform.isIOS) Permission.photos
        ].request();
        return await _byGallery(context, statuses);
      default:
        return null;
    }
  }

  static Future<List<String>?> getPhotosShowLoading(
      BuildContext context, ImageSource imageSource,
      {TemplateMaskBuilder? templateMaskBuilder,
      WidgetBuilder? lightSensorTipsBuilder,
      String? takePhotoTips,
      int maxAssets = 1}) async {
    Map<Permission, PermissionStatus> statuses;
    switch (imageSource) {
      case ImageSource.camera:
        statuses = await [
          Permission.camera,
          if (Platform.isAndroid) Permission.storage,
        ].request();
        String? imagePath = await _byCamera(context, statuses,
            templateMaskBuilder: templateMaskBuilder,
            lightSensorTipsBuilder: lightSensorTipsBuilder,
            takePhotoTips: takePhotoTips);
        if (imagePath == null) {
          return null;
        }
        return Future.value([imagePath]);
      case ImageSource.gallery:
        statuses = await [
          if (Platform.isAndroid) Permission.storage,
          if (Platform.isIOS) Permission.photos
        ].request();
        return await _byGalleryList(context, statuses, maxAssets: maxAssets);
      default:
        return null;
    }
  }

  static Future<String?> _byCamera(
      BuildContext context, Map<Permission, PermissionStatus> statues,
      {TemplateMaskBuilder? templateMaskBuilder,
      WidgetBuilder? lightSensorTipsBuilder,
      String? takePhotoTips}) async {
    if (_permissionGranted(statues)) {
      File? imageFile = await CameraPicker.pickFromCamera(context,
          templateMaskBuilder: templateMaskBuilder,
          lightSensorTipsBuilder: lightSensorTipsBuilder,
          takePhotoTips: takePhotoTips);
      if (imageFile == null) {
        return null;
      }
      return _compressImage(imageFile);
    }
    if (_permissionDenied(statues)) {
      if (Platform.isIOS) {
        SystemAuthoritySheet().show(context);
        return null;
      } else {
        if (statues[Permission.camera]!.isDenied) {
          YLZToastUtils.showToast("未开启运荔枝相机权限，请在设置中开启后重试");
          return null;
        } else {
          YLZToastUtils.showToast("未开启运荔枝文件管理权限，请在设置中开启后重试");
          return null;
        }
      }
    }
    if (_permanentlyDenied(statues)) {
      SystemAuthoritySheet().show(context);
      return null;
    }
    return null;
  }

  static Future<String?> _byGallery(
      BuildContext context, Map<Permission, PermissionStatus> statues) async {
    if (_permissionGranted(statues)) {
      ProgressHUD? loading;
      List<AssetEntity>? assets = await AssetPicker.pickAssets(context,
          maxAssets: 1, requestType: RequestType.image);
      if (assets.isEmptyNullList) return null;

      loading = ProgressHUD.showLoading(text: '读取中...');
      File? imageFile =
          await assets!.first.file.timeout(Duration(seconds: 5), onTimeout: () {
        return null;
      }).catchError((e) {});
      loading.dismiss();
      if (imageFile == null) {
        YLZToastUtils.showToast('图片内容异常，请重新选择图片');
        return null;
      }
      return _compressImage(imageFile);
    }
    if (_permissionDenied(statues)) {
      if (Platform.isIOS) {
        SystemAuthoritySheet().show(context);
      } else {
        YLZToastUtils.showToast("未开启运荔枝文件管理权限，请在设置中开启后重试");
      }
    }
    if (_permanentlyDenied(statues)) {
      SystemAuthoritySheet().show(context);
      return null;
    }
    return null;
  }

  static Future<List<String>?> _byGalleryList(
      BuildContext context, Map<Permission, PermissionStatus> statues,
      {int maxAssets = 1}) async {
    if (_permissionGranted(statues)) {
      List<AssetEntity>? assets = await AssetPicker.pickAssets(context,
          maxAssets: maxAssets, requestType: RequestType.image);
      if (assets.isEmptyNullList) return null;

      ProgressHUD.showLoading(context: context, text: '处理中...');

      List<String> imagePathList = <String>[];
      await for (AssetEntity asset in Stream.fromIterable(assets!)) {
        File? imageFile = await asset.file.timeout(Duration(seconds: 5));
        print('selected file path = ${imageFile?.path}');

        if (imageFile == null) {
          YLZToastUtils.showToast('图片内容异常，请重新选择图片');
          return null;
        }
        String? imagePath = await _compressImage(imageFile);
        if (imagePath.isNotTextEmpty) {
          imagePathList.add(imagePath!);
        }
      }
      ProgressHUD.dismissAllHUD();
      return imagePathList;
    }

    if (_permissionDenied(statues)) {
      if (Platform.isIOS) {
        SystemAuthoritySheet().show(context);
      } else {
        YLZToastUtils.showToast("未开启运荔枝文件管理权限，请在设置中开启后重试");
      }
    }
    if (_permanentlyDenied(statues)) {
      SystemAuthoritySheet().show(context);
      return null;
    }
    return null;
  }

  static Future<String?> _compressImage(File imageFile) async {
    int imageLengthBytes =
        await imageFile.length().timeout(Duration(seconds: 5), onTimeout: () {
      return maxImageLengthMB.toInt() * 1024 * 1024 - 1; //计算大小超时，走压缩逻辑
    }).catchError((e) {
      YLZToastUtils.showToast('图片有误，请重试');
    }).whenComplete(() {});

    if (imageLengthBytes == 0) {
      YLZToastUtils.showToast('图片内容异常，请重新选择图片');
      return null;
    }

    double imageLengthMb = imageLengthBytes / 1024 / 1024;
    if (imageLengthMb <= minImageLengthMB) {
      return imageFile.path;
    } else if (imageLengthMb > minImageLengthMB &&
        imageLengthMb < maxImageLengthMB) {
      String filePath = imageFile.path;
      Directory tempDir = await getTemporaryDirectory();
      String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
      int randomInt = new Random().nextInt(100000);
      final Directory _imageDirectory =
          await new Directory('${tempDir.path}/tempImage/')
              .create(recursive: true);
      final targetPath = _imageDirectory.path +
          "/ylz_driver_compressed_${timeStamp}_$randomInt.jpg";

      ///清理一下缓存.
      File? newFile;
      try {
        newFile = await FlutterImageCompress.compressAndGetFile(
            filePath, targetPath,
            quality: 35);
      } catch (_) {}
      if (newFile == null) {
        YLZToastUtils.showToast('图片压缩失败，请重试');
        return null;
      }
      return newFile.path;
    } else {
      YLZToastUtils.showToast(
          '图片超过${maxImageLengthMB.toInt()}MB，可能导致手机卡顿或死机，请选择小于${maxImageLengthMB.toInt()}MB的图片后重试');
      return null;
    }
  }

  static bool _permanentlyDenied(Map<Permission, PermissionStatus> statues) {
    return statues.values
            .firstWhereOrNull((element) => element.isPermanentlyDenied) !=
        null;
  }

  static bool _permissionDenied(Map<Permission, PermissionStatus> statues) {
    return statues.values.firstWhereOrNull((element) => element.isDenied) !=
        null;
  }

  static bool _permissionGranted(Map<Permission, PermissionStatus> statues) {
    return statues.values.firstWhereOrNull((element) => !element.isGranted) ==
        null;
  }
}
