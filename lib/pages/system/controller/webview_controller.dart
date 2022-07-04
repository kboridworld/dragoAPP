import 'dart:async';

import 'package:dragoma/pages/base/wrap_bi_controller.dart';
import 'package:dragoma/utils/platform_utils.dart';
import 'package:get/get.dart';
import 'package:lib_ylz_webview_core_x5/webview_flutter.dart';

class WebViewerController extends WrapBIController {
  var showProgress = true.obs;
  var progress = 0.0.obs;

  late String title;
  late String url;
  final Completer<WebViewController> completer = Completer<WebViewController>();

  @override
  void onInit() {
    title = Get.arguments['title'];
    url = Get.arguments['url'];
    if (Platform.isAndroid) {
      WebView.platform = X5AndroidWebView();
    }
    super.onInit();
  }

  changeProgressShow(bool show) {
    showProgress.value = show;
  }

  updateProgress(double tmp) {
    progress.value = tmp;
  }
}
