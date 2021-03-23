import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../core/consts/consts.dart';

class AuthLocalDataSource {
  AuthLocalDataSource() : _secureStorage = FlutterSecureStorage();

  final FlutterSecureStorage _secureStorage;

  Future<void> saveUserId(String userId) async {
    await _secureStorage.write(
      key: storageKeyUserId,
      value: userId,
    );
  }

  Future<void> saveUserToken(String userToken) async {
    await _secureStorage.write(
      key: storageKeyUserToken,
      value: userToken,
    );
  }

  Future<void> saveUserType(String userType) async {
    await _secureStorage.write(
      key: storageKeyUserType,
      value: userType,
    );
  }

  Future<String> get userId async {
    return await _secureStorage.read(
      key: storageKeyUserId,
    );
  }

  Future<String> get userToken async {
    return await _secureStorage.read(
      key: storageKeyUserToken,
    );
  }

  Future<String> get userType async {
    return await _secureStorage.read(
      key: storageKeyUserType,
    );
  }
}
