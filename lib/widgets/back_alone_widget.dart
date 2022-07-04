import 'package:flutter/material.dart';
import 'package:dragoma/widgets/image_loader.dart';

///
/// 只有一个返回按钮icon的组件，一般放在页面顶部
class BackAloneWidget extends StatelessWidget {
  const BackAloneWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 48,
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).maybePop();
        },
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: ImageLoader('comm/icon_back_arrow', width: 20),
        ),
      ),
    );
  }
}
