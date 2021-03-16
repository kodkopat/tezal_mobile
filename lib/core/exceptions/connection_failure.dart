import 'failure.dart';

class ConnectionFailure implements Failure {
  ConnectionFailure(this._message);

  final String _message;

  @override
  String get message => this._message;
}
