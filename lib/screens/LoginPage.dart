import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';

import '../app_localizations.dart';
import '../lang/Lang.dart';
import '../main.dart';
import '../models/LoginModel.dart';
import '../services/AuthService.dart';
import '../services/DataService.dart';
import '../services/FlatColors.dart';
import '../services/RouteBuilderService.dart';
import 'RegistrationPage.dart';

class LoginPagePage extends StatefulWidget {
  const LoginPagePage({
    Key key,
  }) : super(key: key);
  @override
  _LoginPagePageState createState() => _LoginPagePageState();
}

class _LoginPagePageState extends State<LoginPagePage> {
  var storage = new FlutterSecureStorage();

  var phoneController = TextEditingController();
  var passController = TextEditingController();
  FocusNode _focusPhone = new FocusNode();
  FocusNode _focusPass = new FocusNode();
  bool isPhoneValid = true;
  bool isPassValid = true;
  ProgressDialog pr;
  @override
  void initState() {
    super.initState();
    _focusPhone.addListener(_onFocusChangePhone);
    _focusPass.addListener(_onFocusChangePass);
  }

  void _onFocusChangePhone() {
    if (_focusPhone.hasFocus == false) {
      setState(() {
        isPhoneValid = !(phoneController.text.isEmpty ||
            phoneController.text.length < 11 ||
            !phoneController.text.startsWith("09"));
      });
    }
  }

  void _onFocusChangePass() {
    if (_focusPass.hasFocus == false) {
      setState(() {
        isPassValid =
            !(passController.text.isEmpty || passController.text.length < 4);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context,
        isDismissible: false,
        type: ProgressDialogType.Normal,
        textDirection: TextDirection.rtl);
    pr.style(message: Lang(context).loginProgress, textAlign: TextAlign.start);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FlatColors.white_light,
        elevation: 0,
      ),
      backgroundColor: FlatColors.white_light,
      body: ListView(
        padding: const EdgeInsets.all(10.0),
        children: [
          Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                      child: Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      Lang(context).loginWelcomeText,
                      style: TextStyle(
                          color: FlatColors.midnight_dark,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                      child: Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      Lang(context).loginWelcomeInformation,
                      style: TextStyle(
                        color: FlatColors.midnight_light,
                      ),
                    ),
                  )),
                )
              ],
            ),
          ),
          Container(
            height: 200,
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextField(
                controller: phoneController,
                focusNode: _focusPhone,
                textAlign: TextAlign.center,
                maxLength: 11,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.phone_iphone),
                  counterText: "",
                  errorText: isPhoneValid ? null : Lang(context).loginPhone,
                  hintText: Lang(context).loginPhoneHint,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: FlatColors.orange_light)),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextField(
                enableSuggestions: false,
                autocorrect: false,
                obscureText: true,
                controller: passController,
                focusNode: _focusPass,
                textAlign: TextAlign.center,
                maxLength: 4,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.vpn_key),
                  counterText: AppLocalizations.of(context).translate('key'),
                  errorText: isPhoneValid ? null : Lang(context).loginPass,
                  hintText: Lang(context).loginPassHint,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: FlatColors.orange_light)),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.8,
              height: 50,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: FlatColors.grey_dark,
                        blurRadius: 2,
                        spreadRadius: 1)
                  ],
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        FlatColors.orange_light,
                        FlatColors.orange_dark
                      ]),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () async {
                    await pr.show();
                    var adres = DataService.baseaddress + 'user/login';
                    var headers = await AuthService.getDefaultHeadersNoLocation(
                        context: context);
                    var body = jsonEncode(<String, dynamic>{
                      'Username': phoneController.text,
                      'Password': passController.text
                    });

                    var res = await http.post(
                        Uri.http(DataService.authority, adres),
                        headers: headers,
                        body: body);

                    if (res.statusCode == 200) {
                      var data = LoginModel.fromJson(json.decode(res.body));
                      if (data.success) {
                        await storage.write(
                            key: 'token', value: data.data.token);
                        await storage.write(
                            key: 'userinfo', value: res.body.toString());
                        await pr.hide();
                        Navigator.of(context).pop();
                        App.restart(context);
                      }
                    }
                  },
                  child: Center(
                    child: Text(
                      Lang(context).login,
                      style: TextStyle(color: FlatColors.white_light),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.8,
              height: 50,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: FlatColors.grey_dark,
                        blurRadius: 2,
                        spreadRadius: 1)
                  ],
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [FlatColors.blue_light, FlatColors.blue_dark]),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context, RouteBuilderService.goto(RegistrationPage()));
                  },
                  child: Center(
                    child: Text(
                      Lang(context).register,
                      style: TextStyle(color: FlatColors.white_light),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
