// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_market_remote_data_source.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _CustomerMarketRemoteDataSource
    implements CustomerMarketRemoteDataSource {
  _CustomerMarketRemoteDataSource(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://185.116.162.30/customer/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<BaseApiResultModel> like(lang, token, marketId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'marketId': marketId};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseApiResultModel>(Options(
                method: 'GET',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain',
                  r'lang': lang,
                  r'token': token
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'Market/Like',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseApiResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<MarketCategoriesResultModel> getMarketCategories(lang, token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<MarketCategoriesResultModel>(Options(
                method: 'GET',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain',
                  r'lang': lang,
                  r'token': token
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'Market/GetMarketCategories',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = MarketCategoriesResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<List<int>> getMarketCategoryPhoto(
      lang, token, marketCategoryId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'MarketCategoryId': marketCategoryId
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(_setStreamType<List<int>>(
        Options(
                method: 'GET',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain',
                  r'lang': lang,
                  r'token': token
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'Market/GetMarketCategoryPhoto',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!.cast<int>();
    return value;
  }

  @override
  Future<NearByMarketsResultModel> getNearByMarkets(lang, token, latitude,
      longitude, marketCategoryId, maxDistance, page) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'MarketCategoryId': marketCategoryId,
      r'maxDistance': maxDistance,
      r'page': page
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<NearByMarketsResultModel>(Options(
                method: 'GET',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain',
                  r'lang': lang,
                  r'token': token,
                  r'latitude': latitude,
                  r'longitude': longitude
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'Market/GetNearByMarkets',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = NearByMarketsResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseApiResultModel> updateNearByMarkets(lang, token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseApiResultModel>(Options(
                method: 'GET',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain',
                  r'lang': lang,
                  r'token': token
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'Market/UpdateNearByMarkets',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseApiResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<MarketDetailResultModel> getMarketDetail(lang, token, id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'Id': id};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<MarketDetailResultModel>(Options(
                method: 'GET',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain',
                  r'lang': lang,
                  r'token': token
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'Market/GetMarketDetail',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = MarketDetailResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PhotosResultModel> getPhoto(lang, id, multi) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'Id': id, r'Multi': multi};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PhotosResultModel>(Options(
                method: 'GET',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain',
                  r'lang': lang
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'Market/GetPhoto',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PhotosResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CommentsResultModel> getComments(
      lang, token, marketId, skip, take) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'MarketId': marketId,
      r'skip': skip,
      r'take': take
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommentsResultModel>(Options(
                method: 'GET',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain',
                  r'lang': lang,
                  r'token': token
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'Market/GetComments',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CommentsResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AddEditCommentRateResultModel> addEditCommentRate(
      lang, token, comment, orderId, rate) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'comment': comment, 'orderId': orderId, 'rate': rate};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AddEditCommentRateResultModel>(Options(
                method: 'POST',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain',
                  r'lang': lang,
                  r'token': token
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'Market/AddEditCommentRate',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AddEditCommentRateResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<MainCategoryDetailResultModel> getMainCategoryDetail(
      lang, token, marketId, mainCategoryId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'MarketId': marketId,
      r'MainCategoryId': mainCategoryId
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<MainCategoryDetailResultModel>(Options(
                method: 'GET',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain',
                  r'lang': lang,
                  r'token': token
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'Market/GetMainCategoryDetail',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = MainCategoryDetailResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SubCategoryDetailResultModel> getSubCategoryDetail(
      lang, token, marketId, subCategoryId, page) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'MarketId': marketId,
      r'SubCategoryId': subCategoryId,
      r'Page': page
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SubCategoryDetailResultModel>(Options(
                method: 'GET',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain',
                  r'lang': lang,
                  r'token': token
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'Market/GetSubCategoryDetail',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SubCategoryDetailResultModel.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
