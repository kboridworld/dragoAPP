import 'package:dragoma/widgets/seekbar/seekbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lib_ylz_upgrade_package/lib_ylz_upgrade_package.dart';
import 'package:provider/provider.dart';
import 'package:dragoma/common/res/dimens.dart';
import 'package:dragoma/common/res/styles.dart';
import 'package:dragoma/widgets/image_loader.dart';
import 'package:dragoma/widgets/comm_btn_widget.dart';

class AppUpgradeDialogWidget extends StatefulWidget {
  @override
  _AppUpgradeDialogWidgetState createState() => _AppUpgradeDialogWidgetState();
}

class _AppUpgradeDialogWidgetState extends State<AppUpgradeDialogWidget> {
  @override
  Widget build(BuildContext context) {
    double contentWidth = MediaQuery.of(context).size.width * 0.8;
    final upgradeViewModel =
        Provider.of<UpgradeViewModel>(context, listen: false);

    return AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: const EdgeInsets.symmetric(vertical: 1, horizontal: 1),
      content: Container(
        width: contentWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  padding: EdgeInsets.only(top: 100),
                  margin: EdgeInsets.only(top: 48),
                  child: Column(
                    children: <Widget>[
                      Text(
                        upgradeViewModel.upgradeModel?.title ?? '发现新版本',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff171717),
                            fontSize: 24),
                      ),
                      Container(
                        width: contentWidth, //Adapt.px(524),
                        height: contentWidth / 2,
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 12),
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Text(
                            upgradeViewModel.upgradeModel?.content ?? '',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Color(0xff171717),
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Consumer<UpgradeViewModel>(
                          builder: (context, model, child) {
                            return !model.isDownLoading
                                ? Container(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: CommonBtnWidget.buttonWidget(
                                        context, _getSureBtnString(model), () {
                                      model.downloadAndInstall();
                                    }, width: contentWidth - 40, fontSize: 15))
                                : _seekBar(model.downloadProgress.toDouble());
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Container(
                    child: ImageLoader(
                      'comm/icon_app_upgrade',
                      width: 200,
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  ),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              color: Colors.transparent,
              child: Center(
                child: upgradeViewModel.upgradeModel?.force == true
                    ? SizedBox.shrink()
                    : IconButton(
                        icon: ImageLoader(
                          'comm/icon_close',
                        ),
                        iconSize: 24,
                        onPressed: () {
                          Get.back();
                        },
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }

  ///进度条
  Widget _seekBar(double value) {
    return Container(
      height: Dimens.button_normal_height,
      margin: EdgeInsets.fromLTRB(20, 4, 20, 0),
      child: Center(
          child: Column(
        children: [
          SeekBar(
            value: value,
            min: 0,
            max: 100,
            backgroundColor: Color(0xFFF1F1F1),
            progressColor: ColorValues.primaryColor,
            hideBubble: false,
            alwaysShowBubble: true,
            bubbleRadius: 14,
            bubbleWidth: 40,
            bubbleHeight: 20,
            bubbleColor: Color(0xFFEFF0F0),
            bubbleTextColor: ColorValues.primaryColor,
            bubbleMargin: 10,
            bubbleTextSize: 14,
            isCanTouch: false,
          ),
          Container(
              margin: EdgeInsets.only(top: 12),
              child: Text(
                value >= 100 ? '下载完成' : '正在努力下载…',
                style:
                    TextStyle(fontSize: 12, color: ColorValues.descriptionText),
              )),
        ],
      )),
    );
  }

  String _getSureBtnString(UpgradeViewModel upgradeViewModel) {
    if (upgradeViewModel.downloadStatus == DownloadStatus.EMPTY) {
      return '立即升级';
    } else if (upgradeViewModel.downloadStatus == DownloadStatus.APART) {
      return '继续下载';
    } else if (upgradeViewModel.downloadStatus == DownloadStatus.COMPLETE) {
      return '立即安装';
    }
    return '';
  }
}
