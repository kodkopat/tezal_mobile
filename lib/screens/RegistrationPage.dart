import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tezal/screens/ConfirmRegistration.dart';
import 'package:tezal/services/DataService.dart';
import 'package:tezal/services/FlatColors.dart';
import 'package:tezal/services/RouteBuilderService.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool contractSigned = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  FocusNode _focusPhone = new FocusNode();
  FocusNode _focusName = new FocusNode();
  FocusNode _focusPass = new FocusNode();

  bool isPhoneValid = true;
  bool isNameValid = true;
  bool isPassValid = true;
  bool isFormWorking = true;
  bool isFormReady = false;
  var phoneController = TextEditingController();
  var nameController = TextEditingController();
  var passController = TextEditingController();
  var storage = new FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    _focusPhone.addListener(_onFocusChangePhone);
    _focusName.addListener(_onFocusChangeName);
    _focusPass.addListener(_onFocusChangePass);
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
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

  void _onFocusChangeName() {
    if (_focusName.hasFocus == false) {
      setState(() {
        isNameValid =
            !(nameController.text.isEmpty || nameController.text.length <= 2);
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
    ProgressDialog pr = ProgressDialog(context,
        isDismissible: false,
        type: ProgressDialogType.Normal,
        textDirection: TextDirection.rtl);
    pr.style(message: "لطفا کمی صبر کنید", textAlign: TextAlign.start);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.all(15.0),
        children: [
          Center(
              child: Container(
            alignment: Alignment.centerRight,
            child: Text(
              "ثبت نام",
              style: TextStyle(
                  color: FlatColors.midnight_dark,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          )),
          Center(
              child: Container(
            alignment: Alignment.centerRight,
            child: Text(
              "لطفا جهت ثبت نام شماره تلفن خود را وارد نمایید",
              style: TextStyle(color: FlatColors.midnight_dark),
            ),
          )),
          Center(
              child: Container(
            margin: EdgeInsets.only(top: 50),
            alignment: Alignment.centerRight,
            child: TextField(
                controller: phoneController,
                focusNode: _focusPhone,
                textAlign: TextAlign.center,
                maxLength: 11,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.phone_iphone),
                  counterText: "",
                  errorText:
                      isPhoneValid ? null : 'شماره تلفن وارده صحیح نمیباشد',
                  hintText: 'شماره تلفن',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: FlatColors.orange_light)),
                )),
          )),
          Center(
              child: Container(
            margin: EdgeInsets.only(top: 10),
            alignment: Alignment.centerRight,
            child: TextField(
                focusNode: _focusName,
                controller: nameController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  errorText: isNameValid ? null : 'نام وارده صحیح نمیباشد',
                  hintText: 'نام',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: FlatColors.orange_light)),
                )),
          )),
          Center(
              child: Container(
            margin: EdgeInsets.only(top: 10),
            alignment: Alignment.centerRight,
            child: TextField(
                keyboardType: TextInputType.number,
                controller: passController,
                focusNode: _focusPass,
                enableSuggestions: false,
                autocorrect: false,
                obscureText: true,
                textAlign: TextAlign.center,
                maxLength: 4,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.vpn_key),
                  counterText: "",
                  errorText: isPassValid ? null : 'رمز وارده صحیح نمیباشد',
                  hintText: 'رمز عبور',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: FlatColors.orange_light)),
                )),
          )),
          Row(
            children: [
              Checkbox(
                  value: contractSigned,
                  onChanged: (val) {
                    setState(() {
                      contractSigned = val;
                    });
                  }),
              Text(
                "تمامی قراردادهای قانونی را قبول میکنم",
                style: TextStyle(color: FlatColors.midnight_dark),
              )
            ],
          ),
          Center(
            child: InkWell(
              onTap: () {
                if (nameController.text.isNotEmpty &&
                    passController.text.isNotEmpty &&
                    phoneController.text.isNotEmpty &&
                    contractSigned) {
                  pr.show().then((value) {
                    var adres =
                        DataService.customerBaseaddress + 'User/Register';

                    http
                        .post(Uri.http(DataService.authority, adres),
                            headers: <String, String>{
                              'Content-Type': 'application/json; charset=UTF-8',
                              "accept": "text/plain"
                            },
                            body: jsonEncode(<String, String>{
                              'Phone': phoneController.text,
                              'Name': nameController.text,
                              'Pass': passController.text
                            }))
                        .then((res) {
                      var data = json.decode(res.body);
                      if (res.statusCode == 200 && data["success"] == true) {
                        pr.hide();
                        storage.write(
                            key: 'userid', value: data["data"].toString());
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                            RouteBuilderService.goto(ConfirmRegistration()));
                      }
                      if (res.statusCode != 200 ||
                          (res.statusCode == 200 && data["success"] == false)) {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                title: Text("خطا"),
                                content: Text(
                                    "خطایی در سیستم رخ داد. لطفا بعدا مجددا امتحان کنید"),
                                elevation: 10,
                                actions: [
                                  FlatButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("قبول"))
                                ],
                              );
                            });
                      }
                      pr.hide();
                    });
                  });
                }
              },
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
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
                        colors: (nameController.text.isNotEmpty &&
                                passController.text.isNotEmpty &&
                                phoneController.text.isNotEmpty &&
                                contractSigned)
                            ? [FlatColors.orange_light, FlatColors.orange_dark]
                            : [FlatColors.grey_dark, FlatColors.grey_light]),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Text(
                  "ثبت نام",
                  style: TextStyle(color: FlatColors.white_light),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
