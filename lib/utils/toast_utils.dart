import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lib_ylz_ui_kit_package/ProgressHUD/spin_kit_wave.dart';
import 'package:lib_ylz_utils_package/extension/text_utils.dart';

class YLZToastUtils {
  static void showToast(String text,
      {int duration = 2, VoidCallback? onDismiss}) {
    BotToast.showText(
      duration: Duration(seconds: duration),
      text: text,
      align: Alignment.center,
      textStyle: TextStyle(fontSize: 14, color: Colors.white),
      borderRadius: BorderRadius.all(Radius.circular(5)),
      onClose: onDismiss,
    );
  }

  static void showLoading({String? text}) {
    var contentWidget = Container(
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      decoration: BoxDecoration(
        color: Colors.black38,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            width: 50,
            height: 50,
            child: SpinKitWave(
              size: 40,
              color: Colors.white,
              type: SpinKitWaveType.start,
            ),
          ),
          if (text.isNotTextEmpty)
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(text!,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center),
            ),
        ],
      ),
    );

    var bg = Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.transparent,
        ),
        contentWidget
      ],
    );

    BotToast.showCustomLoading(
      backgroundColor: Colors.transparent,
      toastBuilder: (_) {
        return bg;
      },
    );
  }
}
