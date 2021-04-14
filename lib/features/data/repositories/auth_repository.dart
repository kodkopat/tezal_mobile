// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';

import '../../../core/exceptions/api_failure.dart';
import '../../../core/exceptions/connection_failure.dart';
import '../../../core/exceptions/failure.dart';
import '../data_sources/auth/auth_local_data_source.dart';
import '../data_sources/auth/auth_remote_data_source.dart';
import '../models/agreement_result_model.dart';
import '../models/base_api_result_model.dart';

class AuthRepository {
  static AuthRepository? _instance;

  factory AuthRepository() {
    if (_instance == null) {
      _instance = AuthRepository._privateConstructor();
    }
    return _instance!;
  }

  AuthRepository._privateConstructor()
      : _connectionChecker = DataConnectionChecker(),
        _remoteDataSource = AuthRemoteDataSource(Dio()),
        _localDataSource = AuthLocalDataSource();

  final String connectionFailedMsg = "دسترسی به اینترنت امکان‌پذیر نمی‌باشد!";
  final DataConnectionChecker _connectionChecker;
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  Future<Either<Failure, String>> userLogin({
    required String username,
    required String password,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      var result = await _remoteDataSource.login(username, password);

      if (result.success) {
        final userToken = result.data.token;
        await _localDataSource.saveUserToken(userToken);

        final userType = result.data.type;
        await _localDataSource.saveUserType(userType);

        return Right(userToken);
      } else {
        return Left(ApiFailure(result.message));
      }
    }
  }

  Future<Either<Failure, String>> userRegister({
    required String name,
    required String phone,
    required String pass,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      var result = await _remoteDataSource.register(name, phone, pass);

      if (result.success) {
        final userId = result.data.userId;
        await _localDataSource.saveUserId(userId);

        return Right(userId);
      } else {
        return Left(ApiFailure(result.message));
      }
    }
  }

  Future<Either<Failure, String>> checkUserSms({
    required String sms,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      var userId = await this.userId;
      print("userId: $userId\n");
      var result = await _remoteDataSource.confirmRegistration(userId, sms);

      if (result.success) {
        final userToken = result.data.token;
        await _localDataSource.saveUserToken(userToken);

        return Right(userToken);
      } else {
        return Left(ApiFailure(result.message));
      }
    }
  }

  Future<Either<Failure, String>> checkUserToken({
    required String token,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      var result = await _remoteDataSource.checkToken(token);

      if (result.success) {
        final userToken = result.data.token;
        await _localDataSource.saveUserToken(userToken);

        final userType = result.data.type;
        await _localDataSource.saveUserType(userType);

        return Right(userToken);
      } else {
        return Left(ApiFailure(result.message));
      }
    }
  }

  Future<Either<Failure, BaseApiResultModel>> requestRestPass({
    required String phone,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      var result = await _remoteDataSource.resetPasswordRequest(phone);

      return (result.success)
          ? Right(result)
          : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, BaseApiResultModel>> resetPass({
    required String phone,
    required String sms,
    required String password,
    required String passwordRepeat,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      var result = await _remoteDataSource.resetPassword(
        phone,
        sms,
        password,
        passwordRepeat,
      );

      return (result.success)
          ? Right(result)
          : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, AgreementResultModel>> get rulesText async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      var result = await _remoteDataSource.getRulesText();

      return (result.success)
          ? Right(result)
          : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, AgreementResultModel>> get privacyText async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      var result = await _remoteDataSource.getPrivacyText();

      return (result.success)
          ? Right(result)
          : Left(ApiFailure(result.message));
    }
  }

  Future<String> get userId async {
    return await _localDataSource.userId;
  }

  Future<String> get userToken async {
    return await _localDataSource.userToken;
  }

  Future<String> get userType async {
    return await _localDataSource.userType;
  }
}
