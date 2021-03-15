import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tezal/lang/Lang.dart';
import 'package:tezal/models/Customer/AddressListModel.dart';
import 'package:tezal/models/Customer/PaymentInfoModel.dart';
import 'package:tezal/screens/Customer/NewAddress.dart';
import 'package:tezal/screens/Customer/widgets/AppBarNew.dart';
import 'package:tezal/services/AlertService.dart';
import 'package:tezal/services/AuthService.dart';
import 'package:tezal/services/DataService.dart';
import 'package:tezal/services/FlatColors.dart';
import 'package:http/http.dart' as http;

class Addresses extends StatefulWidget {
  @override
  _AddressesState createState() => _AddressesState();
}

class _AddressesState extends State<Addresses> {
  AddressListModel oldData;
  bool updateData = true;
  bool paymentLoading = false;
  Future<AddressListModel> gePaymentInfo() async {
    if (oldData == null || updateData == true) {
      var headers = await AuthService.getDefaultHeadersNoLocation();
      var adres = DataService.customerBaseaddress + 'address/getAddressess';
      var res = await http.get(Uri.http(DataService.authority, adres),
          headers: headers);
      if (res.statusCode == 200) {
        oldData = AddressListModel.fromJson(json.decode(res.body));
      }
    }
    return oldData;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: gePaymentInfo(),
        builder: (context, AsyncSnapshot<AddressListModel> res) {
          if (res.connectionState == ConnectionState.done) {
            return buildScaffold(res.data, false);
          }
          if (res.connectionState == ConnectionState.waiting &&
              oldData != null) {
            return buildScaffold(oldData, true);
          } else {
            return Scaffold(
              appBar: AppBarNew(
                title: Lang(context).pay,
              ),
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }

  Scaffold buildScaffold(AddressListModel model, bool loading) {
    return Scaffold(
      appBar: AppBarNew(
        title: Lang(context).pay,
      ),
      body: Stack(
        children: [
          ListView(
              shrinkWrap: true,
              children: List.generate(model.data.length, (index) {
                return Card(
                  child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  model.data[index].name,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  model.data[index].address,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey),
                                )
                              ],
                            ),
                            Spacer(),
                            IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: FlatColors.green_light,
                                ),
                                onPressed: () {
                                  Navigator.of(context)
                                      .push(
                                    new MaterialPageRoute(
                                        builder: (_) => Newaddress(
                                              id: model.data[index].id,
                                            )),
                                  )
                                      .then((val) {
                                    setState(() {});
                                  });
                                }),
                            IconButton(
                                icon: Icon(
                                  Icons.delete_outline,
                                  color: FlatColors.orange_light,
                                ),
                                onPressed: () {
                                  AlertService.showConfirm(
                                      context,
                                      Lang(context).question,
                                      Lang(context).deleteQuestion, () async {
                                    Navigator.pop(context);
                                    var headers = await AuthService
                                        .getDefaultHeadersNoLocation(
                                            context: context);
                                    var adres =
                                        DataService.customerBaseaddress +
                                            'Address/RemoveAddress';
                                    debugPrint(adres);
                                    var res = await http.get(
                                        Uri.http(DataService.authority, adres,
                                            {'Id': model.data[index].id}),
                                        headers: headers);
                                    var jsn = json.decode(res.body);
                                    debugPrint(res.body);
                                    if (res.statusCode == 200 &&
                                        jsn["success"].toString() == 'true') {
                                      setState(() {});
                                    } else {
                                      AlertService.showError(
                                          context,
                                          Lang(context).error,
                                          jsn["message"].toString(), () {
                                        Navigator.pop(context);
                                        setState(() {});
                                      });
                                    }
                                  });
                                })
                          ],
                        ),
                      )),
                );
              })),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white,
              height: 80,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Card(
                  color: FlatColors.green_dark,
                  child: RaisedButton(
                    onPressed: () async {
                      Navigator.of(context)
                          .push(
                        new MaterialPageRoute(builder: (_) => Newaddress()),
                      )
                          .then((val) {
                        setState(() {});
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (paymentLoading)
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
                        if (!paymentLoading)
                          Text(
                            Lang(context).newAddress,
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                                fontSize: 20),
                          ),
                      ],
                    ),
                    color: FlatColors.green_dark,
                  ),
                ),
              ),
            ),
          ),
          if (loading && updateData)
            Container(
                width: double.infinity,
                height: double.infinity,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
                color: FlatColors.green_light.withOpacity(0.2)),
        ],
      ),
    );
  }
}
