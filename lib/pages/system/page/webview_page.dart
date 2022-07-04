import 'package:dragoma/widgets/seekbar/seekbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lib_ylz_webview_core_x5/webview_flutter.dart';
import 'package:dragoma/widgets/app_bar.dart';
import 'package:dragoma/pages/system/controller/webview_controller.dart';

class WebViewPage extends GetView<WebViewerController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: controller.title),
      body: Stack(
        children: [
          WebView(
            initialUrl: controller.url,
            onWebViewCreated: controller.completer.complete,
            javascriptMode: JavascriptMode.unrestricted,
            onPageStarted: (url) {
              print('WebView onPageStarted url:$url');
              controller.changeProgressShow(true);
            },
            onProgress: (value) {
              controller.updateProgress(value.toDouble());
            },
            onPageFinished: (url) {
              print('WebView onPageFinished url:$url');
              controller.changeProgressShow(false);
            },
            navigationDelegate: (request) {
              print('WebView navigationDelegate before url:${controller.url}');
              if (request.url.startsWith('http://')) {
                request.url.replaceFirst('http://', 'https://');
              }
              print('WebView navigationDelegate after url:${controller.url}');
              return NavigationDecision.navigate;
            },
          ),
          Obx(() => Offstage(
                offstage: controller.showProgress.isFalse,
                child: SeekBar(
                  backgroundColor: Colors.transparent,
                  progresseight: 3,
                  value: controller.progress.value,
                ),
              ))
        ],
      ),
    );
  }
}
