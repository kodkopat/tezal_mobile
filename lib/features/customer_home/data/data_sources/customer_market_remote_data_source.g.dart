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
  Future<NearByMarketsResultModel> nearbyMarkets(
      lang, latitude, longitude, maxDistance, count) async {
    ArgumentError.checkNotNull(lang, 'lang');
    ArgumentError.checkNotNull(latitude, 'latitude');
    ArgumentError.checkNotNull(longitude, 'longitude');
    ArgumentError.checkNotNull(maxDistance, 'maxDistance');
    ArgumentError.checkNotNull(count, 'count');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'maxDistance': maxDistance,
      r'count': count
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
}
