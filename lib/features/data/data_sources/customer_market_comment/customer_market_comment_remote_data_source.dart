import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../../../core/consts/consts.dart';
import '../../models/market_comments_result_model.dart';

part 'customer_market_comment_remote_data_source.g.dart';

@RestApi(baseUrl: apiBaseUrl)
abstract class CustomerMarketCommentRemoteDataSource {
  factory CustomerMarketCommentRemoteDataSource(Dio dio, {String baseUrl}) =
      _CustomerMarketCommentRemoteDataSource;

  static const _apiUrlPrefix = "customer/MarketComment";

  @GET("$_apiUrlPrefix/GetListComment")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<MarketCommentsResultModel> getListComment(
    @Query("PageSize") int pageSize,
    @Query("Page") int page,
    @Query("OrderBy") String orderBy,
    @Query("marketId") String marketId,
  );

  @GET("$_apiUrlPrefix/AddComment")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> addComment(
    @Field() String comment,
    @Field() int point,
    @Field() String marketId,
  );
}
