// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_market_comment_remote_data_source.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _CustomerMarketCommentRemoteDataSource
    implements CustomerMarketCommentRemoteDataSource {
  _CustomerMarketCommentRemoteDataSource(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'http://178.157.14.77/api/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<MarketCommentsResultModel> getListComment(
      pageSize, page, orderBy, marketId) async {
    ArgumentError.checkNotNull(pageSize, 'pageSize');
    ArgumentError.checkNotNull(page, 'page');
    ArgumentError.checkNotNull(orderBy, 'orderBy');
    ArgumentError.checkNotNull(marketId, 'marketId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'PageSize': pageSize,
      r'Page': page,
      r'OrderBy': orderBy,
      r'marketId': marketId
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'customer/MarketComment/GetListComment',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'Content-Type': 'application/json',
              r'Accept': 'text/plain'
            },
            extra: _extra,
            contentType: 'application/json',
            baseUrl: baseUrl),
        data: _data);
    final value = MarketCommentsResultModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<dynamic> addComment(comment, point, marketId) async {
    ArgumentError.checkNotNull(comment, 'comment');
    ArgumentError.checkNotNull(point, 'point');
    ArgumentError.checkNotNull(marketId, 'marketId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'comment': comment, 'point': point, 'marketId': marketId};
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request('customer/MarketComment/AddComment',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'Content-Type': 'application/json',
              r'Accept': 'text/plain'
            },
            extra: _extra,
            contentType: 'application/json',
            baseUrl: baseUrl),
        data: _data);
    final value = _result.data;
    return value;
  }
}
