import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lib_ylz_utils_package/lib_ylz_utils_package.dart';
import 'package:dragoma/widgets/fantasy_fab.dart';
import 'package:dragoma/pages/system/system_router.dart';

class AppDevFloatBox extends StatefulWidget {
  @override
  _AppDevFloatBoxState createState() => _AppDevFloatBoxState();
}

class _AppDevFloatBoxState extends State<AppDevFloatBox> {
  Offset offset = Offset(10, kToolbarHeight + 100);

  Offset _calOffset(Size size, Offset offset, Offset nextOffset) {
    double dx = 0;
    if (offset.dx + nextOffset.dx <= 0) {
      dx = 0;
    } else if (offset.dx + nextOffset.dx >= (size.width - 50)) {
      dx = size.width - 50;
    } else {
      dx = offset.dx + nextOffset.dx;
    }
    double dy = 0;
    if (offset.dy + nextOffset.dy >= (size.height - 180)) {
      dy = size.height - 180;
    } else if (offset.dy + nextOffset.dy <= kToolbarHeight) {
      dy = kToolbarHeight;
    } else {
      dy = offset.dy + nextOffset.dy;
    }
    return Offset(
      dx,
      dy,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        highlightColor: Colors.transparent,
        appBarTheme: AppBarTheme.of(context).copyWith(
          brightness: Brightness.dark,
        ),
      ),
      child: Positioned(
        left: offset.dx,
        top: offset.dy,
        child: GestureDetector(
          onPanUpdate: (detail) {
            setState(() {
              offset =
                  _calOffset(MediaQuery.of(context).size, offset, detail.delta);
            });
          },
          child: FantasyFAB(
            subActions: [
              FantasyFABItem(
                  child: FloatingActionButton(
                    onPressed: null,
                    child: Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    VibrationUtils.vibration();
                    Get.toNamed(SystemRouter.devSetting);
                  }),
              FantasyFABItem(
                  child: FloatingActionButton(
                    onPressed: null,
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    VibrationUtils.vibration();
                    Get.toNamed(SystemRouter.consolePage);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
