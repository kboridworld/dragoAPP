import 'dart:async';

class _ThrottleTarget {
  final Function target;
  final List<dynamic> positionalArguments;
  final Map<Symbol, dynamic> namedArguments;

  _ThrottleTarget(this.target, this.positionalArguments, this.namedArguments);
}

Map<String, dynamic> _throttled = {};

///
/// 节流
/// 在触发事件时，立即执行目标操作，同时给出一个延迟的时间，在该时间范围内如果再次触发了事件，该次事件会被忽略，直到超过该时间范围后触发事件才会被处理。
void throttle(Function target, {int tapInterval = 500}) {
  _throttleInner(Duration(milliseconds: tapInterval), target);
}

void _throttleInner(Duration timeout, Function target,
    [List<dynamic> positionalArguments = const [],
      Map<Symbol, dynamic> namedArguments = const {}]) {
  if (_throttled.containsKey(target.toString())) {
    return;
  }

  Function.apply(target, positionalArguments, namedArguments);
  _ThrottleTarget throttleTarget =
  _ThrottleTarget(target, positionalArguments, namedArguments);
  _throttled[target.toString()] = throttleTarget;
  Timer(timeout, () {
    _throttled.remove(target.toString());
  });
}

Timer? timer;

///
/// 防抖
/// 在触发事件时，不立即执行目标操作，而是给出一个延迟的时间，在该时间范围内如果再次触发了事件，则重置延迟时间，直到延迟时间结束才会执行目标操作。
void debounce(Function func, {int milliseconds = 500}) {
  Duration delay = Duration(milliseconds: milliseconds);
  void Function() target = () {
    if (timer?.isActive ?? false) {
      timer?.cancel();
    }
    timer = Timer(delay, () {
      func.call();
      timer?.cancel();
    });
  };
  return target.call();
}
