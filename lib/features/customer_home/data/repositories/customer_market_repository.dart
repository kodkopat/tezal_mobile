import 'package:dartz/dartz.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../core/exceptions/api_failure.dart';
import '../../../../core/exceptions/connection_failure.dart';
import '../../../../core/exceptions/failure.dart';
import '../../../../core/services/location.dart';
import '../data_sources/customer_market_local_data_source.dart';
import '../data_sources/customer_market_remote_data_source.dart';
import '../models/market_detail_result_model.dart';
import '../models/nearby_markets_result_model.dart';
import '../models/photos_result_model.dart';

class CustomerMarketRepository {
  CustomerMarketRepository()
      : _connectionChecker = DataConnectionChecker(),
        _remoteDataSource = CustomerMarketRemoteDataSource(Dio()),
        _localDataSource = CustomerMarketLocalDataSource();

  final String connectionFailedMsg = "دسترسی به اینترنت امکان‌پذیر نمی‌باشد!";
  final DataConnectionChecker _connectionChecker;
  final CustomerMarketRemoteDataSource _remoteDataSource;
  final CustomerMarketLocalDataSource _localDataSource;

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

      var result = await _remoteDataSource.nearbyMarkets(
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
      var result = await _remoteDataSource.marketDetail(marketId);

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, List<int>>> photo({
    @required String marketId,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      var result = await _remoteDataSource.photo(marketId);

      return result != null
          ? Right(result)
          : Left(ApiFailure("Failed to Load Image!"));
    }
  }

  Future<Either<Failure, PhotosResultModel>> photos({
    @required String marketId,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      var result = await _remoteDataSource.photos(marketId);

      return result.success
          ? Right(result)
          : Left(ApiFailure("Failed to Load Image!"));
    }
  }
}
