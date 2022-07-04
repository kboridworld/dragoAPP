import 'package:dragoma/application.dart';
import 'package:dragoma/pages/base/wrap_bi_controller.dart';
import 'package:dragoma/utils/log/ylz_log_dao.dart';

class ConsoleController extends WrapBIController {

  late YLZLogDao dao;

  @override
  void onInit() {
    dao = YLZLogDao(Application.driverDB);
    super.onInit();
  }
}