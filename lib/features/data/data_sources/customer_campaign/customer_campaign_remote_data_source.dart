import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../../../core/consts/consts.dart';
import '../../models/campaign_result_model.dart';
import '../../models/photos_result_model.dart';

part 'customer_campaign_remote_data_source.g.dart';

@RestApi(baseUrl: apiBaseUrl)
abstract class CustomerCampaignRemoteDataSource {
  factory CustomerCampaignRemoteDataSource(Dio dio, {String baseUrl}) =
      _CustomerCampaignRemoteDataSource;

  static const _apiUrlPrefix = "customer/Campaign";

  @GET("$_apiUrlPrefix/Getall")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<CampaignResultModel> getall(
    @Header("token") String token,
  );

  @GET("$_apiUrlPrefix/GetPhoto")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<PhotosResultModel> getPhoto(
    @Query("Id") String campaignId,
  );
}