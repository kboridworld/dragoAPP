import 'package:dragoma/common/res/styles.dart';
import 'package:dragoma/pages/base/wrap_bi_controller.dart';
import 'package:dragoma/utils/log/ylz_log.dart';
import 'package:dragoma/utils/log/ylz_log_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pedometer/pedometer.dart';

///
/// 页面2
class TwoPage extends GetView<TwoTabController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorValues.background,
      appBar: AppBar(title: Text('TwoPage')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Steps taken:',
              style: TextStyle(fontSize: 30),
            ),
            Obx(() => Text(
                  controller.steps.value,
                  style: TextStyle(fontSize: 60),
                )),
            Divider(
              height: 100,
              thickness: 0,
              color: Colors.white,
            ),
            Text(
              'Pedestrian status:',
              style: TextStyle(fontSize: 30),
            ),
            Obx(() => Icon(
                  controller.status.value == 'walking'
                      ? Icons.directions_walk
                      : controller.status.value == 'stopped'
                          ? Icons.accessibility_new
                          : Icons.error,
                  size: 100,
                )),
            Obx(() => Center(
                  child: Text(
                    controller.status.value,
                    style: controller.status.value == 'walking' ||
                            controller.status.value == 'stopped'
                        ? TextStyle(fontSize: 30)
                        : TextStyle(fontSize: 20, color: Colors.red),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

class TwoTabController extends WrapBIController {
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  var status = 'unknown'.obs;
  var steps = '0'.obs;

  @override
  void onInit() {
    _initPlatformState();
    super.onInit();
  }

  void _initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(_onPedestrianStatusChanged)
        .onError(_onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(_onStepCount).onError(_onStepCountError);
  }

  void _onStepCount(StepCount event) {
    print(event);
    steps.value = event.steps.toString();
    YLZLogUtil.doRecord('计步信息更新:${steps.value}',
        print: true, type: YLZLogType.plainText, source: YLZLogSource.debug);
  }

  void _onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    status.value = event.status;
    YLZLogUtil.doRecord('计步状态更新:${status.value}',
        print: true, type: YLZLogType.plainText, source: YLZLogSource.debug);
  }

  void _onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    status.value = 'Pedestrian Status not available';
    YLZLogUtil.doRecord('计步状态更新Error:${status.value}, $error',
        print: true, type: YLZLogType.plainText, source: YLZLogSource.debug);
  }

  void _onStepCountError(error) {
    print('onStepCountError: $error');
    steps.value = 'Step Count not available';
    YLZLogUtil.doRecord('计步信息更新Error:${steps.value}, $error',
        print: true, type: YLZLogType.plainText, source: YLZLogSource.debug);
  }
}
