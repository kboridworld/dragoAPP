import 'package:nh_flutter_network/network/host/nh_network_host_provider.dart';
import 'package:dragoma/common/http/host/constants_host.dart';

class BfsUserHostProvider extends HostProvider {
  @override
  String get alias => Host.BfsUser;

  @override
  String get devHost => Host.BfsUser_DEV;

  @override
  String get prodHost => Host.BfsUser_PROD;

  @override
  String get qaHost => Host.BfsUser_QA;
}
