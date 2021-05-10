// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_remote_data_source.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _MarketRemoteDataSource implements MarketRemoteDataSource {
  _MarketRemoteDataSource(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://185.116.162.192/market/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<MarketProfileResultModel> getMarketProfile(token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<MarketProfileResultModel>(Options(
                method: 'GET',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain',
                  r'token': token
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'Market/GetMarketProfile',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = MarketProfileResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseApiResultModel> changeMarketProfile(
      token, id, name, phone, telephone, email, address) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = {
      'id': id,
      'name': name,
      'phone': phone,
      'telephone': telephone,
      'email': email,
      'address': address
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseApiResultModel>(Options(
                method: 'POST',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain',
                  r'token': token
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'Market/ChangeMarketProfile',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseApiResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseApiResultModel> openCloseMarket(token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseApiResultModel>(Options(
                method: 'POST',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain',
                  r'token': token
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'Market/OpenCloseMarket',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseApiResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseApiResultModel> updateMarketDefaultHours(
      token, defaultHours) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = defaultHours.map((e) => e.toJson()).toList();
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseApiResultModel>(Options(
                method: 'POST',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain',
                  r'token': token
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'Market/UpdateMarketDefaultHours',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseApiResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<MarketDefaultHoursResultModel> getMarketDefaultHours(token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<MarketDefaultHoursResultModel>(Options(
                method: 'GET',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain',
                  r'token': token
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'Market/GetMarketDefaultHours',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = MarketDefaultHoursResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<MarketPhotosResultModel> getMarketPhotos(token, skip, take) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'skip': skip, r'take': take};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<MarketPhotosResultModel>(Options(
                method: 'POST',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain',
                  r'token': token
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'Market/GetMarketPhotos',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = MarketPhotosResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<MarketPhotoResultModel> getMarketPhoto(token, photoId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'photoId': photoId};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<MarketPhotoResultModel>(Options(
                method: 'POST',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain',
                  r'token': token
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'Market/GetMarketPhotos',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = MarketPhotoResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AddPhotoResultModel> addMarketPhoto(token, photo) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = FormData();
    _data.files.add(MapEntry(
        'photo',
        MultipartFile.fromFileSync(photo.path,
            filename: photo.path.split(Platform.pathSeparator).last)));
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AddPhotoResultModel>(Options(
                method: 'POST',
                headers: <String, dynamic>{
                  r'Content-Type': 'multipart/form-data',
                  r'Accept': 'text/plain',
                  r'token': token
                },
                extra: _extra,
                contentType: 'multipart/form-data')
            .compose(_dio.options, 'Market/AddMarketPhoto',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AddPhotoResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseApiResultModel> removeMarketPhoto(token, photoId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'photoId': photoId};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseApiResultModel>(Options(
                method: 'DELETE',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain',
                  r'token': token
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'Market/RemoveMarketPhoto',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseApiResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<MarketCommentsResultModel> getMarketComments(token, skip, take) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'skip': skip, r'take': take};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<MarketCommentsResultModel>(Options(
                method: 'GET',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain',
                  r'token': token
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'Market/GetMarketComments',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = MarketCommentsResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseApiResultModel> replyMarketComment(token, commentId, reply) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'commentId': commentId, 'reply': reply};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseApiResultModel>(Options(
                method: 'POST',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain',
                  r'token': token
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'Market/ReplyMarketComment',
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
