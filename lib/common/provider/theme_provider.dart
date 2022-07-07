import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lib_ylz_ui_kit_package/lib_ylz_ui_kit_package.dart';
import 'package:lib_ylz_utils_package/lib_ylz_utils_package.dart';
import 'package:dragoma/common/const/constant.dart';
import 'package:dragoma/common/res/styles.dart';
import 'package:dragoma/common/stortage_manager.dart';
import 'package:dragoma/main.dart';

extension ThemeModeExtension on ThemeMode {
  String get value => <String>['system', 'light', 'dark'][index];
}

class ThemeProvider extends BasicStateModel {
  void syncTheme() {
    final String? theme =
        StorageManager.sharedPre.getString(Constant.KEY_theme);
    if (theme.isNotTextEmpty && theme != ThemeMode.system.value) {
      notifyListeners();
    }
  }

  void setTheme(ThemeMode themeMode) {
    StorageManager.sharedPre.setString(Constant.KEY_theme, themeMode.value);
    notifyListeners();
  }

  ThemeMode getThemeMode() {
    final String theme =
        StorageManager.sharedPre.getString(Constant.KEY_theme) ??
            'light'; //暂时不跟随系统，默认light
    switch (theme) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }

  ThemeData getTheme({bool isDarkMode = false}) {
    return ThemeData(
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      primarySwatch: DriverApp.greenTheme,
      primaryColor: isDarkMode ? Colors.white : ColorValues.primaryColor,
      colorScheme:
          ColorScheme.fromSwatch(primarySwatch: DriverApp.greenTheme).copyWith(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        // secondary: isDarkMode ? Colors.black : ColorValues.primaryColor,
      ),
      dividerColor: isDarkMode ? Color(0xFF1F1F1F) : ColorValues.divider_ebedf0,
      // Tab指示器颜色
      indicatorColor:
          isDarkMode ? ColorValues.primaryColor : ColorValues.primaryColor,
      // 页面背景色
      scaffoldBackgroundColor: isDarkMode ? Colors.black : ColorValues.background,
      // 主要用于Material背景色
      canvasColor: isDarkMode ? Color(0xFF141414) : Colors.white,
      cardColor: isDarkMode ? Color(0xFF1F1F1F) : ColorValues.background,
      // 文字选择色（输入框选择文字等）
      // textSelectionColor: Colours.app_main.withAlpha(70),
      // textSelectionHandleColor: Colours.app_main,
      // 稳定版：1.23 变更(https://flutter.dev/docs/release/breaking-changes/text-selection-theme)
      // textSelectionTheme: TextSelectionThemeData(
      //   selectionColor: Colours.app_main.withAlpha(70),
      //   selectionHandleColor: Colours.app_main,
      //   cursorColor: Colours.app_main,
      // ),
      textTheme: TextTheme(
          headline1: isDarkMode
              ? TextStyles.textSize22
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold)
              : TextStyles.textSize22.copyWith(
                  color: ColorValues.primaryText, fontWeight: FontWeight.bold),
          headline2: isDarkMode
              ? TextStyles.textSize17.copyWith(color: Color(0xFFD9D9D9))
              : TextStyles.textSize17.copyWith(color: ColorValues.primaryText),
          headline3: isDarkMode
              ? TextStyles.textSize14
                  .copyWith(color: ColorValues.descriptionText)
              : TextStyles.textSize14.copyWith(color: ColorValues.primaryText),
          headline4: isDarkMode
              ? TextStyles.textSize15.copyWith(color: ColorValues.primaryColor)
              : TextStyles.textSize15.copyWith(color: ColorValues.primaryText),
          subtitle1: isDarkMode
              ? TextStyles.textSize14
                  .copyWith(color: ColorValues.descriptionText)
              : TextStyles.textSize14.copyWith(color: ColorValues.summaryText),
          bodyText1: isDarkMode
              ? TextStyles.textSize12.copyWith(color: ColorValues.summaryText)
              : TextStyles.textSize12.copyWith(color: Color(0xFFA6A6A6))),
      appBarTheme: AppBarTheme(
        elevation: 6,
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        systemOverlayStyle:
            isDarkMode ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
        titleTextStyle: isDarkMode
            ? TextStyles.textSize17.copyWith(
                color: ColorValues.descriptionText, fontWeight: FontWeight.bold)
            : TextStyles.textSize17.copyWith(
                color: ColorValues.primaryText, fontWeight: FontWeight.bold),
        actionsIconTheme:
            IconThemeData(color: isDarkMode ? Colors.white : Colors.black),
        iconTheme:
            IconThemeData(color: isDarkMode ? Colors.white : Colors.black),
      ),
      cupertinoOverrideTheme: CupertinoThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),
      visualDensity: VisualDensity
          .standard, // https://github.com/flutter/flutter/issues/77142
    );
  }
}
