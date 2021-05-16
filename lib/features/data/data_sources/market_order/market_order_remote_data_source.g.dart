// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_order_remote_data_source.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _MarketOrderRemoteDataSource implements MarketOrderRemoteDataSource {
  _MarketOrderRemoteDataSource(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://185.116.162.192/market/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<OrdersResultModel> getOrders(lang, token, skip, take, status,
      distanceAscending, dateAscescending, priceAscending) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'skip': skip,
      r'take': take,
      r'status': status,
      r'distanceAscending': distanceAscending,
      r'dateAscescending': dateAscescending,
      r'priceAscending': priceAscending
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<OrdersResultModel>(Options(
                method: 'GET',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain',
                  r'lang': lang,
                  r'token': token
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'Order/GetOrders',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = OrdersResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseApiResultModel> approveOrder(lang, token, id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'Id': id};
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
            .compose(_dio.options, 'Order/ApproveOrder',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseApiResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseApiResultModel> cancelOrderApprove(lang, token, id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'Id': id};
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
            .compose(_dio.options, 'Order/CancelOrderApprove',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseApiResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<OrderPhotosResultModel> getOrderPhotos(lang, token, orderId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'orderId': orderId};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<OrderPhotosResultModel>(Options(
                method: 'GET',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain',
                  r'lang': lang,
                  r'token': token
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'Order/GetOrderPhotos',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = OrderPhotosResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<dynamic> getOrderSummary(lang, token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
            method: 'GET',
            headers: <String, dynamic>{
              r'Content-Type': 'application/json',
              r'Accept': 'text/plain',
              r'lang': lang,
              r'token': token
            },
            extra: _extra,
            contentType: 'application/json')
        .compose(_dio.options, 'Order/GetOrderSummary',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<dynamic> getPostOrderSummary(lang, token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
            method: 'GET',
            headers: <String, dynamic>{
              r'Content-Type': 'application/json',
              r'Accept': 'text/plain',
              r'lang': lang,
              r'token': token
            },
            extra: _extra,
            contentType: 'application/json')
        .compose(_dio.options, 'Order/GetPostOrderSummary',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<dynamic> getOrderDetail(lang, token, id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'Id': id};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
            method: 'GET',
            headers: <String, dynamic>{
              r'Content-Type': 'application/json',
              r'Accept': 'text/plain',
              r'lang': lang,
              r'token': token
            },
            extra: _extra,
            contentType: 'application/json')
        .compose(_dio.options, 'Order/GetOrderDetail',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<BaseApiResultModel> rejectOrder(lang, token, id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'Id': id};
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
            .compose(_dio.options, 'Order/RejectOrder',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseApiResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseApiResultModel> prepareOrder(lang, token, id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'Id': id};
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
            .compose(_dio.options, 'Order/PrepareOrder',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseApiResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseApiResultModel> returnedOrderApprove(lang, token, id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'Id': id};
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
            .compose(_dio.options, 'Order/ReturnedOrderApprove',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseApiResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<OrderCommentsResultModel> getOrderComments(
      lang, token, orderId, skip, take) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'orderId': orderId,
      r'skip': skip,
      r'take': take
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<OrderCommentsResultModel>(Options(
                method: 'GET',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain',
                  r'lang': lang,
                  r'token': token
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'Order/GetOrderComments',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = OrderCommentsResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseApiResultModel> replyOrderComments(
      lang, token, commentId, reply) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'commentId': commentId, 'reply': reply};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseApiResultModel>(Options(
                method: 'POST',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain',
                  r'lang': lang,
                  r'token': token
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'Order/ReplyOrderComments',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseApiResultModel.fromJson(_result.data!);
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
