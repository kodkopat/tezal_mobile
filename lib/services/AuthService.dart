import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:tezal/models/CheckTokenModel.dart';
import 'package:tezal/models/LoginModel.dart';
import 'package:tezal/screens/LoginPage.dart';
import 'package:tezal/services/DataService.dart';
import 'package:tezal/services/LocationService.dart';
import 'package:tezal/services/RouteBuilderService.dart';

import 'DataService.dart';

class AuthService {
  AuthService() {}
  static Future<bool> isLoggedIn() async {
    FlutterSecureStorage storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'token');

    if (token != null) {
      var res = await http.post(
          Uri.http(DataService.authority,
              DataService.baseaddress + 'user/CheckToken'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "accept": "text/plain"
          },
          body: jsonEncode(<String, String>{
            'Token': token,
          }));
      if (res.statusCode == 200) {
        var model = CheckTokenModel.fromJson(json.decode(res.body));
        if (model.success) {
          await storage.write(key: 'userinfo', value: res.body);
          return true;
        }
      }
    }
    return false;
  }

  static Future<LoginModel> geuUserInfo() async {
    var storage = new FlutterSecureStorage();
    var userinfo = await storage.read(key: 'userinfo');
    if (userinfo != null && userinfo.isNotEmpty)
      return LoginModel.fromJson(json.decode(userinfo));
    return null;
  }

  static Future<Map> getDefaultHeaders() async {
    var pos = await LocationService.getSavedLocation();
    var headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'accept': 'text/plain',
      'longitude': pos.longitude.toString(),
      'latitude': pos.latitude.toString()
    };
    var userinfo = await AuthService.geuUserInfo();
    if (userinfo != null) {
      // if (userinfo.data.type == UserType.customer &&
      if (await AuthService.isLoggedIn()) {
        headers.addAll({'token': userinfo.data.token});
      }
    }
    return headers;
  }

  static Future<Map> getDefaultHeadersNoLocation({BuildContext context}) async {
    var headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'accept': 'text/plain',
      if (context != null) 'lang': Localizations.localeOf(context).languageCode
    };
    var userinfo = await AuthService.geuUserInfo();

    if (userinfo != null) {
      //if (userinfo.data.type == UserType.customer &&
      if (await AuthService.isLoggedIn()) {
        headers.addAll({'token': userinfo.data.token});
      }
    }
    return headers;
  }

  static Future<bool> mustLogin(BuildContext context) async {
    var islogin = await isLoggedIn();
    if (!islogin)
      Navigator.push(context, RouteBuilderService.goto(LoginPagePage()));

    return islogin;
  }
}
