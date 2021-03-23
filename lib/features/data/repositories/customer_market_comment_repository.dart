import 'package:dartz/dartz.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../../core/exceptions/api_failure.dart';
import '../../../core/exceptions/connection_failure.dart';
import '../../../core/exceptions/failure.dart';
import '../data_sources/customer_market_comment/customer_market_comment_local_data_source.dart';
import '../data_sources/customer_market_comment/customer_market_comment_remote_data_source.dart';
import '../models/market_comments_result_model.dart';

class CustomerMarketCommentRepository {
  CustomerMarketCommentRepository()
      : _connectionChecker = DataConnectionChecker(),
        _remoteDataSource = CustomerMarketCommentRemoteDataSource(Dio()),
        _localDataSource = CustomerMarketCommentLocalDataSource();

  final String connectionFailedMsg = "دسترسی به اینترنت امکان‌پذیر نمی‌باشد!";
  final DataConnectionChecker _connectionChecker;
  final CustomerMarketCommentRemoteDataSource _remoteDataSource;
  // ignore: unused_field
  final CustomerMarketCommentLocalDataSource _localDataSource;

  Future<Either<Failure, MarketCommentsResultModel>> marketComments({
    @required int pageSize,
    @required int page,
    @required String orderBy,
    @required String marketId,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      var result = await _remoteDataSource.getListComment(
          pageSize, page, orderBy, marketId);

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
