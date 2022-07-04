import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:dragoma/application.dart';
import 'package:dragoma/pages/system/widget/app_dev_float.dart';

class DevUtils {
  static final DevUtils _instance = DevUtils._internal();

  DevUtils._internal();

  factory DevUtils() => _instance;

  static DevUtils get shared => _instance;

  OverlayEntry? _entry;
  bool _isShowing = false;
  BuildContext? _context;

  void setup(BuildContext? context) {
    if (!needDevelopTool) return;
    if (context == null) return;
    _context = context;
    _addDevBox(_context);
    _isShowing = true;
  }

  void triggerDevBox() {
    if (!needDevelopTool) return;
    if (_isShowing) {
      _entry?.remove();
    } else {
      Overlay.of(_context!)!.insert(_entry!);
    }
    _isShowing = !_isShowing;
  }

  _addDevBox(BuildContext? context) {
    if (!needDevelopTool) return;
    SchedulerBinding.instance!.addPostFrameCallback((value) {
      _entry?.remove();
      _entry = OverlayEntry(builder: (context) => AppDevFloatBox());
      Overlay.of(context!)!.insert(_entry!);
    });
  }
}
