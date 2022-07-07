import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('页面不存在'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: Get.back,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 120.0,
            width: 120.0,
            child: Image.asset(
              'assets/images/icon_error.png',
              package: 'lib_ylz_router_package',
            ),
          ),
          const SizedBox(
            width: double.infinity,
            height: 16,
          ),
          Text(
            '页面不存在',
            style:
                Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 22),
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
