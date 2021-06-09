// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';

import '../../../core/exceptions/api_failure.dart';
import '../../../core/exceptions/connection_failure.dart';
import '../../../core/exceptions/failure.dart';
import '../data_sources/shared_user/shared_user_local_data_source.dart';
import '../data_sources/shared_user/shared_user_remote_data_source.dart';
import '../models/base_api_result_model.dart';
import '../models/customer/agreement_result_model.dart';

class SharedUserRepository {
  static SharedUserRepository? _instance;

  factory SharedUserRepository() {
    if (_instance == null) {
      _instance = SharedUserRepository._privateConstructor();
    }
    return _instance!;
  }

  SharedUserRepository._privateConstructor()
      : _connectionChecker = DataConnectionChecker(),
        _remoteDataSource = SharedUserRemoteDataSource(Dio()),
        _localDataSource = SharedUserLocalDataSource();

  final String connectionFailedMsg = "دسترسی به اینترنت امکان‌پذیر نمی‌باشد!";
  final DataConnectionChecker _connectionChecker;
  final SharedUserRemoteDataSource _remoteDataSource;
  final SharedUserLocalDataSource _localDataSource;

  Future<Either<Failure, String>> login({
    required String username,
    required String password,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final lang = await userLang;

      var result = await _remoteDataSource.login(
        lang,
        username,
        password,
      );

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

  Future<Either<Failure, String>> register({
    required String name,
    required String phone,
    required String pass,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final lang = await userLang;
      var result = await _remoteDataSource.register(
        lang,
        name,
        phone,
        pass,
      );

      if (result.success) {
        final userId = result.data.userId;

        await _localDataSource.saveUserId(userId);

        return Right(userId);
      } else {
        return Left(ApiFailure(result.message));
      }
    }
  }

  Future<Either<Failure, String>> confirmRegistration({
    required String sms,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final lang = await userLang;
      final userId = await this.userId ?? "";

      var result = await _remoteDataSource.confirmRegistration(
        lang,
        userId,
        sms,
      );

      if (result.success) {
        final userToken = result.data.token;

        await _localDataSource.saveUserToken(userToken);

        return Right(userToken);
      } else {
        return Left(ApiFailure(result.message));
      }
    }
  }

  Future<Either<Failure, String>> checkToken({
    required String token,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final lang = await userLang;
      var result = await _remoteDataSource.checkToken(lang, token);

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

  Future<Either<Failure, BaseApiResultModel>> resetPasswordRequest({
    required String phone,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final lang = await userLang;

      var result = await _remoteDataSource.resetPasswordRequest(lang, phone);

      return (result.success)
          ? Right(result)
          : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, BaseApiResultModel>> resetPassword({
    required String phone,
    required String sms,
    required String password,
    required String passwordRepeat,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final lang = await userLang;

      var result = await _remoteDataSource.resetPassword(
        lang,
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

  Future<Either<Failure, AgreementResultModel>> getRulesText() async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final lang = await userLang;

      var result = await _remoteDataSource.getRulesText(lang);

      return (result.success)
          ? Right(result)
          : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, AgreementResultModel>> getPrivacyText() async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final lang = await userLang;

      var result = await _remoteDataSource.getPrivacyText(lang);

      return (result.success)
          ? Right(result)
          : Left(ApiFailure(result.message));
    }
  }

  Future<String?> get userId async {
    return await _localDataSource.userId;
  }

  Future<String?> get userToken async {
    return await _localDataSource.userToken;
  }

  Future<String?> get userType async {
    return await _localDataSource.userType;
  }

  Future<String?> get userLang async {
    return await _localDataSource.userLang ?? "fa";
  }
}
