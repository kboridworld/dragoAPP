import 'package:flutter/material.dart';

class TaskQueueHandler {
  List<VoidCallback> _taskQueue = [];

  void addTask(VoidCallback callBack) {
    _taskQueue.add(callBack);
  }

  bool contains(VoidCallback callBack) {
    return _taskQueue.contains(callBack);
  }

  void insertTask(VoidCallback callBack) {
    _taskQueue.insert(0, callBack);
  }

  bool get isEmpty {
    return _taskQueue.isEmpty;
  }

  void performNext() {
    if (isEmpty) return null;
    _taskQueue.removeAt(0)();
  }
}
