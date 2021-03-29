// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_campaign_remote_data_source.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _CustomerCampaignRemoteDataSource
    implements CustomerCampaignRemoteDataSource {
  _CustomerCampaignRemoteDataSource(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'http://178.157.14.77/api/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<CampaignResultModel> getall(token) async {
    ArgumentError.checkNotNull(token, 'token');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'customer/Campaign/Getall',
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
    final value = CampaignResultModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<PhotosResultModel> getPhoto(campaignId) async {
    ArgumentError.checkNotNull(campaignId, 'campaignId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'Id': campaignId};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'customer/Campaign/GetPhoto',
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
}
