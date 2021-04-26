// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';

import '../../../core/exceptions/api_failure.dart';
import '../../../core/exceptions/connection_failure.dart';
import '../../../core/exceptions/failure.dart';
import '../../../core/services/location.dart';
import '../data_sources/market/market_local_data_source.dart';
import '../data_sources/market/market_remote_data_source.dart';
import 'auth_repository.dart';

class MarketRepository {
  static MarketRepository? _instance;

  factory MarketRepository() {
    if (_instance == null) {
      _instance = MarketRepository._privateConstructor();
    }
    return _instance!;
  }

  MarketRepository._privateConstructor()
      : _connectionChecker = DataConnectionChecker(),
        _remoteDataSource = MarketRemoteDataSource(Dio()),
        _localDataSource = MarketLocalDataSource(),
        _authRepo = AuthRepository();

  final String connectionFailedMsg = "دسترسی به اینترنت امکان‌پذیر نمی‌باشد!";
  final DataConnectionChecker _connectionChecker;
  final MarketRemoteDataSource _remoteDataSource;
  // ignore: unused_field
  final MarketLocalDataSource _localDataSource;
  final AuthRepository _authRepo;

  Future<Either<Failure, dynamic>> save({
    required String id,
    required String name,
    required String phone,
    required String telephone,
    required String email,
    required String address,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var position = await LocationService.getSavedLocation();
      var result = await _remoteDataSource.save(
        userToken,
        "${position.latitude}",
        "${position.longitude}",
        id,
        name,
        phone,
        telephone,
        email,
        address,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, dynamic>> getCustomerProfile() async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var position = await LocationService.getSavedLocation();
      var result = await _remoteDataSource.getCustomerProfile(
        userToken,
        "${position.latitude}",
        "${position.longitude}",
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, dynamic>> changeMarketProfile({
    required String id,
    required String name,
    required String phone,
    required String telephone,
    required String email,
    required String address,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var position = await LocationService.getSavedLocation();
      var result = await _remoteDataSource.changeMarketProfile(
        userToken,
        "${position.latitude}",
        "${position.longitude}",
        id,
        name,
        phone,
        telephone,
        email,
        address,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, dynamic>> openCloseMarket() async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var position = await LocationService.getSavedLocation();
      var result = await _remoteDataSource.openCloseMarket(
        userToken,
        "${position.latitude}",
        "${position.longitude}",
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, dynamic>> updateMarketDefaultHours() async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var position = await LocationService.getSavedLocation();
      var result = await _remoteDataSource.updateMarketDefaultHours(
        userToken,
        "${position.latitude}",
        "${position.longitude}",
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, dynamic>> getMarketDefaultHours() async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var position = await LocationService.getSavedLocation();
      var result = await _remoteDataSource.getMarketDefaultHours(
        userToken,
        "${position.latitude}",
        "${position.longitude}",
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, dynamic>> getMarketPhotos({
    required String photoId,
    required int take,
    required int skip,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var position = await LocationService.getSavedLocation();
      var result = await _remoteDataSource.getMarketPhotos(
        userToken,
        "${position.latitude}",
        "${position.longitude}",
        photoId,
        take,
        skip,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, dynamic>> addMarketPhoto({
    required String photo,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var position = await LocationService.getSavedLocation();
      var result = await _remoteDataSource.addMarketPhoto(
        userToken,
        "${position.latitude}",
        "${position.longitude}",
        photo,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, dynamic>> removeMarketPhoto({
    required String photoId,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var position = await LocationService.getSavedLocation();
      var result = await _remoteDataSource.removeMarketPhoto(
        userToken,
        "${position.latitude}",
        "${position.longitude}",
        photoId,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }
}
