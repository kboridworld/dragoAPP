import 'package:dragoma/common/res/gaps.dart';
import 'package:dragoma/common/res/styles.dart';
import 'package:dragoma/utils/bounce_tap.dart';
import 'package:dragoma/utils/dev_utils.dart';
import 'package:dragoma/widgets/image_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lib_ylz_utils_package/lib_ylz_utils_package.dart';

class AppBarAction {
  AppBarAction({this.action, this.title, this.icon, this.textColor});

  String? title;
  Color? textColor;
  Widget? icon;
  VoidCallback? action;
}

/// 全局自定义AppBar:支持多个右侧操作按钮，操作按钮超过2个则已pop menu形式展示
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  static const double _defaultElevation = 4.0;
  static const Color _defaultShadowColor = Color(0xFF000000);

  const CustomAppBar(
      {Key? key,
      this.backgroundColor = Colors.white,
      this.title = '',
      this.backImg,
      this.actions,
      this.isBack = true,
      this.backgroundImageName,
      this.statusBarStyle,
      this.goBack,
      this.elevation})
      : super(key: key);
  final Color? backgroundColor;
  final String? backgroundImageName;
  final String title;
  final String? backImg;
  final List<AppBarAction>? actions;
  final bool isBack;
  final SystemUiOverlayStyle? statusBarStyle;
  final VoidCallback? goBack;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    Color _bgColor =
        this.backgroundColor ?? Theme.of(context).scaffoldBackgroundColor;
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    Widget back = this.isBack
        ? BounceTap(
            onPressed: () {
              if (this.goBack != null) {
                goBack?.call();
              } else {
                FocusManager.instance.primaryFocus?.unfocus();
                Navigator.maybePop(context);
              }
            },
            child: Container(
              padding: EdgeInsets.zero,
              child: backImg.isNotTextEmpty
                  ? ImageLoader(backImg!)
                  : Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                      ),
                    ),
            ),
            behavior: HitTestBehavior.opaque,
          )
        : Gaps.empty;
    var actionWidgets = _buildActionWidgets(context);
    var titleWidget = GestureDetector(
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        child: Text(
          title,
          maxLines: 1,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
          style: TextStyles.textSize17
              .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 48.0),
      ),
      onDoubleTap: () {
        DevUtils.shared.triggerDevBox();
      },
    );
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: statusBarStyle ??
          (ThemeData.estimateBrightnessForColor(_bgColor) == Brightness.dark
              ? SystemUiOverlayStyle.light
              : SystemUiOverlayStyle.dark),
      child: Material(
        color: _bgColor,
        elevation: elevation ?? _defaultElevation,
        shadowColor: _defaultShadowColor,
        child: Stack(
          children: <Widget>[
            if (backgroundImageName != null)
              ImageLoader(
                backgroundImageName!,
                fit: BoxFit.cover,
                width: mediaQueryData.size.width,
                height: mediaQueryData.padding.top + kToolbarHeight,
              ),
            SafeArea(
              child: Stack(
                alignment: Alignment.centerLeft,
                children: <Widget>[
                  titleWidget,
                  back,
                  actionWidgets,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionWidgets(BuildContext context) {
    if (this.actions == null || this.actions!.isEmptyNullList) {
      return Gaps.empty;
    }
    if (this.actions!.length > 2) {
      return Positioned(
        right: 16.0,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _buildAppBarActionItem(context, this.actions![0]),
            PopupMenuButton(
              child: const Icon(Icons.menu, color: ColorValues.primaryColor),
              offset: Offset(25, 25),
              padding: const EdgeInsets.all(1.0),
              itemBuilder: (BuildContext context) {
                List<PopupMenuItem<AppBarAction>> children = [];
                for (var i = 1; i < this.actions!.length; i++) {
                  var item = this.actions![i];
                  children.add(
                    PopupMenuItem<AppBarAction>(
                      height: 40,
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            item.icon ??
                                SizedBox(
                                  width: 20,
                                ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(item.title ?? ''),
                            ),
                          ],
                        ),
                      ),
                      value: item,
                    ),
                  );
                }
                return children;
              },
              onSelected: (AppBarAction item) {
                item.action?.call();
              },
            )
          ],
        ),
      );
    } else {
      return Positioned(
        right: 16.0,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            for (var action in this.actions!)
              _buildAppBarActionItem(context, action)
          ],
        ),
      );
    }
  }

  _buildAppBarActionItem(context, AppBarAction actionItem) {
    assert(actionItem.icon != null || !actionItem.title.isTextEmpty,
        '操作按钮必须提供图标或标题');
    if (actionItem.icon == null) {
      return ButtonTheme(
        minWidth: 40,
        height: preferredSize.height,
        child: TextButton(
          onPressed: actionItem.action,
          style: TextButton.styleFrom(
            padding: EdgeInsets.all(0),
            minimumSize: Size(40, preferredSize.height),
            splashFactory: NoSplash.splashFactory,
          ),
          child: Text(
            actionItem.title!,
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
      );
    } else if (actionItem.title.isTextEmpty) {
      return ButtonTheme(
        minWidth: 40,
        height: preferredSize.height,
        child: IconButton(
          icon: actionItem.icon!,
          color: Theme.of(context).primaryColor,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () {
            actionItem.action?.call();
          },
        ),
      );
    } else {
      return ButtonTheme(
        minWidth: 40,
        height: preferredSize.height,
        child: ElevatedButton(
          onPressed: actionItem.action,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(0),
            primary: Colors.transparent,
            onSurface: Colors.transparent,
            shadowColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            minimumSize: Size(40, preferredSize.height),
          ),
          child: Row(
            children: [
              actionItem.icon!,
              Text(
                actionItem.title!,
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
