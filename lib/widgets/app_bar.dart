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
  const CustomAppBar(
      {Key? key,
      this.backgroundColor = Colors.white,
      this.title = '',
      this.backImg,
      this.actions,
      this.isBack = true,
      this.backgroundImageName,
      this.statusBarStyle = SystemUiOverlayStyle.dark,
      this.goBack,
      this.elevation})
      : super(key: key);
  final Color? backgroundColor;
  final String? backgroundImageName;
  final String title;
  final String? backImg;
  final List<AppBarAction>? actions;
  final bool isBack;
  final SystemUiOverlayStyle statusBarStyle;
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
      value: statusBarStyle,
      child: Material(
        color: _bgColor,
        elevation: elevation ?? Theme.of(context).appBarTheme.elevation ?? 0,
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
            _buildAppBarActionItem(this.actions![0]),
            PopupMenuButton(
              child: const Icon(
                Icons.menu,
                color: Colors.white,
                size: 20,
              ),
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
            for (var action in this.actions!) _buildAppBarActionItem(action)
          ],
        ),
      );
    }
  }

  _buildAppBarActionItem(AppBarAction actionItem) {
    assert(actionItem.icon != null || !actionItem.title.isTextEmpty,
        '操作按钮必须提供图标或标题');
    if (actionItem.icon == null) {
      return ButtonTheme(
        minWidth: 40,
        height: 44,
        child: FlatButton(
          padding: const EdgeInsets.all(0),
          highlightColor: Colors.transparent,
          child: Text(actionItem.title!),
          textColor: Colors.white,
          onPressed: () {
            actionItem.action?.call();
          },
        ),
      );
    } else if (actionItem.title.isTextEmpty) {
      return ButtonTheme(
        minWidth: 40,
        height: 44,
        child: IconButton(
          icon: actionItem.icon!,
          color: Colors.white,
          onPressed: () {
            actionItem.action?.call();
          },
        ),
      );
    } else {
      return ButtonTheme(
        minWidth: 40,
        height: 44,
        child: FlatButton.icon(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
          icon: actionItem.icon!,
          highlightColor: Colors.transparent,
          label: Text(actionItem.title!),
          textColor: Colors.white,
          onPressed: () {
            actionItem.action?.call();
          },
        ),
      );
    }
  }

  @override
  Size get preferredSize => Size.fromHeight(44.0);
}
