import 'package:data_connection_checker_tv/data_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final DataConnectionChecker connectionChecker;
  static final NetworkInfoImpl _instance = NetworkInfoImpl._internal(
    DataConnectionChecker(),
  );

  factory NetworkInfoImpl() {
    return _instance;
  }

  NetworkInfoImpl._internal(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
