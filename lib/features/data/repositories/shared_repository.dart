// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';

import '../../../core/exceptions/api_failure.dart';
import '../../../core/exceptions/connection_failure.dart';
import '../../../core/exceptions/failure.dart';
import '../data_sources/shared/shared_local_data_source.dart';
import '../data_sources/shared/shared_remote_data_source.dart';

class SharedRepository {
  static SharedRepository? _instance;

  factory SharedRepository() {
    if (_instance == null) {
      _instance = SharedRepository._privateConstructor();
    }
    return _instance!;
  }

  SharedRepository._privateConstructor()
      : _connectionChecker = DataConnectionChecker(),
        _remoteDataSource = SharedRemoteDataSource(Dio()),
        _localDataSource = SharedLocalDataSource();

  final String connectionFailedMsg = "دسترسی به اینترنت امکان‌پذیر نمی‌باشد!";
  final DataConnectionChecker _connectionChecker;
  final SharedRemoteDataSource _remoteDataSource;
  // ignore: unused_field
  final SharedLocalDataSource _localDataSource;

  Future<Either<Failure, dynamic>> getProductPhoto({required String id}) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      try {
        var result = await _remoteDataSource.getProductPhoto(id);
        return Right(result);
      } catch (error) {
        return Left(ApiFailure("$error"));
      }
    }
  }

  Future<Either<Failure, dynamic>> getMarketPhoto({required String id}) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      try {
        var result = await _remoteDataSource.getMarketPhoto(id);
        return Right(result);
      } catch (error) {
        return Left(ApiFailure("$error"));
      }
    }
  }

  Future<Either<Failure, dynamic>> getMarketCategoryPhoto(
      {required String id}) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      try {
        var result = await _remoteDataSource.getMarketCategoryPhoto(id);
        return Right(result);
      } catch (error) {
        return Left(ApiFailure("$error"));
      }
    }
  }

  Future<Either<Failure, dynamic>> getMainCategoryPhoto(
      {required String id}) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      try {
        var result = await _remoteDataSource.getMainCategoryPhoto(id);
        return Right(result);
      } catch (error) {
        return Left(ApiFailure("$error"));
      }
    }
  }

  Future<Either<Failure, dynamic>> getSubCategoryPhoto(
      {required String id}) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      try {
        var result = await _remoteDataSource.getSubCategoryPhoto(id);
        return Right(result);
      } catch (error) {
        return Left(ApiFailure("$error"));
      }
    }
  }
}
