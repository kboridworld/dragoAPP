import 'package:dragoma/common/res/dimens.dart';
import 'package:dragoma/common/res/gaps.dart';
import 'package:dragoma/common/res/styles.dart';
import 'package:dragoma/widgets/image_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lib_ylz_ui_kit_package/lib_ylz_ui_kit_package.dart';

typedef Builder = Widget Function(BuildContext context);
typedef External = bool Function();

class MultiStateWidget extends StatefulWidget {
  final Widget loadingWidget;
  final Widget emptyWidget;
  final Widget failWidget;
  final Builder builder;
  final ViewState? state;
  final bool external;

  const MultiStateWidget(
      {Key? key,
      required this.builder,
      this.state,
      this.emptyWidget = const EmptyStateWidget(),
      this.failWidget = const FailStateWidget(),
      this.loadingWidget = const LoadingStateWidget(),
      this.external = true})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _MultiStateWidgetState();
}

class _MultiStateWidgetState extends State<MultiStateWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.state == null)
      return Container(
        width: 0,
        height: 0,
      );
    if (widget.state == ViewState.CONTENT) {
      return widget.builder(context);
    } else if (widget.state == ViewState.EMPTY) {
      return widget.emptyWidget;
    } else if (widget.state == ViewState.FAIL) {
      return widget.failWidget;
    } else if (widget.state == ViewState.LOADING && widget.external == true) {
      return widget.loadingWidget;
    } else {
      return widget.builder(context);
    }
  }
}

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ImageLoader(
            "comm/icon_search_empty",
            width: 215,
            height: 130.25,
          ),
          Gaps.vGap4,
          Text(
            "暂无数据",
            style: TextStyle(
                color: ColorValues.summaryText, fontSize: Dimens.font_sp15),
          ),
        ],
      ),
    );
  }
}

class FailStateWidget extends StatelessWidget {
  final String? reason;

  const FailStateWidget({this.reason});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.error_outline,
            color: Colors.grey[300],
            size: 120,
          ),
          Text(
            "${reason ?? "加载失败,请稍后重试"}",
            style: TextStyle(color: Colors.grey[500], fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class LoadingStateWidget extends StatelessWidget {
  const LoadingStateWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          CupertinoActivityIndicator(
            radius: 20,
            animating: true,
          ),
          Gaps.vGap12,
          Text(
            "加载中...",
            style: TextStyle(color: Colors.grey[500], fontSize: 14),
          ),
        ],
      ),
    );
  }
}
