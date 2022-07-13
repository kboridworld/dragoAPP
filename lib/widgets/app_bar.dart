import 'package:dragoma/common/res/gaps.dart';
import 'package:dragoma/common/res/styles.dart';
import 'package:dragoma/utils/dev_utils.dart';
import 'package:dragoma/widgets/image_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lib_ylz_utils_package/lib_ylz_utils_package.dart';

class AppBarAction {
  AppBarAction({this.action, this.title, this.icon});

  String? title;
  Widget? icon;
  VoidCallback? action;
}

///
/// 全局自定义AppBar:支持多个右侧操作按钮，操作按钮超过2个则已pop menu形式展示
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  static const double _defaultElevation = 4.0;
  static const Color _defaultShadowColor = Color(0xFF000000);

  const CustomAppBar(
      {Key? key,
      required this.title,
      this.bgColor,
      this.backImg,
      this.actions,
      this.isBack = true,
      this.bgImage,
      this.statusBarStyle,
      this.goBack,
      this.elevation})
      : super(key: key);
  final Color? bgColor;
  final String? bgImage;
  final String title;
  final String? backImg;
  final List<AppBarAction>? actions;
  final bool isBack;
  final SystemUiOverlayStyle? statusBarStyle;
  final VoidCallback? goBack;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    Color _bgColor = this.bgColor ??
        Theme.of(context).appBarTheme.backgroundColor ??
        ColorValues.background;
    Brightness brightness = ThemeData.estimateBrightnessForColor(_bgColor);
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    Widget back = this.isBack
        ? GestureDetector(
            onTap: () {
              if (this.goBack != null) {
                goBack?.call();
              } else {
                FocusManager.instance.primaryFocus?.unfocus();
                Navigator.maybePop(context);
              }
            },
            child: Container(
              height: preferredSize.height,
              width: preferredSize.height,
              child: backImg.isNotTextEmpty
                  ? ImageLoader(backImg!)
                  : Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                      color: brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
            ),
            behavior: HitTestBehavior.opaque,
          )
        : Gaps.empty;
    var actionWidgets = _buildActionWidgets(context, brightness: brightness);
    var titleWidget = GestureDetector(
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        child: Text(
          title,
          maxLines: 1,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
          style: TextStyles.textSize20.copyWith(
            fontWeight: FontWeight.w500,
            color: brightness == Brightness.dark ? Colors.white : Colors.black,
          ),
        ),
        margin: EdgeInsets.symmetric(horizontal: preferredSize.height),
      ),
      onDoubleTap: () {
        DevUtils.shared.triggerDevBox();
      },
    );
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: statusBarStyle ??
          (brightness == Brightness.dark
              ? SystemUiOverlayStyle.light
              : SystemUiOverlayStyle.dark),
      child: Material(
        color: _bgColor,
        elevation: elevation ?? _defaultElevation,
        shadowColor: _defaultShadowColor,
        child: Stack(
          children: <Widget>[
            if (bgImage != null)
              ImageLoader(
                bgImage!,
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

  Widget _buildActionWidgets(BuildContext context,
      {Brightness brightness = Brightness.dark}) {
    if (this.actions == null || this.actions!.isEmptyNullList)
      return Gaps.empty;
    if (this.actions!.length > 2) {
      return Positioned(
        right: 0,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            PopupMenuButton(
              child: Container(
                height: preferredSize.height,
                width: preferredSize.height,
                child: Icon(Icons.more_vert,
                    color: brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black),
              ),
              itemBuilder: (BuildContext context) {
                return this
                    .actions!
                    .map((item) => PopupMenuItem<AppBarAction>(
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
                        ))
                    .toList();
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
