import 'package:flutter/material.dart';
import 'package:lib_ylz_router_package/lib_ylz_router_package.dart';

abstract class YLZPage<S extends YLZState> extends RoutePage {
  S createYLZState();

  const YLZPage({Key? key}) : super(key: key);

  @override
  S createRouteState() => createYLZState();
}

class YLZState<T extends YLZPage<dynamic>> extends RouteState<T> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didAppear(bool firstLoad) {
    super.didAppear(firstLoad);
  }

  @override
  void didDisappear() {
    super.didDisappear();
  }

  String get pageName => 'V-Page-${widget.runtimeType.toString()}';
}
