// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_market_remote_data_source.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _CustomerMarketRemoteDataSource
    implements CustomerMarketRemoteDataSource {
  _CustomerMarketRemoteDataSource(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'http://178.157.14.77/api/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<NearByMarketsResultModel> getNearByMarkets(
      token, lang, latitude, longitude, maxDistance, page) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(lang, 'lang');
    ArgumentError.checkNotNull(latitude, 'latitude');
    ArgumentError.checkNotNull(longitude, 'longitude');
    ArgumentError.checkNotNull(maxDistance, 'maxDistance');
    ArgumentError.checkNotNull(page, 'page');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'maxDistance': maxDistance,
      r'page': page
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'customer/Market/GetNearByMarkets',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'Content-Type': 'application/json',
              r'Accept': 'text/plain',
              r'token': token,
              r'lang': lang,
              r'latitude': latitude,
              r'longitude': longitude
            },
            extra: _extra,
            contentType: 'application/json',
            baseUrl: baseUrl),
        data: _data);
    final value = NearByMarketsResultModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<BaseApiResultModel> updateNearByMarkets(token) async {
    ArgumentError.checkNotNull(token, 'token');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'customer/Market/UpdateNearByMarkets',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'Content-Type': 'application/json',
              r'Accept': 'text/plain',
              r'token': token
            },
            extra: _extra,
            contentType: 'application/json',
            baseUrl: baseUrl),
        data: _data);
    final value = BaseApiResultModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<MarketDetailResultModel> getMarketDetail(token, id) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'Id': id};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'customer/Market/GetMarketDetail',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'Content-Type': 'application/json',
              r'Accept': 'text/plain',
              r'token': token
            },
            extra: _extra,
            contentType: 'application/json',
            baseUrl: baseUrl),
        data: _data);
    final value = MarketDetailResultModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<PhotosResultModel> getPhoto(id) async {
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'Id': id};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'customer/Market/GetPhoto',
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
    final value = PhotosResultModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<MarketCategoriesResultModel> getMarketCategories(marketId) async {
    ArgumentError.checkNotNull(marketId, 'marketId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'MarketId': marketId};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'customer/Market/GetMarketCategorys',
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
    final value = MarketCategoriesResultModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<CommentsResultModel> getListComment(marketId, page) async {
    ArgumentError.checkNotNull(marketId, 'marketId');
    ArgumentError.checkNotNull(page, 'page');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'MarketId': marketId,
      r'Page': page
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'customer/Market/GetComments',
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
    final value = CommentsResultModel.fromJson(_result.data);
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
    final _result = await _dio.request('customer/Market/AddComment',
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
