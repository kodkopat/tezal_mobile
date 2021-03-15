import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tezal/models/CheckSmsModel.dart';
import 'package:tezal/services/DataService.dart';
import 'package:tezal/services/FlatColors.dart';
import 'package:http/http.dart' as http;

class ConfirmRegistration extends StatefulWidget {
  @override
  _ConfirmRegistrationState createState() => _ConfirmRegistrationState();
}

class _ConfirmRegistrationState extends State<ConfirmRegistration> {
  var smsController = TextEditingController();
  var storage = new FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: ListView(padding: EdgeInsets.all(15.0), children: [
          Center(
              child: Container(
            alignment: Alignment.centerRight,
            child: Text(
              "تایید ثبت‌نام",
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
              "کد تایید عضویت را وارد کنید",
              style: TextStyle(color: FlatColors.midnight_dark),
            ),
          )),
          Container(
            margin: EdgeInsets.only(top: 20),
            width: double.infinity,
            child: TextField(
                controller: smsController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 4,
                decoration: InputDecoration(
                  counterText: "",
                  hintText: 'کد تایید',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: FlatColors.orange_light)),
                )),
          ),
          Container(
            width: double.infinity,
            child: RaisedButton(
              color: FlatColors.orange_light,
              onPressed: () {
                storage.read(key: "userid").then((userid) {
                  if (userid != null) {
                    var adres =
                        DataService.customerBaseaddress + 'User/CheckSms';

                    http
                        .post(Uri.http(DataService.authority, adres),
                            headers: <String, String>{
                              'Content-Type': 'application/json; charset=UTF-8',
                              "accept": "text/plain"
                            },
                            body: jsonEncode(<String, String>{
                              'Sms': smsController.text,
                              'Id': userid,
                            }))
                        .then((res) {
                      if (res.statusCode == 200) {
                        var model =
                            CheckSmsModel.fromJson(json.decode(res.body));

                        if (model.success) {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (_) {
                                return AlertDialog(
                                  title: Text(
                                    "موفقیت",
                                    style: TextStyle(
                                        color: FlatColors.green_light),
                                  ),
                                  content: Text(
                                      "با موفقیت ثبت‌نام کردید. اکنون میتوانید خرید کنید"),
                                  elevation: 10,
                                  actions: [
                                    RaisedButton(
                                        color: FlatColors.orange_light,
                                        onPressed: () {
                                          storage
                                              .write(
                                                  key: 'token',
                                                  value: model.data.token)
                                              .then((value) {
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pop();
                                          });
                                        },
                                        child: Text(
                                          "قبول",
                                          style: TextStyle(
                                              color: FlatColors.white_light),
                                        )),
                                  ],
                                );
                              });
                        }
                        if (!model.success) {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (_) {
                                return AlertDialog(
                                  title: Text(
                                    "خطا",
                                    style:
                                        TextStyle(color: FlatColors.red_light),
                                  ),
                                  content: Text(
                                      "کد وارد شده صحیح نمیباشد. لطفا مجددا سعی نمایید"),
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
                      } else {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                title: Text(
                                  "خطا",
                                  style: TextStyle(color: FlatColors.red_light),
                                ),
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
                    });
                  }
                });
              },
              child: Text(
                "تایید",
                style: TextStyle(color: FlatColors.white_light),
              ),
            ),
          )
        ]));
  }
}
