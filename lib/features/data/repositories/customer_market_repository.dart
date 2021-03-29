import 'package:dartz/dartz.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../core/exceptions/api_failure.dart';
import '../../../core/exceptions/connection_failure.dart';
import '../../../core/exceptions/failure.dart';
import '../../../core/services/location.dart';
import '../../data/data_sources/customer_market/customer_market_local_data_source.dart';
import '../../data/data_sources/customer_market/customer_market_remote_data_source.dart';
import '../models/comments_result_model.dart';
import '../models/market_detail_result_model.dart';
import '../models/nearby_markets_result_model.dart';
import '../models/photos_result_model.dart';
import 'auth_repository.dart';

class CustomerMarketRepository {
  CustomerMarketRepository()
      : _connectionChecker = DataConnectionChecker(),
        _remoteDataSource = CustomerMarketRemoteDataSource(Dio()),
        _localDataSource = CustomerMarketLocalDataSource(),
        _authRepo = AuthRepository();

  final String connectionFailedMsg = "دسترسی به اینترنت امکان‌پذیر نمی‌باشد!";
  final DataConnectionChecker _connectionChecker;
  final CustomerMarketRemoteDataSource _remoteDataSource;
  // ignore: unused_field
  final CustomerMarketLocalDataSource _localDataSource;
  final AuthRepository _authRepo;

  Future<Either<Failure, NearByMarketsResultModel>> nearByMarkets(
    BuildContext context, {
    @required int maxDistance,
    @required int count,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      var lang = Localizations.localeOf(context).languageCode;
      var position = await LocationService.getSavedLocation();

      var result = await _remoteDataSource.getNearByMarkets(
        lang,
        "${position.latitude}",
        "${position.longitude}",
        maxDistance,
        count,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, MarketDetailResultModel>> marketDetail({
    @required String marketId,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var result = await _remoteDataSource.getMarketDetail(userToken, marketId);

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, PhotosResultModel>> photo({
    @required String marketId,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      var result = await _remoteDataSource.getPhoto(marketId);

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, CommentsResultModel>> marketComments({
    @required String marketId,
    @required int page,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      var result = await _remoteDataSource.getListComment(marketId, page);

      return result != null
          ? Right(result)
          : Left(ApiFailure("failed to load comments"));
    }
  }

  Future<Either<Failure, dynamic>> addComment({
    @required String comment,
    @required int point,
    @required String marketId,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      var result = await _remoteDataSource.addComment(comment, point, marketId);

      return result != null ? Right(result) : Left(ApiFailure("failed to add"));
    }
  }
}
