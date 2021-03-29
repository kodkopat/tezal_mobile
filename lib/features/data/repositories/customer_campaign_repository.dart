import 'package:dartz/dartz.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../../core/exceptions/api_failure.dart';
import '../../../core/exceptions/connection_failure.dart';
import '../../../core/exceptions/failure.dart';
import '../data_sources/customer_campaign/customer_campaign_local_data_source.dart';
import '../data_sources/customer_campaign/customer_campaign_remote_data_source.dart';
import '../models/campaign_result_model.dart';
import '../models/photos_result_model.dart';
import 'auth_repository.dart';

class CustomerCampaignRepository {
  CustomerCampaignRepository()
      : _connectionChecker = DataConnectionChecker(),
        _remoteDataSource = CustomerCampaignRemoteDataSource(Dio()),
        _localDataSource = CustomerCampaignLocalDataSource(),
        _authRepo = AuthRepository();

  final String connectionFailedMsg = "دسترسی به اینترنت امکان‌پذیر نمی‌باشد!";
  final DataConnectionChecker _connectionChecker;
  final CustomerCampaignRemoteDataSource _remoteDataSource;
  // ignore: unused_field
  final CustomerCampaignLocalDataSource _localDataSource;
  final AuthRepository _authRepo;

  Future<Either<Failure, CampaignResultModel>> get campaignes async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      final userToken = await _authRepo.userToken;
      var result = await _remoteDataSource.getall(userToken);

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }

  Future<Either<Failure, PhotosResultModel>> campaignPhoto({
    @required String campaignId,
  }) async {
    if (!await _connectionChecker.hasConnection) {
      return Left(ConnectionFailure(connectionFailedMsg));
    } else {
      var result = await _remoteDataSource.getPhoto(campaignId);

      return result.success ? Right(result) : Left(ApiFailure(result.message));
    }
  }
}
