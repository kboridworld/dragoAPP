import 'dart:io';

import 'package:dragoma/common/res/dimens.dart';
import 'package:dragoma/common/res/gaps.dart';
import 'package:dragoma/common/res/strings.dart';
import 'package:dragoma/common/res/styles.dart';
import 'package:dragoma/pages/login/user_model.dart';
import 'package:dragoma/pages/system/controller/system_info_controller.dart';
import 'package:dragoma/utils/bounce_tap.dart';
import 'package:dragoma/utils/toast_utils.dart';
import 'package:dragoma/widgets/app_bar.dart';
import 'package:dragoma/widgets/image_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SystemInfoPage extends GetView<SystemInfoController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorValues.background,
      appBar: CustomAppBar(
        title: '软件版本',
      ),
      body: GetBuilder(builder: (controller) => _buildContent()),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          _buildHeader(),
          Divider(
            thickness: Dimens.gap_dp10,
            color: ColorValues.background,
          ),
          _buildItemContent(),
          Text(
            '遇到软件问题请将本页面截图发给技术人员',
            style: TextStyles.textSize12.copyWith(color: Colors.grey),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          SizedBox(height: 20 + Get.mediaQuery.padding.bottom / 2)
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Dimens.gap_dp16, vertical: Dimens.gap_dp16),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          ..._buildIconHeader(),
          _updateRow(controller.needUpdate)
        ],
      ),
    );
  }

  List<Widget> _buildIconHeader() {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                    color: ColorValues.grey_ccc,
                    blurRadius: 5.0,
                    spreadRadius: 2.0),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: ImageLoader(
                'logo/ic_launcher',
                width: 80,
                height: 80,
              ),
            ),
          ),
        ],
      ),
      Gaps.vGap10,
      Text(
        YlzString.appName,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      Gaps.vGap6,
      Text(
        '${controller.appDisplayVersion}',
        style: TextStyle(color: ColorValues.primaryOrange),
      ),
      SizedBox(
        height: 10,
      )
    ];
  }

  Widget _buildItemContent() {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Dimens.gap_dp16, vertical: Dimens.gap_dp16),
      margin: EdgeInsets.only(bottom: Dimens.gap_dp10),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          _normalRow('用户名', UserModel.shareInstance.realName),
          _divider(),
          _normalRow('登录手机号', UserModel.shareInstance.telPhone),
          _divider(),
          _normalRow('手机机型', controller.deviceName),
          _divider(),
          _normalRow('系统版本', controller.systemVersion),
          _divider(),
          if (Platform.isAndroid) ...[
            _normalRow('厂商版本', controller.fingerprint),
            _divider(),
          ],
          _normalRow('分辨率', _pixel),
          _divider(),
          _normalRow('DeviceID', controller.deviceID),
        ],
      ),
    );
  }

  MediaQueryData get _queryData => Get.mediaQuery;

  String get _pixel =>
      (_queryData.size.width * _queryData.devicePixelRatio).toStringAsFixed(0) +
      '*' +
      (_queryData.size.height * _queryData.devicePixelRatio)
          .toStringAsFixed(0) +
      '(' +
      _queryData.devicePixelRatio.toString() +
      'x' +
      ')';

  Widget _updateRow(bool hasUpdate) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text('检查更新'),
        ),
        if (hasUpdate)
          BounceTap(
            child: Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 62,
                  height: 22,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(11)),
                      color: ColorValues.primWarningTips),
                  child: Text(
                    '有新版本',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                SizedBox(width: 5),
                ImageLoader('comm/icon_right_arrow', width: 16)
              ],
            ),
            onPressed: () => controller.updateController.updateDownload(),
          )
        else
          Text(
            "已是最新版",
            style: TextStyles.textSize12
                .copyWith(color: ColorValues.descriptionText),
          ),
      ],
    );
  }

  Widget _normalRow(String title, String description) {
    return GestureDetector(
      onLongPress: () {
        YLZToastUtils.showToast('已复制');
        Clipboard.setData(ClipboardData(text: '$title\n$description'));
      },
      child: Row(
        children: <Widget>[
          Text(
            title,
            style: TextStyle(color: ColorValues.primaryText, fontSize: 14),
          ),
          Gaps.hGap12,
          Expanded(
            child: Text(
              description,
              textAlign: TextAlign.right,
              style: TextStyle(color: ColorValues.grey_ccc, fontSize: 14),
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              maxLines: 5,
            ),
          )
        ],
      ),
    );
  }

  Divider _divider() {
    return Divider(
      height: 20,
      color: ColorValues.divider_ebedf0,
    );
  }
}
