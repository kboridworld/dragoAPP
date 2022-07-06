import 'package:dragoma/utils/log/ylz_log.dart';
import 'package:dragoma/utils/log/ylz_log_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';

///页面2
class TwoPage extends StatefulWidget {
  const TwoPage({Key? key}) : super(key: key);

  @override
  State<TwoPage> createState() => _TwoPageState();
}

class _TwoPageState extends State<TwoPage> {
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = 'unknown';
  String _steps = '0';

  @override
  void initState() {
    super.initState();
    _initPlatformState();
  }

  void _onStepCount(StepCount event) {
    print(event);
    setState(() {
      _steps = event.steps.toString();
    });
    YLZLogUtil.doRecord('计步信息更新:$_steps',
        print: true, type: YLZLogType.plainText, source: YLZLogSource.debug);
  }

  void _onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    setState(() {
      _status = event.status;
    });
    YLZLogUtil.doRecord('计步状态更新:$_status',
        print: true, type: YLZLogType.plainText, source: YLZLogSource.debug);
  }

  void _onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    YLZLogUtil.doRecord('计步状态更新Error:$_status, $error',
        print: true, type: YLZLogType.plainText, source: YLZLogSource.debug);
  }

  void _onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _steps = 'Step Count not available';
    });
    YLZLogUtil.doRecord('计步信息更新Error:$_steps, $error',
        print: true, type: YLZLogType.plainText, source: YLZLogSource.debug);
  }

  void _initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(_onPedestrianStatusChanged)
        .onError(_onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(_onStepCount).onError(_onStepCountError);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TwoPage')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Steps taken:',
              style: TextStyle(fontSize: 30),
            ),
            Text(
              _steps,
              style: TextStyle(fontSize: 60),
            ),
            Divider(
              height: 100,
              thickness: 0,
              color: Colors.white,
            ),
            Text(
              'Pedestrian status:',
              style: TextStyle(fontSize: 30),
            ),
            Icon(
              _status == 'walking'
                  ? Icons.directions_walk
                  : _status == 'stopped'
                      ? Icons.accessibility_new
                      : Icons.error,
              size: 100,
            ),
            Center(
              child: Text(
                _status,
                style: _status == 'walking' || _status == 'stopped'
                    ? TextStyle(fontSize: 30)
                    : TextStyle(fontSize: 20, color: Colors.red),
              ),
            )
          ],
        ),
      ),
    );
  }
}
