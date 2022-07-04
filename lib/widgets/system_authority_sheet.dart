import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dragoma/common/res/dimens.dart';
import 'package:dragoma/common/res/strings.dart';
import 'package:dragoma/common/res/styles.dart';
import 'package:dragoma/widgets/comm_btn_widget.dart';

class SystemAuthoritySheet extends StatefulWidget {
  show(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        enableDrag: false,
        isDismissible: false,
        builder: (BuildContext context) {
          return this;
        });
  }

  @override
  _SystemAuthoritySheetState createState() {
    return _SystemAuthoritySheetState();
  }
}

class _SystemAuthoritySheetState extends State<SystemAuthoritySheet> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(11)),
          color: Colors.white,
        ),
        padding: EdgeInsets.symmetric(horizontal: 12) +
            EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _header,
            SizedBox(height: 10),
            _content,
            SizedBox(height: 10),
            _footer,
          ],
        ),
      ),
    );
  }

  Widget get _header => Container(
        width: double.infinity,
        height: 48,
        alignment: Alignment.center,
        child: Text(
          '提示',
          style:
              TextStyle(color: ColorValues.primaryText, fontWeight: FontWeight.bold, fontSize: 17),
        ),
      );

  Widget get _content => Text.rich(
        TextSpan(text: '欢迎使用${YlzString.appName}APP，为确保功能正常，需要以下权限，请在系统弹窗中', children: [
          TextSpan(text: '点击允许', style: TextStyle(color: ColorValues.primWarningTips, fontSize: 15)),
          TextSpan(text: '，否则APP可能无法正常使用\n'),
          TextSpan(text: '\n    ·联系人：用于选择收货人联系方式'),
          TextSpan(text: '\n    ·定位：用于地图显示与定位'),
          TextSpan(text: '\n    ·设备信息：用于APP兼容性检测'),
        ]),
        style: TextStyle(color: ColorValues.primaryText, fontSize: 15),
      );

  Widget get _footer => Container(
        padding: EdgeInsets.symmetric(vertical: 10) +
            EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom / 2),
        child: CommonBtnWidget.buttonWidget(
          context,
          '下一步',
          () {
            Navigator.pop(context);
            openAppSettings();
          },
          width: 240,
          showBorder: true,
          titleColor: ColorValues.primaryColor,
          fontSize: Dimens.font_sp15,
        ),
      );
}
