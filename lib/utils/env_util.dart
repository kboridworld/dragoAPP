import 'package:nh_flutter_network/nh_flutter_network.dart';
import 'package:dragoma/application.dart';
import 'package:dragoma/common/const/constant.dart';
import 'package:dragoma/common/stortage_manager.dart';

class EnvUtil {

  static getCurrentEnv() {
    AppEnv _env = AppEnv.PROD;
    if (inProduction && !needDevelopTool) {
      _env = AppEnv.PROD;
    } else {
      var env = StorageManager.sharedPre.getInt(Constant.KEY_env);
      if (env == AppEnv.PROD.index) {
        _env = AppEnv.PROD;
      } else if (env == AppEnv.QA.index) {
        _env = AppEnv.QA;
      } else if (env == AppEnv.DEV.index) {
        _env = AppEnv.DEV;
      } else {
        _env = enumFromString(AppEnv.values, defaultEnv) ??
            AppEnv.PROD;
      }
    }
    return _env;
  }
}
