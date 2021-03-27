import 'package:dartz/dartz.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../core/exceptions/api_failure.dart';
import '../../../core/exceptions/connection_failure.dart';
import '../../../core/exceptions/failure.dart';
import '../../../core/services/location.dart';
import '../data_sources/customer_search/customer_search_local_data_source.dart';
import '../data_sources/customer_search/customer_search_remote_data_source.dart';
import '../models/clear_search_terms_result_model.dart';
import '../models/search_result_model.dart';
import '../models/search_terms_result_model.dart';
import 'auth_repository.dart';

class CustomerSearchRepository {
  CustomerSearchRepository()
      : _connectionChecker = DataConnectionChecker(),
        _remoteDataSource = CustomerSearchRemoteDataSource(Dio()),
        _localDataSource = CustomerSearchLocalDataSource(),
        _authRepo = AuthRepository();

  final String connectionFailedMsg = "دسترسی به اینترنت امکان‌پذیر نمی‌باشد!";
  final DataConnectionChecker _connectionChecker;
  final CustomerSearchRemoteDataSource _remoteDataSource;
  // ignore: unused_field
  final CustomerSearchLocalDataSource _localDataSource;
  final AuthRepository _authRepo;

  Future<Either<Failure, SearchResultModel>> search(
    BuildContext context, {
    @required String term,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      var lang = Localizations.localeOf(context).languageCode;
      var position = await LocationService.getSavedLocation();

      var result = await _remoteDataSource.search(
        lang,
        "${position.latitude}",
        "${position.longitude}",
        term,
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, SearchTermsResultModel>> searchTerms(
    BuildContext context, {
    @required String term,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var lang = Localizations.localeOf(context).languageCode;
      var position = await LocationService.getSavedLocation();

      var result = await _remoteDataSource.getSearchTerms(
        userToken,
        lang,
        "${position.latitude}",
        "${position.longitude}",
      );

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, ClearSearchTermsResultModel>> clearSearchTerms({
    @required String term,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      var result = await _remoteDataSource.clearSearchTerms();

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }
}
