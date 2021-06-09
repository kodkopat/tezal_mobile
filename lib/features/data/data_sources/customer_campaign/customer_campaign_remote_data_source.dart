import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../../../core/consts/consts.dart';
import '../../models/customer/campaign_result_model.dart';
import '../../models/customer/photos_result_model.dart';

part 'customer_campaign_remote_data_source.g.dart';

@RestApi(baseUrl: customerBaseApiUrl)
abstract class CustomerCampaignRemoteDataSource {
  factory CustomerCampaignRemoteDataSource(Dio dio, {String? baseUrl}) =
      _CustomerCampaignRemoteDataSource;

  static const _apiUrlPrefix = "Campaign";

  @GET("$_apiUrlPrefix/Getall")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<CampaignResultModel> getall(
    @Header("lang") String? lang,
    @Header("token") String? token,
  );

  @GET("$_apiUrlPrefix/GetPhoto")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<PhotosResultModel> getPhoto(
    @Header("lang") String? lang,
    @Query("Id") String campaignId,
  );
}
