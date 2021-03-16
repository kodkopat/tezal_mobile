import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../lang/Lang.dart';
import '../../models/Customer/CustomerProfileModel.dart';
import '../../services/AlertService.dart';
import '../../services/AuthService.dart';
import '../../services/DataService.dart';
import '../../services/FlatColors.dart';
import 'widgets/AppBarNew.dart';

class PrivateInfoPage extends StatefulWidget {
  @override
  _PrivateInfoPageState createState() => _PrivateInfoPageState();
}

class _PrivateInfoPageState extends State<PrivateInfoPage> {
  _PrivateInfoPageState();
  final _formKey = GlobalKey<FormState>();
  bool saving = false;
  bool readData = false;
  TextEditingController name = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController email = new TextEditingController();
  CustomerProfileModel oldData;
  Future<CustomerProfileModel> getData() async {
    if (oldData == null || readData) {
      var headers = await AuthService.getDefaultHeadersNoLocation();
      var adres =
          DataService.customerBaseaddress + 'Customer/getCustomerProfile';
      var res = await http.get(Uri.http(DataService.authority, adres),
          headers: headers);
      if (res.statusCode == 200) {
        var oldData = CustomerProfileModel.fromJson(json.decode(res.body));
        name.text = oldData.data.name;
        phone.text = oldData.data.phone;
        email.text = oldData.data.email;
        return oldData;
      }
    }

    return oldData;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (context, AsyncSnapshot<CustomerProfileModel> res) {
          if (res.connectionState == ConnectionState.done) {
            return buildScaffold(res.data);
          } else {
            return Scaffold(
              appBar: AppBarNew(
                title: Lang(context).privateInfo,
              ),
              body: Center(child: CircularProgressIndicator()),
            );
          }
        });
  }

  Widget buildScaffold(CustomerProfileModel res) {
    return Scaffold(
      appBar: AppBarNew(
        title: Lang(context).privateInfo,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(Lang(context).name + ' :'),
                TextFormField(
                  controller: name,
                  decoration: InputDecoration(hintText: Lang(context).name),
                  validator: (value) {
                    if (value.isEmpty) {
                      return Lang(context).invalidName;
                    }
                    return null;
                  },
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(Lang(context).phone + ' :'),
                TextFormField(
                  controller: phone,
                  enabled: false,
                  textDirection: TextDirection.ltr,
                  decoration: InputDecoration(hintText: Lang(context).phone),
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(Lang(context).email + ' :'),
                TextFormField(
                  controller: email,
                  textDirection: TextDirection.ltr,
                  validator: (value) {
                    if (!EmailValidator.validate(value)) {
                      return Lang(context).invalidMail;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: Lang(context).email,
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Card(
              color: FlatColors.green_dark,
              child: InkWell(
                onTap: () async {
                  save();
                },
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (saving)
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                      if (!saving)
                        Text(
                          Lang(context).save,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20),
                        ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future save() async {
    if (_formKey.currentState.validate()) {
      var headers =
          await AuthService.getDefaultHeadersNoLocation(context: context);
      var body =
          jsonEncode(<String, dynamic>{'name': name.text, 'email': email.text});
      var adres =
          DataService.customerBaseaddress + 'Customer/ChangeCustomerProfile';
      var res = await http.post(Uri.http(DataService.authority, adres),
          headers: headers, body: body);

      if (res.statusCode == 200) {
        var data = json.decode(res.body);

        if (data["success"].toString().toLowerCase() == 'true') {
          Navigator.pop(context);
        } else {
          AlertService.showError(
              context, Lang(context).error, data["message"].toString(), () {
            Navigator.of(context).pop();
            setState(() {
              saving = false;
            });
          });
        }
      }
    }
  }
}
