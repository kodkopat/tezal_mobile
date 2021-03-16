import 'package:dartz/dartz.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

import '../../../../core/consts/consts.dart';
import '../../../../core/exceptions/api_failure.dart';
import '../../../../core/exceptions/connection_failure.dart';
import '../../../../core/exceptions/failure.dart';
import '../data_sources/auth_remote_data_source.dart';

class AuthRepository {
  AuthRepository()
      : _connectionChecker = DataConnectionChecker(),
        _remoteDataSource = AuthRemoteDataSource(Dio()),
        _secureStorage = FlutterSecureStorage();

  final String connectionFailedMsg = "دسترسی به اینترنت امکان‌پذیر نمی‌باشد!";
  final DataConnectionChecker _connectionChecker;
  final AuthRemoteDataSource _remoteDataSource;
  final FlutterSecureStorage _secureStorage;

  Future<Either<Failure, String>> userRegister({
    @required String name,
    @required String phone,
    @required String pass,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      var result = await _remoteDataSource.register(name, phone, pass);

      if (result.success) {
        final userId = result.data;
        await _secureStorage.write(
          key: storageKeyUserId,
          value: userId,
        );

        return Right(userId);
      } else {
        return Left(ApiFailure(result.message));
      }
    }
  }

  Future<Either<Failure, String>> checkUserSms({
    @required String id,
    @required String sms,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      var result = await _remoteDataSource.checkSms(id, sms);

      if (result.success) {
        final userToken = result.data.token;
        await _secureStorage.write(
          key: storageKeyUserToken,
          value: userToken,
        );

        return Right(userToken);
      } else {
        return Left(ApiFailure(result.message));
      }
    }
  }

  Future<Either<Failure, String>> userLogin({
    @required String username,
    @required String password,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      var result = await _remoteDataSource.login(username, password);

      if (result.success) {
        final userToken = result.data.token;
        await _secureStorage.write(
          key: storageKeyUserToken,
          value: userToken,
        );

        return Right(userToken);
      } else {
        return Left(ApiFailure(result.message));
      }
    }
  }

  Future<Either<Failure, String>> checkUserToken({
    @required String token,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      var result = await _remoteDataSource.checkToken(token);

      if (result.success) {
        final userToken = result.data.token;
        await _secureStorage.write(
          key: storageKeyUserToken,
          value: userToken,
        );

        return Right(userToken);
      } else {
        return Left(ApiFailure(result.message));
      }
    }
  }
}
